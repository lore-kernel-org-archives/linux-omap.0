From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Subject: Re: [GIT PULL] OMAP DSS for v3.4
Date: Wed, 21 Mar 2012 18:45:11 +0000
Message-ID: <4F6A21B7.5050902@gmx.de>
References: <1332154865.2144.57.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:36744 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754599Ab2CUSpl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Mar 2012 14:45:41 -0400
In-Reply-To: <1332154865.2144.57.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org, linux-fbdev <linux-fbdev@vger.kernel.org>

On 03/19/2012 11:01 AM, Tomi Valkeinen wrote:
> Hi Florian, Arnd,
> 
> Here are the changes for OMAP DSS driver for v3.4.
> 
> There's an issue with the dss driver that appears on arm-soc/for-next
> branch, which I'm still solving
> (http://marc.info/?l=linux-omap&m=133214966902577&w=2). I hope to get
> fix for that ready and merged for -rc1, but I'm not sure if I can make
> it in time, so I wanted to sent this pull request already.
> 
> Arnd, as discussed before, you can also merge this branch to solve the
> conflicts between arm-soc and omapdss trees.
> 
> Note that this is the first pull request I've sent with a branch that I
> have not been rebasing, so please check that the branch looks sane.
> 
>  Tomi
> 
> The following changes since commit c16fa4f2ad19908a47c63d8fa436a1178438c7e7:
> 
>   Linux 3.3 (2012-03-18 16:15:34 -0700)

Interesting, I never tried to start at a commit that is not part of the
branch. Good to know that it does work.

> 
> are available in the git repository at:
>   git://gitorious.org/linux-omap-dss2/linux.git for-3.4

Merged.


Thanks,

Florian Tobias Schandinat

> 
> Archit Taneja (2):
>       OMAPDSS: Features: Maintain dss_feats as a list
>       OMAPDSS: DISPC: Fix scaling constraints for OMAP4
> 
> Danny Kukawka (1):
>       OMAPDSS: VENC: fix NULL pointer dereference in DSS2 VENC sysfs debug attr on OMAP4
> 
> Grazvydas Ignotas (2):
>       OMAPDSS: TPO-TD03MTEA1: fix suspend hang
>       OMAPDSS: TPO-TD03MTEA1: update default gamma
> 
> Julia Lawall (1):
>       OMAPDSS: use devm_ functions
> 
> Lajos Molnar (3):
>       OMAPDSS: DISPC: Fix OMAP4 supported color formats
>       OMAPDSS: DISPC: Fix FIR coefficients
>       OMAPDSS: MANAGER/APPLY: Add runtime_pm protection around wait_for_go/vsync functions
> 
> Mythri P K (6):
>       OMAPDSS: HDMI: remove duplicate video interface code
>       OMAPDSS: HDMI: update static timing table
>       OMAPDSS: HDMI: change the timing match logic
>       OMAPDSS: HDMI: remove duplicate code and mode parameter
>       OMAPDSS: HDMI: Move Avi-infoframe struct to hdmi_ip_data
>       OMAPDSS: HDMI: Add M2 divider while calculating clkout
> 
> Ricardo Neri (4):
>       OMAPDSS: HDMI: Correct source of the pixel clock in ACR calculation
>       OMAPDSS: Add DSS feature for HDMI MCLK for audio
>       OMAPDSS: HDMI: Implement initialization of MCLK
>       OMAPDSS: HDMI: Modify logic to configure MCLK
> 
> Tomi Valkeinen (29):
>       OMAPDSS: FEAT: Add FIFO_MERGE feature
>       OMAPDSS: APPLY: add fifo merge support funcs
>       OMAPDSS: APPLY: add fifo-merge support
>       OMAPDSS: DISPC: print fifo threshold values in bytes
>       OMAPDSS: DISPC: move fifo threhold calc to dispc.c
>       OMAPDSS: DISPC: Add naive threshold calc for fifomerge
>       Merge branch 'work/fifomerge'
>       Merge commit 'v3.3-rc4'
>       OMAPDSS: cleanup probe functions
>       OMAPFB: remove old blizzard driver
>       OMAPFB: Remove OMAP2/3 support from old omapfb driver
>       OMAPDSS: Remove video SRAM support
>       OMAPFB: Remove video SRAM support (old omapfb)
>       OMAP2+: remove unneeded #include omapfb.h
>       OMAP: N770: remove HWA742 platform data
>       OAMPFB: remove unused omapfb_set_ctrl_platform_data()
>       OMAPFB: remove early mem alloc from old omapfb
>       OMAPFB: remove mem info from platform_data
>       OMAPFB: remove unused fb_format_to_dss_mode()
>       OMAPFB: Move old omapfb private structs to a private include file
>       OMAPFB: remove omapfb_set_platform_data()
>       OMAP1: pass LCD config with omapfb_set_lcd_config()
>       OMAP: Remove OMAP_TAG_LCD and OMAP_TAG_FBMEM
>       OMAP1: Remove unused LCD devices from board files
>       OMAPFB: remove remaining OMAP arch checks
>       Merge branch 'work/old-omapfb-removal'
>       Merge commit 'v3.3-rc6'
>       OMAPDSS: APPLY: print warning if wait_pending_extra_info_updates fails
>       OMAPDSS: APPLY: fix clearing shadow dirty flag with manual update
> 
> Tony Lindgren (1):
>       ARM: OMAP2+: Fix compile error when FB_OMAP2 is not set
> 
> Yegor Yefremov (1):
>       OMAPDSS: add Innolux AT080TN52 display support
> 
>  arch/arm/mach-omap1/board-ams-delta.c              |    9 +-
>  arch/arm/mach-omap1/board-fsample.c                |   15 +-
>  arch/arm/mach-omap1/board-h2.c                     |   15 +-
>  arch/arm/mach-omap1/board-h3.c                     |    9 +-
>  arch/arm/mach-omap1/board-htcherald.c              |    9 +-
>  arch/arm/mach-omap1/board-innovator.c              |   11 +-
>  arch/arm/mach-omap1/board-nokia770.c               |   19 +-
>  arch/arm/mach-omap1/board-osk.c                    |   14 +-
>  arch/arm/mach-omap1/board-palmte.c                 |   10 +-
>  arch/arm/mach-omap1/board-palmtt.c                 |   10 +-
>  arch/arm/mach-omap1/board-palmz71.c                |   10 +-
>  arch/arm/mach-omap1/board-perseus2.c               |   15 +-
>  arch/arm/mach-omap1/board-sx1.c                    |   16 +-
>  arch/arm/mach-omap2/io.c                           |    1 -
>  arch/arm/plat-omap/common.c                        |    2 -
>  arch/arm/plat-omap/fb.c                            |  334 +----
>  arch/arm/plat-omap/fb.h                            |   10 -
>  arch/arm/plat-omap/include/plat/blizzard.h         |   12 -
>  arch/arm/plat-omap/include/plat/board.h            |    2 -
>  arch/arm/plat-omap/include/plat/hwa742.h           |    8 -
>  arch/arm/plat-omap/include/plat/vram.h             |   21 +-
>  drivers/video/omap/Kconfig                         |   16 +-
>  drivers/video/omap/Makefile                        |   12 +-
>  drivers/video/omap/blizzard.c                      | 1648 --------------------
>  drivers/video/omap/dispc.c                         | 1547 ------------------
>  drivers/video/omap/dispc.h                         |   46 -
>  drivers/video/omap/hwa742.c                        |   21 +-
>  drivers/video/omap/omapfb.h                        |   25 +-
>  drivers/video/omap/omapfb_main.c                   |   30 +-
>  drivers/video/omap/rfbi.c                          |  598 -------
>  drivers/video/omap2/displays/panel-generic-dpi.c   |   23 +
>  .../video/omap2/displays/panel-tpo-td043mtea1.c    |  153 ++-
>  drivers/video/omap2/dss/apply.c                    |  275 +++-
>  drivers/video/omap2/dss/dispc.c                    |  121 +-
>  drivers/video/omap2/dss/dispc_coefs.c              |    9 +-
>  drivers/video/omap2/dss/display.c                  |   10 -
>  drivers/video/omap2/dss/dsi.c                      |   65 +-
>  drivers/video/omap2/dss/dss.c                      |   17 +-
>  drivers/video/omap2/dss/dss.h                      |   10 +-
>  drivers/video/omap2/dss/dss_features.c             |  181 ++-
>  drivers/video/omap2/dss/dss_features.h             |   54 +-
>  drivers/video/omap2/dss/hdmi.c                     |  278 ++--
>  drivers/video/omap2/dss/manager.c                  |   12 +-
>  drivers/video/omap2/dss/rfbi.c                     |   36 +-
>  drivers/video/omap2/dss/ti_hdmi.h                  |   56 +-
>  drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c          |   94 +-
>  drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h          |   47 -
>  drivers/video/omap2/dss/venc.c                     |   32 +-
>  drivers/video/omap2/omapfb/omapfb-ioctl.c          |    2 +-
>  drivers/video/omap2/omapfb/omapfb-main.c           |  101 +--
>  drivers/video/omap2/vram.c                         |   99 +--
>  include/linux/omapfb.h                             |   32 +-
>  52 files changed, 1001 insertions(+), 5201 deletions(-)
>  delete mode 100644 arch/arm/plat-omap/fb.h
>  delete mode 100644 arch/arm/plat-omap/include/plat/blizzard.h
>  delete mode 100644 arch/arm/plat-omap/include/plat/hwa742.h
>  delete mode 100644 drivers/video/omap/blizzard.c
>  delete mode 100644 drivers/video/omap/dispc.c
>  delete mode 100644 drivers/video/omap/dispc.h
>  delete mode 100644 drivers/video/omap/rfbi.c
> 

