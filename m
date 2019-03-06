From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH] drivers: video: fbdev: Kconfig: pedantic cleanups
Date: Wed,  6 Mar 2019 20:01:48 +0100
Message-ID: <1551898908-24695-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/video/fbdev/Kconfig                       | 288 +++++++++++-----------
 drivers/video/fbdev/mmp/Kconfig                   |   6 +-
 drivers/video/fbdev/omap/Kconfig                  |  20 +-
 drivers/video/fbdev/omap2/omapfb/Kconfig          |  18 +-
 drivers/video/fbdev/omap2/omapfb/displays/Kconfig |  40 +--
 drivers/video/fbdev/omap2/omapfb/dss/Kconfig      |   6 +-
 6 files changed, 188 insertions(+), 190 deletions(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index ae7712c..b53d552 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -45,25 +45,25 @@ menuconfig FB
 	  device-aware may cause unexpected results. If unsure, say N.
 
 config FIRMWARE_EDID
-       bool "Enable firmware EDID"
-       depends on FB
-       ---help---
-         This enables access to the EDID transferred from the firmware.
-	 On the i386, this is from the Video BIOS. Enable this if DDC/I2C
-	 transfers do not work for your driver and if you are using
-	 nvidiafb, i810fb or savagefb.
-
-	 In general, choosing Y for this option is safe.  If you
-	 experience extremely long delays while booting before you get
-	 something on your display, try setting this to N.  Matrox cards in
-	 combination with certain motherboards and monitors are known to
-	 suffer from this problem.
+	bool "Enable firmware EDID"
+	depends on FB
+	---help---
+	  This enables access to the EDID transferred from the firmware.
+	  On the i386, this is from the Video BIOS. Enable this if DDC/I2C
+	  transfers do not work for your driver and if you are using
+	  nvidiafb, i810fb or savagefb.
+
+	  In general, choosing Y for this option is safe.  If you
+	  experience extremely long delays while booting before you get
+	  something on your display, try setting this to N.  Matrox cards in
+	  combination with certain motherboards and monitors are known to
+	  suffer from this problem.
 
 config FB_DDC
-       tristate
-       depends on FB
-       select I2C_ALGOBIT
-       select I2C
+	tristate
+	depends on FB
+	select I2C_ALGOBIT
+	select I2C
 
 config FB_BOOT_VESA_SUPPORT
 	bool
@@ -160,8 +160,8 @@ config FB_LITTLE_ENDIAN
 endchoice
 
 config FB_SYS_FOPS
-       tristate
-       depends on FB
+	tristate
+	depends on FB
 
 config FB_DEFERRED_IO
 	bool
@@ -180,8 +180,8 @@ config FB_SVGALIB
 	  cards.
 
 config FB_MACMODES
-       tristate
-       depends on FB
+	tristate
+	depends on FB
 
 config FB_BACKLIGHT
 	tristate
@@ -190,31 +190,31 @@ config FB_BACKLIGHT
 	select BACKLIGHT_CLASS_DEVICE
 
 config FB_MODE_HELPERS
-        bool "Enable Video Mode Handling Helpers"
-        depends on FB
+	bool "Enable Video Mode Handling Helpers"
+	depends on FB
 	---help---
 	  This enables functions for handling video modes using the
 	  Generalized Timing Formula and the EDID parser. A few drivers rely
-          on this feature such as the radeonfb, rivafb, and the i810fb. If
+	  on this feature such as the radeonfb, rivafb, and the i810fb. If
 	  your driver does not take advantage of this feature, choosing Y will
 	  just increase the kernel size by about 5K.
 
 config FB_TILEBLITTING
-       bool "Enable Tile Blitting Support"
-       depends on FB
-       ---help---
-         This enables tile blitting.  Tile blitting is a drawing technique
-	 where the screen is divided into rectangular sections (tiles), whereas
-	 the standard blitting divides the screen into pixels. Because the
-	 default drawing element is a tile, drawing functions will be passed
-	 parameters in terms of number of tiles instead of number of pixels.
-	 For example, to draw a single character, instead of using bitmaps,
-	 an index to an array of bitmaps will be used.  To clear or move a
-	 rectangular section of a screen, the rectangle will be described in
-	 terms of number of tiles in the x- and y-axis.
-
-	 This is particularly important to one driver, matroxfb.  If
-	 unsure, say N.
+	bool "Enable Tile Blitting Support"
+	depends on FB
+	---help---
+	  This enables tile blitting.  Tile blitting is a drawing technique
+	  where the screen is divided into rectangular sections (tiles), whereas
+	  the standard blitting divides the screen into pixels. Because the
+	  default drawing element is a tile, drawing functions will be passed
+	  parameters in terms of number of tiles instead of number of pixels.
+	  For example, to draw a single character, instead of using bitmaps,
+	  an index to an array of bitmaps will be used.  To clear or move a
+	  rectangular section of a screen, the rectangle will be described in
+	  terms of number of tiles in the x- and y-axis.
+
+	  This is particularly important to one driver, matroxfb.  If
+	  unsure, say N.
 
 comment "Frame buffer hardware drivers"
 	depends on FB
@@ -226,7 +226,7 @@ config FB_GRVGA
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
 	---help---
-	This enables support for the SVGACTRL framebuffer in the GRLIB IP library from Aeroflex Gaisler.
+	  This enables support for the SVGACTRL framebuffer in the GRLIB IP library from Aeroflex Gaisler.
 
 config FB_CIRRUS
 	tristate "Cirrus Logic support"
@@ -655,17 +655,17 @@ config FB_EFI
 	  using the EFI framebuffer as your console.
 
 config FB_N411
-       tristate "N411 Apollo/Hecuba devkit support"
-       depends on FB && X86 && MMU
-       select FB_SYS_FILLRECT
-       select FB_SYS_COPYAREA
-       select FB_SYS_IMAGEBLIT
-       select FB_SYS_FOPS
-       select FB_DEFERRED_IO
-       select FB_HECUBA
-       help
-         This enables support for the Apollo display controller in its
-         Hecuba form using the n411 devkit.
+	tristate "N411 Apollo/Hecuba devkit support"
+	depends on FB && X86 && MMU
+	select FB_SYS_FILLRECT
+	select FB_SYS_COPYAREA
+	select FB_SYS_IMAGEBLIT
+	select FB_SYS_FOPS
+	select FB_DEFERRED_IO
+	select FB_HECUBA
+	help
+	  This enables support for the Apollo display controller in its
+	  Hecuba form using the n411 devkit.
 
 config FB_HGA
 	tristate "Hercules mono graphics support"
@@ -685,7 +685,7 @@ config FB_GBE
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
- 	help
+	help
 	  This is the frame buffer device driver for SGI Graphics Backend.
 	  This chip is used in SGI O2 and Visual Workstation 320/540.
 
@@ -897,10 +897,10 @@ config FB_NVIDIA
 	  module will be called nvidiafb.
 
 config FB_NVIDIA_I2C
-       bool "Enable DDC Support"
-       depends on FB_NVIDIA
-       select FB_DDC
-       help
+	bool "Enable DDC Support"
+	depends on FB_NVIDIA
+	select FB_DDC
+	help
 	  This enables I2C support for nVidia Chipsets.  This is used
 	  only for getting EDID information from the attached display
 	  allowing for robust video mode handling and switching.
@@ -943,10 +943,10 @@ config FB_RIVA
 	  module will be called rivafb.
 
 config FB_RIVA_I2C
-       bool "Enable DDC Support"
-       depends on FB_RIVA
-       select FB_DDC
-       help
+	bool "Enable DDC Support"
+	depends on FB_RIVA
+	select FB_DDC
+	help
 	  This enables I2C support for nVidia Chipsets.  This is used
 	  only for getting EDID information from the attached display
 	  allowing for robust video mode handling and switching.
@@ -991,37 +991,37 @@ config FB_I810
 	select FB_CFB_IMAGEBLIT
 	select VGASTATE
 	help
-	  This driver supports the on-board graphics built in to the Intel 810 
-          and 815 chipsets.  Say Y if you have and plan to use such a board.
+	  This driver supports the on-board graphics built in to the Intel 810
+	  and 815 chipsets.  Say Y if you have and plan to use such a board.
 
-          To compile this driver as a module, choose M here: the
+	  To compile this driver as a module, choose M here: the
 	  module will be called i810fb.
 
-          For more information, please read 
+	  For more information, please read
 	  <file:Documentation/fb/intel810.txt>
 
 config FB_I810_GTF
 	bool "use VESA Generalized Timing Formula"
 	depends on FB_I810
 	help
-	  If you say Y, then the VESA standard, Generalized Timing Formula 
-          or GTF, will be used to calculate the required video timing values
-	  per video mode.  Since the GTF allows nondiscrete timings 
-          (nondiscrete being a range of values as opposed to discrete being a
-          set of values), you'll be able to use any combination of horizontal 
+	  If you say Y, then the VESA standard, Generalized Timing Formula
+	  or GTF, will be used to calculate the required video timing values
+	  per video mode.  Since the GTF allows nondiscrete timings
+	  (nondiscrete being a range of values as opposed to discrete being a
+	  set of values), you'll be able to use any combination of horizontal
 	  and vertical resolutions, and vertical refresh rates without having
 	  to specify your own timing parameters.  This is especially useful
-	  to maximize the performance of an aging display, or if you just 
-          have a display with nonstandard dimensions. A VESA compliant 
+	  to maximize the performance of an aging display, or if you just
+	  have a display with nonstandard dimensions. A VESA compliant
 	  monitor is recommended, but can still work with non-compliant ones.
-	  If you need or want this, then select this option. The timings may 
-	  not be compliant with Intel's recommended values. Use at your own 
+	  If you need or want this, then select this option. The timings may
+	  not be compliant with Intel's recommended values. Use at your own
 	  risk.
 
-          If you say N, the driver will revert to discrete video timings 
+	  If you say N, the driver will revert to discrete video timings
 	  using a set recommended by Intel in their documentation.
-  
-          If unsure, say N.
+
+	  If unsure, say N.
 
 config FB_I810_I2C
 	bool "Enable DDC Support"
@@ -1060,8 +1060,8 @@ config FB_INTEL
 	depends on !DRM_I915
 	help
 	  This driver supports the on-board graphics built in to the Intel
-          830M/845G/852GM/855GM/865G/915G/915GM/945G/945GM/965G/965GM chipsets.
-          Say Y if you have and plan to use such a board.
+	  830M/845G/852GM/855GM/865G/915G/915GM/945G/945GM/965G/965GM chipsets.
+	  Say Y if you have and plan to use such a board.
 
 	  To make FB_INTEL=Y work you need to say AGP_INTEL=y too.
 
@@ -1142,10 +1142,10 @@ config FB_MATROX_G
 	  G450/G550 secondary head and digital output are supported without
 	  additional modules.
 
-	  The driver starts in monitor mode. You must use the matroxset tool 
-	  (available at <ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/>) to 
-	  swap primary and secondary head outputs, or to change output mode.  
-	  Secondary head driver always start in 640x480 resolution and you 
+	  The driver starts in monitor mode. You must use the matroxset tool
+	  (available at <ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/>) to
+	  swap primary and secondary head outputs, or to change output mode.
+	  Secondary head driver always start in 640x480 resolution and you
 	  must use fbset to change it.
 
 	  Do not forget that second head supports only 16 and 32 bpp
@@ -1228,7 +1228,7 @@ config FB_RADEON_I2C
 	select FB_DDC
 	default y
 	help
-	  Say Y here if you want DDC/I2C support for your Radeon board. 
+	  Say Y here if you want DDC/I2C support for your Radeon board.
 
 config FB_RADEON_BACKLIGHT
 	bool "Support for backlight control"
@@ -1357,10 +1357,10 @@ config FB_SAVAGE
 	  will be called savagefb.
 
 config FB_SAVAGE_I2C
-       bool "Enable DDC2 Support"
-       depends on FB_SAVAGE
-       select FB_DDC
-       help
+	bool "Enable DDC2 Support"
+	depends on FB_SAVAGE
+	select FB_DDC
+	help
 	  This enables I2C support for S3 Savage Chipsets.  This is used
 	  only for getting EDID information from the attached display
 	  allowing for robust video mode handling and switching.
@@ -1370,12 +1370,12 @@ config FB_SAVAGE_I2C
 	  here.
 
 config FB_SAVAGE_ACCEL
-       bool "Enable Console Acceleration"
-       depends on FB_SAVAGE
-       help
-          This option will compile in console acceleration support. If
-          the resulting framebuffer console has bothersome glitches, then
-          choose N here.
+	bool "Enable Console Acceleration"
+	depends on FB_SAVAGE
+	help
+	  This option will compile in console acceleration support. If
+	  the resulting framebuffer console has bothersome glitches, then
+	  choose N here.
 
 config FB_SIS
 	tristate "SiS/XGI display support"
@@ -1408,17 +1408,17 @@ config FB_SIS_315
 	  as XGI V3XT, V5, V8 and Z7.
 
 config FB_VIA
-       tristate "VIA UniChrome (Pro) and Chrome9 display support"
-       depends on FB && PCI && GPIOLIB && I2C && (X86 || COMPILE_TEST)
-       select FB_CFB_FILLRECT
-       select FB_CFB_COPYAREA
-       select FB_CFB_IMAGEBLIT
-       select I2C_ALGOBIT
-       help
+	tristate "VIA UniChrome (Pro) and Chrome9 display support"
+	depends on FB && PCI && GPIOLIB && I2C && (X86 || COMPILE_TEST)
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select I2C_ALGOBIT
+	help
 	  This is the frame buffer device driver for Graphics chips of VIA
 	  UniChrome (Pro) Family (CLE266,PM800/CN400,P4M800CE/P4M800Pro/
 	  CN700/VN800,CX700/VX700,P4M890) and Chrome9 Family (K8M890,CN896
- 	  /P4M900,VX800)
+	  /P4M900,VX800)
 	  Say Y if you have a VIA UniChrome graphics board.
 
 	  To compile this driver as a module, choose M here: the
@@ -1455,7 +1455,7 @@ config FB_NEOMAGIC
 	select VGASTATE
 	help
 	  This driver supports notebooks with NeoMagic PCI chips.
-	  Say Y if you have such a graphics card. 
+	  Say Y if you have such a graphics card.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called neofb.
@@ -1510,7 +1510,7 @@ config FB_VOODOO1
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
 	---help---
-	  Say Y here if you have a 3Dfx Voodoo Graphics (Voodoo1/sst1) or 
+	  Say Y here if you have a 3Dfx Voodoo Graphics (Voodoo1/sst1) or
 	  Voodoo2 (cvg) based graphics card.
 
 	  To compile this driver as a module, choose M here: the
@@ -1679,9 +1679,9 @@ config FB_HIT
 config FB_PMAG_AA
 	tristate "PMAG-AA TURBOchannel framebuffer support"
 	depends on FB && TC
- 	select FB_CFB_FILLRECT
- 	select FB_CFB_COPYAREA
- 	select FB_CFB_IMAGEBLIT
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	help
 	  Support for the PMAG-AA TURBOchannel framebuffer card (1280x1024x1)
 	  used mainly in the MIPS-based DECstation series.
@@ -1689,9 +1689,9 @@ config FB_PMAG_AA
 config FB_PMAG_BA
 	tristate "PMAG-BA TURBOchannel framebuffer support"
 	depends on FB && TC
- 	select FB_CFB_FILLRECT
- 	select FB_CFB_COPYAREA
- 	select FB_CFB_IMAGEBLIT
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	help
 	  Support for the PMAG-BA TURBOchannel framebuffer card (1024x864x8)
 	  used mainly in the MIPS-based DECstation series.
@@ -1699,9 +1699,9 @@ config FB_PMAG_BA
 config FB_PMAGB_B
 	tristate "PMAGB-B TURBOchannel framebuffer support"
 	depends on FB && TC
- 	select FB_CFB_FILLRECT
- 	select FB_CFB_COPYAREA
- 	select FB_CFB_IMAGEBLIT
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	help
 	  Support for the PMAGB-B TURBOchannel framebuffer card used mainly
 	  in the MIPS-based DECstation series. The card is currently only
@@ -1710,9 +1710,9 @@ config FB_PMAGB_B
 config FB_MAXINE
 	bool "Maxine (Personal DECstation) onboard framebuffer support"
 	depends on (FB = y) && MACH_DECSTATION
- 	select FB_CFB_FILLRECT
- 	select FB_CFB_COPYAREA
- 	select FB_CFB_IMAGEBLIT
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	help
 	  Support for the onboard framebuffer (1024x768x8) in the Personal
 	  DECstation series (Personal DECstation 5000/20, /25, /33, /50,
@@ -1721,9 +1721,9 @@ config FB_MAXINE
 config FB_G364
 	bool "G364 frame buffer support"
 	depends on (FB = y) && (MIPS_MAGNUM_4000 || OLIVETTI_M700)
- 	select FB_CFB_FILLRECT
- 	select FB_CFB_COPYAREA
- 	select FB_CFB_IMAGEBLIT
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	help
 	  The G364 driver is the framebuffer used in MIPS Magnum 4000 and
 	  Olivetti M700-10 systems.
@@ -1731,9 +1731,9 @@ config FB_G364
 config FB_68328
 	bool "Motorola 68328 native frame buffer support"
 	depends on (FB = y) && (M68328 || M68EZ328 || M68VZ328)
- 	select FB_CFB_FILLRECT
- 	select FB_CFB_COPYAREA
- 	select FB_CFB_IMAGEBLIT
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	help
 	  Say Y here if you want to support the built-in frame buffer of
 	  the Motorola 68328 CPU family.
@@ -1812,13 +1812,13 @@ config FB_MBX
 	  Accelerator
 
 config FB_MBX_DEBUG
-       bool "Enable debugging info via debugfs"
-       depends on FB_MBX && DEBUG_FS
-       ---help---
-         Enable this if you want debugging information using the debug
-         filesystem (debugfs)
+	bool "Enable debugging info via debugfs"
+	depends on FB_MBX && DEBUG_FS
+	---help---
+	  Enable this if you want debugging information using the debug
+	  filesystem (debugfs)
 
-         If unsure, say N.
+	  If unsure, say N.
 
 config FB_FSL_DIU
 	tristate "Freescale DIU framebuffer support"
@@ -1834,9 +1834,9 @@ config FB_FSL_DIU
 config FB_W100
 	tristate "W100 frame buffer support"
 	depends on FB && ARCH_PXA
- 	select FB_CFB_FILLRECT
- 	select FB_CFB_COPYAREA
- 	select FB_CFB_IMAGEBLIT
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	---help---
 	  Frame buffer driver for the w100 as found on the Sharp SL-Cxx series.
 	  It can also drive the w3220 chip found on iPAQ hx4700.
@@ -1901,10 +1901,10 @@ config FB_S3C
 	  Currently the support is only for the S3C6400 and S3C6410 SoCs.
 
 config FB_S3C_DEBUG_REGWRITE
-       bool "Debug register writes"
-       depends on FB_S3C
-       ---help---
-         Show all register writes via pr_debug()
+	bool "Debug register writes"
+	depends on FB_S3C
+	---help---
+	  Show all register writes via pr_debug()
 
 config FB_S3C2410
 	tristate "S3C2410 LCD framebuffer support"
@@ -1930,18 +1930,18 @@ config FB_S3C2410_DEBUG
 	  through sysfs
 
 config FB_NUC900
-        tristate "NUC900 LCD framebuffer support"
-        depends on FB && ARCH_W90X900
-        select FB_CFB_FILLRECT
-        select FB_CFB_COPYAREA
-        select FB_CFB_IMAGEBLIT
-        ---help---
-          Frame buffer driver for the built-in LCD controller in the Nuvoton
-          NUC900 processor
+	tristate "NUC900 LCD framebuffer support"
+	depends on FB && ARCH_W90X900
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	---help---
+	  Frame buffer driver for the built-in LCD controller in the Nuvoton
+	  NUC900 processor
 
 config GPM1040A0_320X240
-        bool "Giantplus Technology GPM1040A0 320x240 Color TFT LCD"
-        depends on FB_NUC900
+	bool "Giantplus Technology GPM1040A0 320x240 Color TFT LCD"
+	depends on FB_NUC900
 
 config FB_SM501
 	tristate "Silicon Motion SM501 framebuffer support"
diff --git a/drivers/video/fbdev/mmp/Kconfig b/drivers/video/fbdev/mmp/Kconfig
index f56a7e2..1b5e80c 100644
--- a/drivers/video/fbdev/mmp/Kconfig
+++ b/drivers/video/fbdev/mmp/Kconfig
@@ -1,7 +1,7 @@
 menuconfig MMP_DISP
-        tristate "Marvell MMP Display Subsystem support"
-        depends on CPU_PXA910 || CPU_MMP2
-        help
+	tristate "Marvell MMP Display Subsystem support"
+	depends on CPU_PXA910 || CPU_MMP2
+	help
 	  Marvell Display Subsystem support.
 
 if MMP_DISP
diff --git a/drivers/video/fbdev/omap/Kconfig b/drivers/video/fbdev/omap/Kconfig
index 29d250d..ca14793 100644
--- a/drivers/video/fbdev/omap/Kconfig
+++ b/drivers/video/fbdev/omap/Kconfig
@@ -6,7 +6,7 @@ config FB_OMAP
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
 	help
-          Frame buffer driver for OMAP based boards.
+	  Frame buffer driver for OMAP based boards.
 
 config FB_OMAP_LCDC_EXTERNAL
 	bool "External LCD controller support"
@@ -49,13 +49,11 @@ config FB_OMAP_LCD_H3
 	  H3 board.
 
 config FB_OMAP_DMA_TUNE
-        bool "Set DMA SDRAM access priority high"
-        depends on FB_OMAP
-        help
-          On systems in which video memory is in system memory
-          (SDRAM) this will speed up graphics DMA operations.
-          If you have such a system and want to use rotation
-          answer yes. Answer no if you have a dedicated video
-          memory, or don't use any of the accelerated features.
-
-
+	bool "Set DMA SDRAM access priority high"
+	depends on FB_OMAP
+	help
+	  On systems in which video memory is in system memory
+	  (SDRAM) this will speed up graphics DMA operations.
+	  If you have such a system and want to use rotation
+	  answer yes. Answer no if you have a dedicated video
+	  memory, or don't use any of the accelerated features.
diff --git a/drivers/video/fbdev/omap2/omapfb/Kconfig b/drivers/video/fbdev/omap2/omapfb/Kconfig
index 3bf154e..0410e07 100644
--- a/drivers/video/fbdev/omap2/omapfb/Kconfig
+++ b/drivers/video/fbdev/omap2/omapfb/Kconfig
@@ -2,23 +2,23 @@ config OMAP2_VRFB
 	bool
 
 menuconfig FB_OMAP2
-        tristate "OMAP2+ frame buffer support"
-        depends on FB
-        depends on DRM_OMAP = n
+	tristate "OMAP2+ frame buffer support"
+	depends on FB
+	depends on DRM_OMAP = n
 	depends on GPIOLIB
 
-        select FB_OMAP2_DSS
+	select FB_OMAP2_DSS
 	select OMAP2_VRFB if ARCH_OMAP2 || ARCH_OMAP3
-        select FB_CFB_FILLRECT
-        select FB_CFB_COPYAREA
-        select FB_CFB_IMAGEBLIT
-        help
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	help
 	  Frame buffer driver for OMAP2+ based boards.
 
 if FB_OMAP2
 
 config FB_OMAP2_DEBUG_SUPPORT
-        bool "Debug support for OMAP2+ FB"
+	bool "Debug support for OMAP2+ FB"
 	default y
 	depends on FB_OMAP2
 	help
diff --git a/drivers/video/fbdev/omap2/omapfb/displays/Kconfig b/drivers/video/fbdev/omap2/omapfb/displays/Kconfig
index 08f1203..3df8736 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/Kconfig
+++ b/drivers/video/fbdev/omap2/omapfb/displays/Kconfig
@@ -1,5 +1,5 @@
 menu "OMAPFB Panel and Encoder Drivers"
-        depends on FB_OMAP2_DSS
+	depends on FB_OMAP2_DSS
 
 config FB_OMAP2_ENCODER_OPA362
 	tristate "OPA362 external analog amplifier"
@@ -8,29 +8,29 @@ config FB_OMAP2_ENCODER_OPA362
 	  through a GPIO.
 
 config FB_OMAP2_ENCODER_TFP410
-        tristate "TFP410 DPI to DVI Encoder"
+	tristate "TFP410 DPI to DVI Encoder"
 	help
 	  Driver for TFP410 DPI to DVI encoder.
 
 config FB_OMAP2_ENCODER_TPD12S015
-        tristate "TPD12S015 HDMI ESD protection and level shifter"
+	tristate "TPD12S015 HDMI ESD protection and level shifter"
 	help
 	  Driver for TPD12S015, which offers HDMI ESD protection and level
 	  shifting.
 
 config FB_OMAP2_CONNECTOR_DVI
-        tristate "DVI Connector"
+	tristate "DVI Connector"
 	depends on I2C
 	help
 	  Driver for a generic DVI connector.
 
 config FB_OMAP2_CONNECTOR_HDMI
-        tristate "HDMI Connector"
+	tristate "HDMI Connector"
 	help
 	  Driver for a generic HDMI connector.
 
 config FB_OMAP2_CONNECTOR_ANALOG_TV
-        tristate "Analog TV Connector"
+	tristate "Analog TV Connector"
 	help
 	  Driver for a generic analog TV connector.
 
@@ -58,29 +58,29 @@ config FB_OMAP2_PANEL_LGPHILIPS_LB035Q02
 	  LCD Panel used on the Gumstix Overo Palo35
 
 config FB_OMAP2_PANEL_SHARP_LS037V7DW01
-        tristate "Sharp LS037V7DW01 LCD Panel"
-        depends on BACKLIGHT_CLASS_DEVICE
-        help
-          LCD Panel used in TI's SDP3430 and EVM boards
+	tristate "Sharp LS037V7DW01 LCD Panel"
+	depends on BACKLIGHT_CLASS_DEVICE
+	help
+	  LCD Panel used in TI's SDP3430 and EVM boards
 
 config FB_OMAP2_PANEL_TPO_TD028TTEC1
-        tristate "TPO TD028TTEC1 LCD Panel"
-        depends on SPI
-        help
-          LCD panel used in Openmoko.
+	tristate "TPO TD028TTEC1 LCD Panel"
+	depends on SPI
+	help
+	  LCD panel used in Openmoko.
 
 config FB_OMAP2_PANEL_TPO_TD043MTEA1
-        tristate "TPO TD043MTEA1 LCD Panel"
-        depends on SPI
-        help
-          LCD Panel used in OMAP3 Pandora
+	tristate "TPO TD043MTEA1 LCD Panel"
+	depends on SPI
+	help
+	  LCD Panel used in OMAP3 Pandora
 
 config FB_OMAP2_PANEL_NEC_NL8048HL11
 	tristate "NEC NL8048HL11 Panel"
 	depends on SPI
 	depends on BACKLIGHT_CLASS_DEVICE
 	help
-		This NEC NL8048HL11 panel is TFT LCD used in the
-		Zoom2/3/3630 sdp boards.
+	  This NEC NL8048HL11 panel is TFT LCD used in the
+	  Zoom2/3/3630 sdp boards.
 
 endmenu
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/Kconfig b/drivers/video/fbdev/omap2/omapfb/dss/Kconfig
index 356b89b..a34820e 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/Kconfig
+++ b/drivers/video/fbdev/omap2/omapfb/dss/Kconfig
@@ -3,7 +3,7 @@ config FB_OMAP2_DSS_INIT
 	bool
 
 config FB_OMAP2_DSS
-        tristate
+	tristate
 	select VIDEOMODE_HELPERS
 	select FB_OMAP2_DSS_INIT
 	select HDMI
@@ -53,7 +53,7 @@ config FB_OMAP2_DSS_RFBI
 
 config FB_OMAP2_DSS_VENC
 	bool "VENC support"
-        default y
+	default y
 	help
 	  OMAP Video Encoder support for S-Video and composite TV-out.
 
@@ -62,7 +62,7 @@ config FB_OMAP2_DSS_HDMI_COMMON
 
 config FB_OMAP4_DSS_HDMI
 	bool "HDMI support for OMAP4"
-        default y
+	default y
 	select FB_OMAP2_DSS_HDMI_COMMON
 	help
 	  HDMI support for OMAP4 based SoCs.
-- 
1.9.1
