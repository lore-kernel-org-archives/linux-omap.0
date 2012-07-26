From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Subject: Re: [GIT PULL] OMAP DSS for v3.6
Date: Thu, 26 Jul 2012 17:20:23 +0000
Message-ID: <50117C57.2000006@gmx.de>
References: <1342980836.2284.20.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:51937 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752060Ab2GZRUb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jul 2012 13:20:31 -0400
In-Reply-To: <1342980836.2284.20.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev <linux-fbdev@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Archit Taneja <archit@ti.com>

Hi Tomi,

On 07/22/2012 06:13 PM, Tomi Valkeinen wrote:
> Hi Florian,
> 
> Here are OMAP DSS changes for 3.6. The main changes are:
> 
> - Patches from Archit, which reorganize the output side of omapdss. This
> is much cleaner in itself, but will also help us in the future to
> implement the missing omap4 features and omap5+ features.
> 
> - LCD3 patches from Chandrabhanu, which implement the support for LCD3
> overlay manager (for omap5). His patches also generalize the code which
> accesses the overlay manager related registers.
> 
> There hasn't been new patches applied to the DSS tree for 3 weeks, as
> I'm on vacation. The tree has been in linux-next for that period, and I
> haven't received any complaints so I hope the stuff works quite well.
> Archit also reported that he has tested the linux-next, and it seems to
> work fine.
> 
> There is a small conflict, though. This was caused by the two fixes
> "OMAPDSS: fix warnings if CONFIG_PM_RUNTIME=n" and "OMAPDSS: Use PM
> notifiers for system suspend", as I had already applied them into my
> master branch before Archit sent them for you. And as you fixed the code
> formatting issue (sorry about that), we have a small conflict there.
> 
> The conflict is trivial to resolve, and I also pushed for-florian-merged
> branch to the same git tree below, which has the conflict resolved.
> 
> I'm still on vacation for the next week, but I'll check my email every
> now and then to see if there are any issues.
> 
>  Tomi
> 
> 
> The following changes since commit cfaf025112d3856637ff34a767ef785ef5cf2ca9:
> 
>   Linux 3.5-rc2 (2012-06-08 18:40:09 -0700)
> 
> are available in the git repository at:
> 
>   git://gitorious.org/linux-omap-dss2/linux.git for-florian

Merged.


Thanks,

Florian Tobias Schandinat

> 
> for you to fetch changes up to 974a65825e0b5fbda49605f0416a2c975d66e9e6:
> 
>   Merge "Apply LCD manager related parameters" from Archit (2012-06-29 14:13:07 +0300)
> 
> ----------------------------------------------------------------
> 
> Archit Taneja (27):
>       OMAPDSS: Remove passive matrix LCD support (part 1)
>       OMAPDSS: Remove passive matrix LCD support (part 2)
>       OMAPDSS: Remove passive matrix LCD support (part 3)
>       OMAPDSS: Remove passive matrix LCD support (part 4)
>       OMAPDSS: Add some new fields to omap_video_timings
>       OMAPDSS: DISPLAY: Ignore newly added omap_video_timings fields for display timings sysfs file
>       OMAPDSS: DISPC: Configure newly added omap_video_timing fields
>       OMAPDSS: DISPC: Remove dispc_mgr_set_pol_freq()
>       OMAPFB: Map the newly added omap_video_timings fields with fb sync flags
>       OMAPDSS: Remove omap_panel_config enum from omap_dss_device
>       OMAPDSS: Add interlace parameter to omap_video_timings
>       OMAPDSS: DISPC/APPLY: Use interlace info in manager timings for dispc_ovl_setup()
>       OMAPFB: Map interlace field in omap_video_timings with fb vmode flags
>       OMAPDSS: HDMI: Remove custom hdmi_video_timings struct
>       OMAPDSS: DSI: Fix HSYNC, VSYNC and DE polarities between DISPC and DSI
>       OMAPDSS: DISPC: Change return type of dispc_mgr_set_clock_div()
>       OMAPDSS: Add struct to hold LCD overlay manager configuration
>       OMAPDSS: DPI: Configure dss_lcd_mgr_config struct with lcd manager parameters
>       OMAPDSS: RFBI: Configure dss_lcd_mgr_config struct with lcd manager parameters
>       OMAPDSS: DSI: Configure dss_lcd_mgr_config struct with lcd manager parameters
>       OMAPDSS: SDI: Configure dss_lcd_mgr_config struct with lcd manager parameters
>       OMAPDSS: APPLY: Remove DISPC writes to manager's lcd parameters in interface drivers
>       OMAPDSS: MANAGER: Check LCD related overlay manager parameters
>       OMAPDSS: APPLY: Remove usage of omap_dss_device from manual/auto update checks
>       OMAPDSS: DISPC: Remove a redundant function
>       OMAPDSS: RFBI: Use dss_mgr_enable to enable the overlay manager
>       OMAPDSS: OVERLAY: Clean up replication checking
> 
> Chandrabhanu Mahapatra (5):
>       OMAPDSS: Cleanup implementation of LCD channels
>       OMAPDSS: Add support for LCD3 channel
>       OMAPDSS: Add LCD3 overlay manager and Clock and IRQ support
>       OMAPDSS: Add dump and debug support for LCD3
>       ARM: OMAP2PLUS: DSS: Disable LCD3 output when resetting DSS
> 
> Jassi Brar (2):
>       OMAPDSS: HDMI: Discard phy_tx_enabled member
>       OMAPDSS: HDMI: Replace spinlock with mutex in hdmi_check_hpd_state
> 
> Peter Meerwald (1):
>       OMAPDSS: fix specification spelling in Kconfig
> 
> Rajendra Nayak (1):
>       OMAPDSS: add clk_prepare_enable and clk_disable_unprepare
> 
> Tomi Valkeinen (6):
>       Merge tag 'v3.5-rc2'
>       OMAPDSS: remove enum omap_dss_overlay_managers
>       OMAPDSS: Use PM notifiers for system suspend
>       OMAPDSS: fix warnings if CONFIG_PM_RUNTIME=n
>       Merge Misc DSS clean ups from Archit
>       Merge "Apply LCD manager related parameters" from Archit
> 
>  arch/arm/mach-omap2/display.c                      |   29 +-
>  drivers/video/omap2/displays/panel-acx565akm.c     |   10 +-
>  drivers/video/omap2/displays/panel-generic-dpi.c   |  179 ++++---
>  .../omap2/displays/panel-lgphilips-lb035q02.c      |    8 +-
>  drivers/video/omap2/displays/panel-n8x0.c          |    1 -
>  .../omap2/displays/panel-nec-nl8048hl11-01b.c      |    9 +-
>  drivers/video/omap2/displays/panel-picodlp.c       |    9 +-
>  .../video/omap2/displays/panel-sharp-ls037v7dw01.c |    9 +-
>  drivers/video/omap2/displays/panel-taal.c          |    3 +-
>  drivers/video/omap2/displays/panel-tfp410.c        |    7 +-
>  .../video/omap2/displays/panel-tpo-td043mtea1.c    |    8 +-
>  drivers/video/omap2/dss/Kconfig                    |    4 +-
>  drivers/video/omap2/dss/apply.c                    |   91 +++-
>  drivers/video/omap2/dss/core.c                     |   48 +-
>  drivers/video/omap2/dss/dispc.c                    |  496 ++++++++++----------
>  drivers/video/omap2/dss/dispc.h                    |   28 ++
>  drivers/video/omap2/dss/display.c                  |   40 +-
>  drivers/video/omap2/dss/dpi.c                      |   64 +--
>  drivers/video/omap2/dss/dsi.c                      |  156 +++---
>  drivers/video/omap2/dss/dss.c                      |   21 +-
>  drivers/video/omap2/dss/dss.h                      |   54 ++-
>  drivers/video/omap2/dss/dss_features.h             |    5 +-
>  drivers/video/omap2/dss/hdmi.c                     |  248 ++++++++--
>  drivers/video/omap2/dss/hdmi_panel.c               |    9 +-
>  drivers/video/omap2/dss/manager.c                  |   51 +-
>  drivers/video/omap2/dss/overlay.c                  |   33 +-
>  drivers/video/omap2/dss/rfbi.c                     |   42 +-
>  drivers/video/omap2/dss/sdi.c                      |   42 +-
>  drivers/video/omap2/dss/ti_hdmi.h                  |   21 +-
>  drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c          |   26 +-
>  drivers/video/omap2/dss/venc.c                     |   10 +-
>  drivers/video/omap2/omapfb/omapfb-main.c           |   51 +-
>  include/video/omapdss.h                            |   51 +-
>  33 files changed, 1172 insertions(+), 691 deletions(-)
> 

