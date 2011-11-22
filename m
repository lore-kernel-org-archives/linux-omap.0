From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 00/65] OMAPDSS: manager/apply improvements
Date: Tue, 22 Nov 2011 11:20:59 +0200
Message-ID: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:48272 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754921Ab1KVJWc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 04:22:32 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

I started writing this patch series to get DSS's fifo-merge feature working,
but in the end the series grew a bit...

The reason why fifo-merge is tricky is that enabling or disabling the
fifo-merge affects multiple overlays and overlay managers at the same time. In
practice this means we need to enable and disable fifo-merge in steps, doing
first one thing, then waiting for the changes to be synchronized with all the
overlay managers, then doing another thing, etc... This could be done with a
complex state machine, or more simply with blocking functions.

The basic idea to get this done is to divide ovl & mgr functions into two sets.
First set is non-blocking, using only spinlocks, and used to change settings
which affect only that one ovl or mgr. set/get_info() and apply() functions are
in this set. The second set may block. The rest of the functions are in this
set, for example overlay enable/disable. 

To get there wasn't as simple as I thought, so the patch series grew. I am
quite content with the end result, though, as it cleans up the whole
apply-mechanism of omapdss rather lot, and the locking scheme should finally be
valid. There are still holes in the locking scheme, related to the panel
drivers, but the locks in apply.c should be solid.

Almost all of the changes are not visible to the users of the omapdss, but some
changes are visible. The notable changes to the users of omapdss in this series
are:

* Overlays enable/disable is no longer handled through the overlay_info struct,
  but functions. The overlay struct contains enable, disable and is_enabled
  functions to handle that. Note: enable and disable may block!
* Ovl/mgr infos are no longer visible directly, but need to be gotten with the
  get_info functions.
* Partial update for manual update displays has been removed. To my knowledge
  partial update is not used, it doesn't work exactly right, using it requires
  the user to know limitations about the underlying HW, and lastly and most
  importantly, it makes the configuration code really messy.

And the original reason for this series, fifo-merge, is actually still missing.
There are some problems with it when using two displays at the same time, and
it's still under study. Also OMAP4's more advanced fifo-configuration is under
work, and I plan to push both of those later. For those interested, the current
fifo-merge patches can be found from my git tree, on top of this series, from:

git://gitorious.org/linux-omap-dss2/linux.git manager-work

 Tomi

Tomi Valkeinen (65):
  OMAPDSS: DISPC: add missing prototype
  OMAPDSS: Remove old fifomerge hacks
  OMAPDSS: remove L4_EXAMPLE code
  OMAPDSS: DISPC: make dispc_ovl_set_channel_out() public
  OMAPDSS: DISPC: make dispc_ovl_set_fifo_threshold() public
  OMAPDSS: remove partial update from the overlay manager
  OMAPDSS: remove partial update from DSI
  OMAPDSS: remove partial update from panel-taal
  OMAPDSS: pass ovl manager to dss_start_update
  OMAPDSS: DISPC: handle 0 out_width/out_height in ovl_setup()
  OMAPDSS: handle ilace/replication when configuring overlay
  OMAPDSS: separate FIFO threshold setup from ovl_setup
  OMAPDSS: separate overlay channel from ovl_setup
  OMAPDSS: setup manager with dispc_mgr_setup()
  OMAPDSS: DISPC: remove unused functions
  OMAPDSS: remove unneeded dss_ovl_wait_for_go()
  OMAPDSS: add ovl/mgr_manual_update() helpers
  OMAPDSS: split omap_dss_mgr_apply() to smaller funcs
  OMAPDSS: apply affects only one overlay manager
  OMAPDSS: create apply.c
  OMAPDSS: hide manager's enable/disable()
  OMAPDSS: APPLY: track whether a manager is enabled
  OMAPDSS: APPLY: skip isr register and config for manual update
    displays
  OMAPDSS: APPLY: skip isr register and config for disabled displays
  OMAPDSS: APPLY: cleanup dss_start_update
  OMAPDSS: store overlays in an array
  OMAPDSS: store managers in an array
  OMAPDSS: store overlays in a list for each manager
  OMAPDSS: APPLY: separate vsync isr register/unregister
  OMAPDSS: DISPC: Add dispc_mgr_get_vsync_irq()
  OMAPDSS: APPLY: use dispc_mgr_get_vsync_irq()
  OMAPDSS: APPLY: configure_* funcs take ovl/manager as args
  OMAPDSS: APPLY: rename overlay_cache_data
  OMAPDSS: APPLY: rename manager_cache_data
  OMAPDSS: APPLY: move spinlock outside the struct
  OMAPDSS: APPLY: rename dss_cache to dss_data
  OMAPDSS: APPLY: move ovl funcs to apply.c
  OMAPDSS: APPLY: move mgr funcs to apply.c
  OMAPDSS: remove ovl/mgr check-code temporarily
  OMAPDSS: APPLY: add mutex
  OMAPDSS: APPLY: add missing uses of spinlock
  OMAPDSS: DSI: call mgr_enable/disable for cmd mode displays
  OMAPDSS: APPLY: move mgr->enabled to mgr_priv_data
  OMAPDSS: APPLY: add busy field to mgr_priv_data
  OMAPDSS: APPLY: rewrite overlay enable/disable
  OMAPDSS: APPLY: rewrite register writing
  OMAPDSS: DISPC: add dispc_mgr_get_framedone_irq
  OMAPDSS: APPLY: add updating flag
  OMAPDSS: APPLY: clean up isr_handler
  OMAPDSS: APPLY: move mgr->info to apply.c
  OMAPDSS: APPLY: move ovl->info to apply.c
  OMAPDSS: APPLY: move channel-field to extra_info set
  OMAPDSS: APPLY: move fifo thresholds to extra_info set
  OMAPDSS: APPLY: rename dirty & shadow_dirty
  OMAPDSS: APPLY: remove device_changed field
  OMAPDSS: APPLY: add dss_apply_ovl_enable()
  OMAPDSS: APPLY: skip enable/disable if already enabled/disabled
  OMAPDSS: APPLY: add wait_pending_extra_info_updates()
  OMAPDSS: APPLY: remove runtime_get
  OMAPDSS: Add comments about blocking of ovl/mgr functions
  OMAPDSS: APPLY: add dss_ovl_simple_check()
  OMAPDSS: APPLY: add dss_mgr_simple_check()
  OMAPDSS: APPLY: add checking of ovls/mgrs settings
  OMAPDSS: APPLY: add return value to dss_mgr_enable()
  OMAPDSS: check the return value of dss_mgr_enable()

 drivers/media/video/omap/omap_vout.c      |   33 +-
 drivers/video/omap2/displays/panel-taal.c |   38 +-
 drivers/video/omap2/dss/Makefile          |    3 +-
 drivers/video/omap2/dss/apply.c           | 1420 +++++++++++++++++++++++++++++
 drivers/video/omap2/dss/core.c            |    2 +
 drivers/video/omap2/dss/dispc.c           |  191 ++--
 drivers/video/omap2/dss/dpi.c             |    7 +-
 drivers/video/omap2/dss/dsi.c             |  169 ++--
 drivers/video/omap2/dss/dss.h             |   64 +-
 drivers/video/omap2/dss/hdmi.c            |   13 +-
 drivers/video/omap2/dss/manager.c         | 1153 +----------------------
 drivers/video/omap2/dss/overlay.c         |  357 ++------
 drivers/video/omap2/dss/rfbi.c            |    1 -
 drivers/video/omap2/dss/sdi.c             |    8 +-
 drivers/video/omap2/dss/venc.c            |   28 +-
 drivers/video/omap2/omapfb/omapfb-ioctl.c |   42 +-
 drivers/video/omap2/omapfb/omapfb-main.c  |   14 +-
 drivers/video/omap2/omapfb/omapfb-sysfs.c |    4 +-
 drivers/video/omap2/omapfb/omapfb.h       |   11 +-
 include/video/omapdss.h                   |   52 +-
 20 files changed, 1891 insertions(+), 1719 deletions(-)
 create mode 100644 drivers/video/omap2/dss/apply.c

-- 
1.7.4.1

