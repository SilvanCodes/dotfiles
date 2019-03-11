{-# LANGUAGE FlexibleInstances, MultiParamTypeClasses #-}

import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Util.Run(spawnPipe)
import System.IO
import XMonad.Layout.NoBorders
import XMonad.Layout.Gaps
import Control.Arrow ((***), second)
import qualified XMonad.StackSet as W
import XMonad.Prompt.Shell
import XMonad.Prompt.RunOrRaise
import XMonad.Prompt.AppLauncher as AL
import XMonad.Util.EZConfig

-- myLayouts = Tall 1 (3/100) (1/2) ||| (gaps [(U,250), (L,900), (D,250), (R,900)] $ Full)
myLayouts = smartBorders $ gaps [(U,18)] $ rightMaster ||| Full ||| focus
    where
    -- default tiling algorithm partitions the screen into two panes
    rightMaster   = Flip $ Tall nmaster delta ratio

    -- The default number of windows in the master pane
    nmaster = 1

    -- Default proportion of screen occupiQed by master pane
    ratio   = 1/2

    -- Percent of screen to increment by when resizing panes
    delta   = 3/100

    -- narrowed center view
    focus   = (gaps [(U,250), (L,900), (D,250), (R,900)] $ Full)

-- | Flip a layout, compute its 180 degree rotated form.
newtype Flip l a = Flip (l a) deriving (Show, Read)

instance LayoutClass l a => LayoutClass (Flip l) a where
    runLayout (W.Workspace i (Flip l) ms) r = (map (second flipRect) *** fmap Flip)
                                                `fmap` runLayout (W.Workspace i l ms) (flipRect r)
                                         where screenWidth = fromIntegral $ rect_width r
                                               flipRect (Rectangle rx ry rw rh) = Rectangle (screenWidth - rx - (fromIntegral rw)) ry rw rh
    handleMessage (Flip l) = fmap (fmap Flip) . handleMessage l
    description (Flip l) = "Flip "++ description l


main = do
  xmproc <- spawn "urxvtd"
  xmproc <- spawnPipe "/usr/bin/xmobar /home/$USER/.xmobarrc"
  xmonad $ def
    { modMask = mod4Mask     -- Rebind Mod to the Windows key
    , terminal = "urxvt"
    , logHook = dynamicLogWithPP xmobarPP
      { ppOutput = hPutStrLn xmproc
      , ppTitle = xmobarColor "green" "" . shorten 50
      }
     , layoutHook = myLayouts
    } `additionalKeys`
    [ ((mod4Mask, xK_e), spawn "waterfox")  -- type mod+x then w to pop up 'woohoo!'
    , ((mod4Mask, xK_w), spawn "urxvtc")  -- type mod+x then w to pop up 'woohoo!'
    , ((mod4Mask .|. shiftMask, xK_BackSpace), AL.launchApp def "waterfox")
    , ((mod4Mask, xK_g), AL.launchApp def "waterfox" )
    ]
    