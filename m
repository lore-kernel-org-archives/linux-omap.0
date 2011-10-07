From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [GIT PULL] OMAP DSS for v3.2
Date: Fri, 07 Oct 2011 10:20:07 +0300
Message-ID: <1317972007.2374.12.camel@deskari>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-hSw2rDjm2s3Zbw5zyg6M"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:56396 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751498Ab1JGHUN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Oct 2011 03:20:13 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-omap mailing list <linux-omap@vger.kernel.org>, lfbdev-ml <linux-fbdev@vger.kernel.org>


--=-hSw2rDjm2s3Zbw5zyg6M
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi Florian,

Please pull OMAP DSS patches for v3.2 merge window.

Note that there are some conflicts with other trees. The board file
conflicts are trivial, changes in code which just happen to be next to
each other. The LCD driver conflicts are even simpler, there were
changes to them from some other tree, but I have removed the files.

The conflicts have been solved properly by Stephen in linux-next:

https://github.com/sfrothwell/linux-next/commit/3e31b3042760e3906d0a275d7adedfaf55ee5b0a

I also attached the output from git show, as github seems to show the
full diff for the merge commit.

Are you ok with the conflicts?

 Tomi


The following changes since commit b6fd41e29dea9c6753b1843a77e50433e6123bcb:

  Linux 3.1-rc6 (2011-09-12 14:02:02 -0700)

are available in the git repository at:
  git://gitorious.org/linux-omap-dss2/linux.git for-florian

Andy Doan (1):
      OMAPFB: make debug message more useful

Archit Taneja (26):
      OMAP: DSS2: DISPC: Prepare dispc_dump_regs() for shortening
      OMAP: DSS2: DISPC: Shorten dispc_dump_regs()
      OMAP: DSS2: DISPC: dispc_save_context() and dispc_restore_context() cleanup
      OMAP: DSS2: DISPC: Shorten _dispc_set_color_conv_coef()
      OMAP: DSS2: Use a macro to declare size of the fifo_size array in dispc.c
      OMAP: DSS2: Use MIPI DSI enums from include/video/mipi_display.h
      OMAP: DSS2: DSI: Represent L4 and VP as sources of VC instead of modes
      OMAP: DSS2: Create enum for DSI operation modes
      OMAP: DSS2: DSI: Introduce generic write functions
      OMAP: DSS2: DSI: Remove functions dsi_vc_dcs_read_1() and dsi_vc_dcs_read_2()
      OMAP: DSS2: DSI: Split dsi_vc_dcs_read() into 2 functions
      OMAP: DSS2: DSI: Introduce generic read functions
      OMAP: DSS2: Clean up stallmode and io pad mode selection
      OMAP: DSS2: Create an enum for DSI pixel formats
      OMAP: DSS2: DSI: Send zero length packet in dsi_vc_send_null()
      OMAP: DSS2: DSI Video mode support
      OMAPDSS: DISPC: Reduce the number of arguments in dispc_ovl_setup()
      OMAPDSS: DISPC: Pass overlay params as arguments to dispc_ovl_setup()
      OMAPDSS: DISPC: Create helper function dispc_mgr_is_lcd()
      OMAPDSS: DISPC: Get correct pixel clock for TV manager
      OMAPDSS: DISPC: Remove hardcoded use of PPL in five tap clock calculation
      OMAPDSS: DISPC: Clean up scaling related clock and five tap calculations
      OMAPDSS: FEATURES: Create a range param to get max downscaling
      OMAPDSS/OMAP_VOUT: Fix incorrect OMAP3-alpha compatibility setting
      OMAPDSS: DISPC: VIDEO3 pipeline support
      OMAPDSS: DISPC: zorder support for DSS overlays

Arnd Bergmann (1):
      video/omap: fix build dependencies

Daniel Morsing (1):
      OMAP: DSS2: Don't allow moving managers away from enabled displays

Dima Zavin (1):
      OMAP: DSS: dispc: enable/disable clocks in error handler

Mayuresh Janorkar (1):
      OMAP: DSS2: Add picodlp panel driver

Mythri P K (14):
      OMAP4: DSS2: HDMI: HDMI clean up to pass base_address
      OMAP4: DSS2: HDMI: Move pll and video configuration
      OMAP4: DSS2: HDMI: Use specific HDMI timings structure
      OMAP4: DSS2: HDMI: Move HDMI IP independent generic header
      OMAP4: DSS2: HDMI: Move the EDID definition from HDMI
      OMAP4: DSS2: HDMI: Split the current HDMI driver to move
      OMAP4: DSS2: HDMI: Move the HDMI IP dependent audio
      OMAP4: DSS2: HDMI: Rename the functions in HDMI IP library
      OMAP4: DSS2: HDMI: Function pointer approach to call
      OMAP4: DSS2: Rename hdmi_omap4_panel.c to hdmi_panel.c
      OMAPDSS: HDMI: Move the comments in avi infoframe
      OMAPDSS: HDMI: Replace hdmi_reg struct with u16
      OMAPDSS: HDMI: Add missing register definitions
      OMAPDSS: HDMI: Add support to dump registers through debugfs

Thomas Weber (2):
      OMAP: DSS2: Support for Innolux AT070TN83
      OMAP: Devkit8000: Change lcd driver to AT070TN83

Tomi Valkeinen (63):
      OMAP: DSS2: PicoDLP: fix error handling in power_on
      OMAP: DSS2: check for manager when enabling display
      Revert "HACK: OMAP: DSS2: clk hack for OMAP2/3"
      Revert "OMAP: DSS2: HDMI: fix hdmi clock name"
      OMAP: DSS2: remove unneeded fck enable/disables
      OMAP: DSS2: Change DSI device naming
      OMAP4: TWL: Add common omapdss supplies
      OMAP: DSS2: DSI: Improve dsi_mux_pads parameters
      OMAP: DSS2: Implement dsi_mux_pads for OMAP4
      OMAP: OMAPFB: make omapfb start even when a display is missing a driver
      OMAP: DSS2: fix clock sources on error and uninit
      OMAP: DSS2: Handle manager change in apply
      OMAP: DSS2: Remove "EXPERIMENTAL" from Kconfig
      OMAP: DSS2: Remove support for non-DISPC overlays
      OMAP: DSS2: DISPC: use lookup tables for bit shifts
      OMAP: DSS2: Add overlay caps to DSS features
      OMAP: DSS2: Add GLOBAL_ALPHA & PRE_MULT_ALPHA to ovl caps
      OMAP: DSS2: string parsing cleanups
      OMAP: OMAPFB: string parsing cleanups
      OMAP: DSS2: DISPC: remove non-existing func prototypes
      OMAP: DSS2: DISPC: rename overlay related funcs
      OMAP: DSS2: DISPC: rename manager related funcs
      OMAP: DSS2: reorganize functions in dss.h
      OMAP: DSS2: DISPC: Fix minimum PCD value
      OMAP: DSS2: HDMI: use default dividers
      OMAP: DSS2: HDMI: change regn definition
      OMAP: DSS2: DSI: Add comment about regn
      OMAP: DSS2: DISPC: Add missing IRQ  definitions
      OMAP: DSS2: add dss_get_hdmi_venc_clk_source()
      OMAP: DSS2: DISPC: improve dispc_mgr_enable_digit_out()
      OMAP: DSS2: HDMI: improve hdmi output enable
      OMAP: DSS2: add read_edid() to omap_dss_driver struct
      OMAP: DSS2: add detect() to omap_dss_driver struct
      OMAP: DSS2: HDMI: make set_timing saner
      OMAP: DSS2: HDMI: implement read_edid()
      OMAP: DSS2: HDMI: remove edid parsing
      OMAP: DSS2: HDMI: split hdmi_core_ddc_edid
      OMAP: DSS2: HDMI: clean up edid reading & fix checksum
      OMAP: DSS2: HDMI: remove error prints in check_timings
      OMAP: DSS2: HDMI: implement detect()
      OMAP: DSS2: add panel-dvi driver
      OMAP: use dvi panel driver instead of generic-dpi
      OMAP: stalker: Remove LCD device from board file
      OMAP: DSS2: panel-generic-dpi: remove "generic" panel
      OMAP: Add DDC i2c_bus_num to board files
      OMAPFB: find best mode from edid
      OMAPDSS: Taal: remove external backlight support
      OMAPFB: Remove unused lcd drivers
      OMAPDSS: Port 2430sdp display driver to DSS2
      OMAPDSS: Port the H4 display driver to DSS2
      OMAPDSS: Port the Apollon display driver to DSS2
      OMAPDSS: Add N800 panel driver
      OMAPDSS: remove vaddr from overlay info
      OMAP: 4430SDP: Remove unneeded lcd config
      OMAP4: 4430SDP: Add panel support to board file
      OMAP4: 4430SDP: Add picodlp support to board file
      OMAP: RX51: Remove unused old omapfb stuff
      OMAP: omap3touchbook: Remove unused lcd stuff
      OMAP: 2420SDP: Port the display driver to new DSS2
      OMAP: LDP: Port the display driver to new DSS2
      OMAP: H4: Port the display driver to new DSS2
      OMAP: Apollon: Port the display driver to new DSS2
      OMAPDSS: picodlp: add missing #include <linux/module.h>

 arch/arm/mach-omap2/board-2430sdp.c                |   78 +-
 arch/arm/mach-omap2/board-3430sdp.c                |    7 +-
 arch/arm/mach-omap2/board-4430sdp.c                |  208 +++-
 arch/arm/mach-omap2/board-am3517evm.c              |    6 +-
 arch/arm/mach-omap2/board-apollon.c                |   35 +-
 arch/arm/mach-omap2/board-cm-t35.c                 |    6 +-
 arch/arm/mach-omap2/board-devkit8000.c             |   10 +-
 arch/arm/mach-omap2/board-h4.c                     |   42 +-
 arch/arm/mach-omap2/board-igep0020.c               |    8 +-
 arch/arm/mach-omap2/board-ldp.c                    |  123 ++-
 arch/arm/mach-omap2/board-omap3beagle.c            |    8 +-
 arch/arm/mach-omap2/board-omap3evm.c               |    7 +-
 arch/arm/mach-omap2/board-omap3pandora.c           |    2 +-
 arch/arm/mach-omap2/board-omap3stalker.c           |   40 +-
 arch/arm/mach-omap2/board-omap3touchbook.c         |   18 -
 arch/arm/mach-omap2/board-omap4panda.c             |    8 +-
 arch/arm/mach-omap2/board-overo.c                  |    7 +-
 arch/arm/mach-omap2/board-rx51.c                   |   25 -
 arch/arm/mach-omap2/display.c                      |   60 +-
 arch/arm/mach-omap2/twl-common.c                   |   11 +-
 drivers/media/video/omap/omap_vout.c               |   18 +-
 drivers/video/omap/Kconfig                         |   29 -
 drivers/video/omap/Makefile                        |    8 -
 drivers/video/omap/lcd_2430sdp.c                   |  203 ---
 drivers/video/omap/lcd_apollon.c                   |  136 --
 drivers/video/omap/lcd_h4.c                        |  117 --
 drivers/video/omap/lcd_ldp.c                       |  201 ---
 drivers/video/omap/lcd_omap3beagle.c               |  130 --
 drivers/video/omap/lcd_omap3evm.c                  |  193 ---
 drivers/video/omap/lcd_overo.c                     |  180 ---
 drivers/video/omap2/displays/Kconfig               |   28 +-
 drivers/video/omap2/displays/Makefile              |    3 +
 drivers/video/omap2/displays/panel-dvi.c           |  363 +++++
 drivers/video/omap2/displays/panel-generic-dpi.c   |  113 +-
 drivers/video/omap2/displays/panel-n8x0.c          |  747 +++++++++
 drivers/video/omap2/displays/panel-picodlp.c       |  594 +++++++
 drivers/video/omap2/displays/panel-picodlp.h       |  288 ++++
 drivers/video/omap2/displays/panel-taal.c          |  123 +-
 drivers/video/omap2/dss/Kconfig                    |    2 +-
 drivers/video/omap2/dss/Makefile                   |    2 +-
 drivers/video/omap2/dss/core.c                     |    4 +
 drivers/video/omap2/dss/dispc.c                    | 1700 ++++++++------------
 drivers/video/omap2/dss/dispc.h                    |   57 +
 drivers/video/omap2/dss/display.c                  |   31 +-
 drivers/video/omap2/dss/dpi.c                      |   28 +-
 drivers/video/omap2/dss/dsi.c                      |  929 +++++++-----
 drivers/video/omap2/dss/dss.c                      |   18 +-
 drivers/video/omap2/dss/dss.h                      |  156 +-
 drivers/video/omap2/dss/dss_features.c             |  130 ++-
 drivers/video/omap2/dss/dss_features.h             |   17 +-
 drivers/video/omap2/dss/hdmi.c                     | 1260 ++-------------
 .../omap2/dss/{hdmi_omap4_panel.c => hdmi_panel.c} |   68 +-
 drivers/video/omap2/dss/manager.c                  |  191 +--
 drivers/video/omap2/dss/overlay.c                  |  122 +-
 drivers/video/omap2/dss/rfbi.c                     |   45 +-
 drivers/video/omap2/dss/sdi.c                      |   19 +-
 drivers/video/omap2/dss/ti_hdmi.h                  |  138 ++
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c          | 1239 ++++++++++++++
 .../video/omap2/dss/{hdmi.h => ti_hdmi_4xxx_ip.h}  |  400 +++---
 drivers/video/omap2/dss/venc.c                     |   27 +-
 drivers/video/omap2/omapfb/Kconfig                 |    2 +-
 drivers/video/omap2/omapfb/omapfb-main.c           |  134 ++-
 drivers/video/omap2/omapfb/omapfb-sysfs.c          |    6 +-
 include/video/omap-panel-dvi.h                     |   37 +
 include/video/omap-panel-n8x0.h                    |   15 +
 include/video/omap-panel-nokia-dsi.h               |    8 +-
 include/video/omap-panel-picodlp.h                 |   23 +
 include/video/omapdss.h                            |  100 +-
 68 files changed, 6495 insertions(+), 4596 deletions(-)
 delete mode 100644 drivers/video/omap/lcd_2430sdp.c
 delete mode 100644 drivers/video/omap/lcd_apollon.c
 delete mode 100644 drivers/video/omap/lcd_h4.c
 delete mode 100644 drivers/video/omap/lcd_ldp.c
 delete mode 100644 drivers/video/omap/lcd_omap3beagle.c
 delete mode 100644 drivers/video/omap/lcd_omap3evm.c
 delete mode 100644 drivers/video/omap/lcd_overo.c
 create mode 100644 drivers/video/omap2/displays/panel-dvi.c
 create mode 100644 drivers/video/omap2/displays/panel-n8x0.c
 create mode 100644 drivers/video/omap2/displays/panel-picodlp.c
 create mode 100644 drivers/video/omap2/displays/panel-picodlp.h
 rename drivers/video/omap2/dss/{hdmi_omap4_panel.c => hdmi_panel.c} (79%)
 create mode 100644 drivers/video/omap2/dss/ti_hdmi.h
 create mode 100644 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
 rename drivers/video/omap2/dss/{hdmi.h => ti_hdmi_4xxx_ip.h} (54%)
 create mode 100644 include/video/omap-panel-dvi.h
 create mode 100644 include/video/omap-panel-n8x0.h
 create mode 100644 include/video/omap-panel-picodlp.h


--=-hSw2rDjm2s3Zbw5zyg6M
Content-Disposition: attachment; filename="merge.txt"
Content-Type: text/plain; name="merge.txt"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

commit 3e31b3042760e3906d0a275d7adedfaf55ee5b0a
Merge: 49d6b1b 3e28189
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Fri Oct 7 14:12:41 2011 +1100

    Merge remote-tracking branch 'omap_dss2/for-next'
    
    Conflicts:
    	arch/arm/mach-omap2/board-2430sdp.c
    	arch/arm/mach-omap2/board-4430sdp.c
    	arch/arm/mach-omap2/board-apollon.c
    	arch/arm/mach-omap2/board-h4.c
    	arch/arm/mach-omap2/board-ldp.c
    	arch/arm/mach-omap2/board-rx51.c
    	drivers/video/omap/lcd_apollon.c
    	drivers/video/omap/lcd_ldp.c
    	drivers/video/omap/lcd_overo.c

diff --cc arch/arm/mach-omap2/board-2430sdp.c
index 4191743,6ab6350..ba7d92b
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@@ -137,10 -192,12 +192,6 @@@ static inline void board_smc91x_init(vo
  
  #endif
  
- static struct omap_board_config_kernel sdp2430_config[] __initdata = {
- 	{OMAP_TAG_LCD, &sdp2430_lcd_config},
- };
- 
 -static void __init omap_2430sdp_init_early(void)
 -{
 -	omap2_init_common_infrastructure();
 -	omap2_init_common_devices(NULL, NULL);
 -}
 -
  static struct regulator_consumer_supply sdp2430_vmmc1_supplies[] = {
  	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0"),
  };
diff --cc arch/arm/mach-omap2/board-4430sdp.c
index f3917b3,d3874a6..4d0c8b9
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@@ -381,14 -379,12 +379,6 @@@ static struct platform_device *sdp4430_
  	&sdp4430_vbat,
  };
  
- static struct omap_lcd_config sdp4430_lcd_config __initdata = {
- 	.ctrl_name	= "internal",
- };
- 
- static struct omap_board_config_kernel sdp4430_config[] __initdata = {
- 	{ OMAP_TAG_LCD,		&sdp4430_lcd_config },
- };
- 
 -static void __init omap_4430sdp_init_early(void)
 -{
 -	omap2_init_common_infrastructure();
 -	omap2_init_common_devices(NULL, NULL);
 -}
 -
  static struct omap_musb_board_data musb_board_data = {
  	.interface_type		= MUSB_INTERFACE_UTMI,
  	.mode			= MUSB_OTG,
diff --cc arch/arm/mach-omap2/board-apollon.c
index 868d5f0,d8eb81e..66f3842
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@@ -265,14 -262,34 +262,28 @@@ static struct omap_usb_config apollon_u
  	.pins[0]	= 6,
  };
  
- static struct omap_lcd_config apollon_lcd_config __initdata = {
- 	.ctrl_name	= "internal",
+ static struct panel_generic_dpi_data apollon_panel_data = {
+ 	.name			= "apollon",
  };
  
- static struct omap_board_config_kernel apollon_config[] __initdata = {
- 	{ OMAP_TAG_LCD,		&apollon_lcd_config },
+ static struct omap_dss_device apollon_lcd_device = {
+ 	.name			= "lcd",
+ 	.driver_name		= "generic_dpi_panel",
+ 	.type			= OMAP_DISPLAY_TYPE_DPI,
+ 	.phy.dpi.data_lines	= 18,
+ 	.data			= &apollon_panel_data,
+ };
+ 
+ static struct omap_dss_device *apollon_dss_devices[] = {
+ 	&apollon_lcd_device,
+ };
+ 
+ static struct omap_dss_board_info apollon_dss_data = {
+ 	.num_devices	= ARRAY_SIZE(apollon_dss_devices),
+ 	.devices	= apollon_dss_devices,
+ 	.default_device	= &apollon_lcd_device,
  };
  
 -static void __init omap_apollon_init_early(void)
 -{
 -	omap2_init_common_infrastructure();
 -	omap2_init_common_devices(NULL, NULL);
 -}
 -
  static struct gpio apollon_gpio_leds[] __initdata = {
  	{ LED0_GPIO13, GPIOF_OUT_INIT_LOW, "LED0" }, /* LED0 - AA10 */
  	{ LED1_GPIO14, GPIOF_OUT_INIT_LOW, "LED1" }, /* LED1 - AA6  */
@@@ -334,7 -349,8 +343,9 @@@ static void __init omap_apollon_init(vo
  	 */
  	platform_add_devices(apollon_devices, ARRAY_SIZE(apollon_devices));
  	omap_serial_init();
 +	omap_sdrc_init(NULL, NULL);
+ 
+ 	omap_display_init(&apollon_dss_data);
  }
  
  static void __init omap_apollon_map_io(void)
diff --cc arch/arm/mach-omap2/board-h4.c
index f0ddc27,f7c09de..ba81484
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@@ -285,10 -301,12 +300,6 @@@ static struct omap_usb_config h4_usb_co
  	.hmc_mode	= 0x00,		/* 0:dev|otg 1:disable 2:disable */
  };
  
- static struct omap_board_config_kernel h4_config[] __initdata = {
- 	{ OMAP_TAG_LCD,		&h4_lcd_config },
- };
- 
 -static void __init omap_h4_init_early(void)
 -{
 -	omap2_init_common_infrastructure();
 -	omap2_init_common_devices(NULL, NULL);
 -}
 -
  static void __init omap_h4_init_irq(void)
  {
  	omap2_init_irq();
@@@ -364,8 -379,9 +372,10 @@@ static void __init omap_h4_init(void
  	platform_add_devices(h4_devices, ARRAY_SIZE(h4_devices));
  	omap2_usbfs_init(&h4_usb_config);
  	omap_serial_init();
 +	omap_sdrc_init(NULL, NULL);
  	h4_init_flash();
+ 
+ 	omap_display_init(&h4_dss_data);
  }
  
  static void __init omap_h4_map_io(void)
diff --cc arch/arm/mach-omap2/board-ldp.c
index 5797917,689ed49..e179da0
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@@ -179,19 -183,103 +183,97 @@@ static inline void __init ldp_init_smsc
  	gpmc_smsc911x_init(&smsc911x_cfg);
  }
  
- static struct platform_device ldp_lcd_device = {
- 	.name		= "ldp_lcd",
- 	.id		= -1,
+ /* LCD */
+ 
+ static int ldp_backlight_gpio;
+ static int ldp_lcd_enable_gpio;
+ 
+ #define LCD_PANEL_RESET_GPIO		55
+ #define LCD_PANEL_QVGA_GPIO		56
+ 
+ static int ldp_panel_enable_lcd(struct omap_dss_device *dssdev)
+ {
+ 	if (gpio_is_valid(ldp_lcd_enable_gpio))
+ 		gpio_direction_output(ldp_lcd_enable_gpio, 1);
+ 	if (gpio_is_valid(ldp_backlight_gpio))
+ 		gpio_direction_output(ldp_backlight_gpio, 1);
+ 
+ 	return 0;
+ }
+ 
+ static void ldp_panel_disable_lcd(struct omap_dss_device *dssdev)
+ {
+ 	if (gpio_is_valid(ldp_lcd_enable_gpio))
+ 		gpio_direction_output(ldp_lcd_enable_gpio, 0);
+ 	if (gpio_is_valid(ldp_backlight_gpio))
+ 		gpio_direction_output(ldp_backlight_gpio, 0);
+ }
+ 
+ static struct panel_generic_dpi_data ldp_panel_data = {
+ 	.name			= "nec_nl2432dr22-11b",
+ 	.platform_enable	= ldp_panel_enable_lcd,
+ 	.platform_disable	= ldp_panel_disable_lcd,
  };
  
- static struct omap_lcd_config ldp_lcd_config __initdata = {
- 	.ctrl_name	= "internal",
+ static struct omap_dss_device ldp_lcd_device = {
+ 	.name			= "lcd",
+ 	.driver_name		= "generic_dpi_panel",
+ 	.type			= OMAP_DISPLAY_TYPE_DPI,
+ 	.phy.dpi.data_lines	= 18,
+ 	.data			= &ldp_panel_data,
+ };
+ 
+ static struct omap_dss_device *ldp_dss_devices[] = {
+ 	&ldp_lcd_device,
  };
  
- static struct omap_board_config_kernel ldp_config[] __initdata = {
- 	{ OMAP_TAG_LCD,		&ldp_lcd_config },
+ static struct omap_dss_board_info ldp_dss_data = {
+ 	.num_devices	= ARRAY_SIZE(ldp_dss_devices),
+ 	.devices	= ldp_dss_devices,
+ 	.default_device	= &ldp_lcd_device,
  };
  
+ static void __init ldp_display_init(void)
+ {
+ 	int r;
+ 
+ 	static struct gpio gpios[] __initdata = {
+ 		{LCD_PANEL_RESET_GPIO, GPIOF_OUT_INIT_HIGH, "LCD RESET"},
+ 		{LCD_PANEL_QVGA_GPIO, GPIOF_OUT_INIT_HIGH, "LCD QVGA"},
+ 	};
+ 
+ 	r = gpio_request_array(gpios, ARRAY_SIZE(gpios));
+ 	if (r) {
+ 		pr_err("Cannot request LCD GPIOs, error %d\n", r);
+ 		return;
+ 	}
+ 
+ 	omap_display_init(&ldp_dss_data);
+ }
+ 
 -static void __init omap_ldp_init_early(void)
 -{
 -	omap2_init_common_infrastructure();
 -	omap2_init_common_devices(NULL, NULL);
 -}
 -
+ static int ldp_twl_gpio_setup(struct device *dev, unsigned gpio, unsigned ngpio)
+ {
+ 	int r;
+ 
+ 	struct gpio gpios[] = {
+ 		{gpio + 7 , GPIOF_OUT_INIT_LOW, "LCD ENABLE"},
+ 		{gpio + 15, GPIOF_OUT_INIT_LOW, "LCD BACKLIGHT"},
+ 	};
+ 
+ 	r = gpio_request_array(gpios, ARRAY_SIZE(gpios));
+ 	if (r) {
+ 		pr_err("Cannot request LCD GPIOs, error %d\n", r);
+ 		ldp_backlight_gpio = -EINVAL;
+ 		ldp_lcd_enable_gpio = -EINVAL;
+ 		return r;
+ 	}
+ 
+ 	ldp_backlight_gpio = gpio + 15;
+ 	ldp_lcd_enable_gpio = gpio + 7;
+ 
+ 	return 0;
+ }
+ 
  static struct twl4030_gpio_platform_data ldp_gpio_data = {
  	.gpio_base	= OMAP_MAX_GPIO_LINES,
  	.irq_base	= TWL4030_GPIO_IRQ_BASE,
diff --cc arch/arm/mach-omap2/board-rx51.c
index e2e958a,9e7dde6..34858c8
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@@ -79,29 -79,15 +79,6 @@@ static struct cpuidle_params rx51_cpuid
  	{7505 + 15274, 484329, 1},
  };
  
- static struct omap_lcd_config rx51_lcd_config = {
- 	.ctrl_name	= "internal",
- };
- 
- static struct omap_fbmem_config rx51_fbmem0_config = {
- 	.size = 752 * 1024,
- };
- 
- static struct omap_fbmem_config rx51_fbmem1_config = {
- 	.size = 752 * 1024,
- };
- 
- static struct omap_fbmem_config rx51_fbmem2_config = {
- 	.size = 752 * 1024,
- };
- 
- static struct omap_board_config_kernel rx51_config[] = {
- 	{ OMAP_TAG_FBMEM,	&rx51_fbmem0_config },
- 	{ OMAP_TAG_FBMEM,	&rx51_fbmem1_config },
- 	{ OMAP_TAG_FBMEM,	&rx51_fbmem2_config },
- 	{ OMAP_TAG_LCD,		&rx51_lcd_config },
- };
- 
 -static void __init rx51_init_early(void)
 -{
 -	struct omap_sdrc_params *sdrc_params;
 -
 -	omap2_init_common_infrastructure();
 -	sdrc_params = nokia_get_sdram_timings();
 -	omap2_init_common_devices(sdrc_params, sdrc_params);
 -}
 -
  extern void __init rx51_peripherals_init(void);
  
  #ifdef CONFIG_OMAP_MUX
@@@ -118,17 -104,9 +95,15 @@@ static struct omap_musb_board_data musb
  
  static void __init rx51_init(void)
  {
 +	struct omap_sdrc_params *sdrc_params;
 +
  	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
- 	omap_board_config = rx51_config;
- 	omap_board_config_size = ARRAY_SIZE(rx51_config);
  	omap3_pm_init_cpuidle(rx51_cpuidle_params);
  	omap_serial_init();
 +
 +	sdrc_params = nokia_get_sdram_timings();
 +	omap_sdrc_init(sdrc_params, sdrc_params);
 +
  	usb_musb_init(&musb_board_data);
  	rx51_peripherals_init();
  

--=-hSw2rDjm2s3Zbw5zyg6M--

