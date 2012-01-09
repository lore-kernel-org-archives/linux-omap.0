From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Subject: Re: [GIT PULL] OMAP DSS for v3.3
Date: Mon, 09 Jan 2012 02:40:58 +0000
Message-ID: <4F0A53BA.1070605@gmx.de>
References: <1325753792.2045.42.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:57374 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751467Ab2AIClD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 8 Jan 2012 21:41:03 -0500
In-Reply-To: <1325753792.2045.42.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

Hi Tomi,

On 01/05/2012 08:56 AM, Tomi Valkeinen wrote:
> Hi Florian,
> 
> Here are changes to OMAP display subsystem driver for the merge window.
> 
> This merges and works fine with v3.2, and also merges fine with
> linux-next. I haven't been able to test with linux-next as there seems
> to be other brokenness there.

Pulled. I hope the problem with linux-next will be resolved before the final
kernel is released.


Thanks,

Florian Tobias Schandinat

> 
>  Tomi
> 
> The following changes since commit 5611cc4572e889b62a7b4c72a413536bf6a9c416:
> 
>   Linux 3.2-rc4 (2011-12-01 14:56:01 -0800)
> 
> are available in the git repository at:
>   git://gitorious.org/linux-omap-dss2/linux.git for-florian
> 
> Archit Taneja (3):
>       OMAPDSS: DSI: Fix HSDIV related PLL info in dsi_dump_clocks()
>       OMAPDSS: Panel NEC: Set omap_dss_device states correctly
>       OMAPDSS: Displays: Make PICODLP driver depend on DPI
> 
> Axel Lin (2):
>       video: omap: Staticise non-exported symbols
>       video: omap: convert drivers/video/omap/* to use module_platform_driver()
> 
> Chandrabhanu Mahapatra (2):
>       OMAPDSS: DISPC: Update Fir Coefficients
>       OMAPDSS: DISPC: Update Scaling Clock Logic
> 
> Daniel Mack (1):
>       OMAP: DSS2: Support for UMSH-8173MD TFT panel
> 
> Ilya Yanok (2):
>       OMAPDSS: add FocalTech ETM070003DH6 display support
>       OMAPDSS: add OrtusTech COM43H4M10XTC display support
> 
> Mythri P K (2):
>       OMAPDSS: HDMI: Move duplicate code from boardfile
>       OMAPDSS: HDMI: Disable DDC internal pull up
> 
> Ricardo Neri (4):
>       ASoC: OMAP: HDMI: Introduce driver data for audio codec
>       ASoC: OMAP: HDMI: Correct signature of ASoC functions
>       OMAPDSS: HDMI: Create function to enable HDMI audio
>       ASoC: OMAP: HDMI: Move HDMI codec trigger function to generic HDMI driver
> 
> Rob Clark (2):
>       OMAPDSS: fix potential NULL pointer ref in OCP_ERR handling path
>       OMAPDSS: APPLY: fix NULL pointer deref when mgr is not set
> 
> Tomi Valkeinen (90):
>       OMAPDSS: DSI: flush posted write when entering ULPS
>       OMAPDSS: DSI: flush posted write in send_bta
>       OMAPDSS: DISPC: Flush posted writes when enabling outputs
>       OMAPDSS: DSI: count with number of lanes
>       OMAPDSS: DSI: Parse lane config
>       OMAPDSS: DSI: Use new lane config in dsi_set_lane_config
>       OMAPDSS: DSI: use lane config in dsi_get_lane_mask
>       OMAPDSS: DSI: use lane config in dsi_cio_wait_tx_clk_esc_reset
>       OMAPDSS: DSI: use lane config in dsi_cio_enable_lane_override
>       OMAPDSS: DSI: remove dsi_get_num_lanes_used
>       OMAPDSS: DSI: fix lane handling when entering ULPS
>       OMAPDSS: DSI: improve wait_for_bit_change
>       OMAPDSS: DSI: disable DDR_CLK_ALWAYS_ON when entering ULPS
>       OMAPDSS: DISPC: add missing prototype
>       OMAPDSS: Remove old fifomerge hacks
>       OMAPDSS: remove L4_EXAMPLE code
>       OMAPDSS: DISPC: make dispc_ovl_set_channel_out() public
>       OMAPDSS: DISPC: make dispc_ovl_set_fifo_threshold() public
>       OMAPDSS: remove partial update from the overlay manager
>       OMAPDSS: remove partial update from DSI
>       OMAPDSS: remove partial update from panel-taal
>       OMAPDSS: pass ovl manager to dss_start_update
>       OMAPDSS: DISPC: handle 0 out_width/out_height in ovl_setup()
>       OMAPDSS: handle ilace/replication when configuring overlay
>       OMAPDSS: separate FIFO threshold setup from ovl_setup
>       OMAPDSS: separate overlay channel from ovl_setup
>       OMAPDSS: setup manager with dispc_mgr_setup()
>       OMAPDSS: DISPC: remove unused functions
>       OMAPDSS: remove unneeded dss_ovl_wait_for_go()
>       OMAPDSS: add ovl/mgr_manual_update() helpers
>       OMAPDSS: split omap_dss_mgr_apply() to smaller funcs
>       OMAPDSS: apply affects only one overlay manager
>       OMAPDSS: create apply.c
>       OMAPDSS: hide manager's enable/disable()
>       OMAPDSS: APPLY: track whether a manager is enabled
>       OMAPDSS: APPLY: skip isr register and config for manual update displays
>       OMAPDSS: APPLY: skip isr register and config for disabled displays
>       OMAPDSS: APPLY: cleanup dss_mgr_start_update
>       OMAPDSS: store overlays in an array
>       OMAPDSS: store managers in an array
>       OMAPDSS: store overlays in a list for each manager
>       OMAPDSS: APPLY: separate vsync isr register/unregister
>       OMAPDSS: DISPC: Add dispc_mgr_get_vsync_irq()
>       OMAPDSS: APPLY: use dispc_mgr_get_vsync_irq()
>       OMAPDSS: APPLY: configure_* funcs take ovl/manager as args
>       OMAPDSS: APPLY: rename overlay_cache_data
>       OMAPDSS: APPLY: rename manager_cache_data
>       OMAPDSS: APPLY: move spinlock outside the struct
>       OMAPDSS: APPLY: rename dss_cache to dss_data
>       OMAPDSS: APPLY: move ovl funcs to apply.c
>       OMAPDSS: APPLY: move mgr funcs to apply.c
>       OMAPDSS: remove ovl/mgr check-code temporarily
>       OMAPDSS: APPLY: add mutex
>       OMAPDSS: APPLY: add missing uses of spinlock
>       OMAPDSS: DSI: call mgr_enable/disable for cmd mode displays
>       OMAPDSS: APPLY: move mgr->enabled to mgr_priv_data
>       OMAPDSS: APPLY: add busy field to mgr_priv_data
>       OMAPDSS: APPLY: rewrite overlay enable/disable
>       OMAPDSS: APPLY: rewrite register writing
>       OMAPDSS: DISPC: add dispc_mgr_get_framedone_irq
>       OMAPDSS: APPLY: add updating flag
>       OMAPDSS: APPLY: clean up isr_handler
>       OMAPDSS: APPLY: move mgr->info to apply.c
>       OMAPDSS: APPLY: move ovl->info to apply.c
>       OMAPDSS: APPLY: move channel-field to extra_info set
>       OMAPDSS: APPLY: move fifo thresholds to extra_info set
>       OMAPDSS: APPLY: rename dirty & shadow_dirty
>       OMAPDSS: APPLY: remove device_changed field
>       OMAPDSS: APPLY: add dss_apply_ovl_enable()
>       OMAPDSS: APPLY: skip enable/disable if already enabled/disabled
>       OMAPDSS: APPLY: add wait_pending_extra_info_updates()
>       OMAPDSS: APPLY: remove runtime_get
>       OMAPDSS: Add comments about blocking of ovl/mgr functions
>       OMAPDSS: APPLY: add dss_ovl_simple_check()
>       OMAPDSS: APPLY: add dss_mgr_simple_check()
>       OMAPDSS: APPLY: add checking of ovls/mgrs settings
>       OMAPDSS: APPLY: add return value to dss_mgr_enable()
>       OMAPDSS: check the return value of dss_mgr_enable()
>       OMAPDSS: APPLY: fix extra_info_update_ongoing
>       OMAPDSS: APPLY: fix need_isr
>       OMAPDSS: APPLY: clear shadow dirty flags only if GO had been set
>       OMAPDSS: APPLY: add dss_set_go_bits()
>       OMAPDSS: APPLY: cleanup extra_info_update_ongoing
>       OMAPDSS: APPLY: add op->enabling
>       OMAPDSS: APPLY: simplify dss_mgr_enable
>       OMAPDSS: APPLY: add dss_setup_fifos
>       OMAPDSS: APPLY: write fifo thresholds only if changed
>       OMAPDSS: APPLY: remove unused variables
>       OMAPDSS: APPLY: move check functions
>       OMAPDSS: APPLY: move simple_check functions
> 
>  arch/arm/mach-omap2/board-4430sdp.c                |   23 +-
>  arch/arm/mach-omap2/board-omap4panda.c             |   25 +-
>  arch/arm/mach-omap2/display.c                      |   39 +
>  drivers/media/video/omap/omap_vout.c               |   33 +-
>  drivers/video/omap/lcd_ams_delta.c                 |   15 +-
>  drivers/video/omap/lcd_h3.c                        |   16 +-
>  drivers/video/omap/lcd_htcherald.c                 |   16 +-
>  drivers/video/omap/lcd_inn1510.c                   |   16 +-
>  drivers/video/omap/lcd_inn1610.c                   |   16 +-
>  drivers/video/omap/lcd_osk.c                       |   16 +-
>  drivers/video/omap/lcd_palmte.c                    |   16 +-
>  drivers/video/omap/lcd_palmtt.c                    |   15 +-
>  drivers/video/omap/lcd_palmz71.c                   |   15 +-
>  drivers/video/omap2/displays/Kconfig               |    2 +-
>  drivers/video/omap2/displays/panel-generic-dpi.c   |   66 +
>  .../omap2/displays/panel-nec-nl8048hl11-01b.c      |   61 +-
>  drivers/video/omap2/displays/panel-taal.c          |   38 +-
>  drivers/video/omap2/dss/Makefile                   |    3 +-
>  drivers/video/omap2/dss/apply.c                    | 1324 ++++++++++++++++++++
>  drivers/video/omap2/dss/core.c                     |    2 +
>  drivers/video/omap2/dss/dispc.c                    |  407 +++----
>  drivers/video/omap2/dss/dispc.h                    |   11 +
>  drivers/video/omap2/dss/dispc_coefs.c              |  326 +++++
>  drivers/video/omap2/dss/dpi.c                      |    7 +-
>  drivers/video/omap2/dss/dsi.c                      |  612 +++++-----
>  drivers/video/omap2/dss/dss.h                      |   74 +-
>  drivers/video/omap2/dss/dss_features.c             |   11 +
>  drivers/video/omap2/dss/dss_features.h             |    1 +
>  drivers/video/omap2/dss/hdmi.c                     |   59 +-
>  drivers/video/omap2/dss/manager.c                  | 1221 ++----------------
>  drivers/video/omap2/dss/overlay.c                  |  435 +++-----
>  drivers/video/omap2/dss/rfbi.c                     |    1 -
>  drivers/video/omap2/dss/sdi.c                      |    8 +-
>  drivers/video/omap2/dss/ti_hdmi.h                  |   10 +-
>  drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c          |   37 +-
>  drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h          |    3 -
>  drivers/video/omap2/dss/venc.c                     |   28 +-
>  drivers/video/omap2/omapfb/omapfb-ioctl.c          |   42 +-
>  drivers/video/omap2/omapfb/omapfb-main.c           |   14 +-
>  drivers/video/omap2/omapfb/omapfb-sysfs.c          |    4 +-
>  drivers/video/omap2/omapfb/omapfb.h                |   11 +-
>  include/video/omapdss.h                            |   58 +-
>  42 files changed, 2883 insertions(+), 2254 deletions(-)
>  create mode 100644 drivers/video/omap2/dss/apply.c
>  create mode 100644 drivers/video/omap2/dss/dispc_coefs.c
> 

