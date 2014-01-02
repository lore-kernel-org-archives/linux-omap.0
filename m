From: Archit Taneja <archit@ti.com>
Subject: [PATCH v3 0/4] drm/omap: fix issues in omap_drv probe/remove
Date: Thu, 2 Jan 2014 14:49:50 +0530
Message-ID: <1388654394-5708-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52409 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711AbaABJUE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Jan 2014 04:20:04 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, robdclark@gmail.com
Cc: linux-omap@vger.kernel.org, tomi.valkeinen@ti.com, Archit Taneja <archit@ti.com>

At the moment, the omapdrm driver doesn't work on panda/beagle when built-in
the kernel. The problem is that omapdrm doesn't defer probe if resources like
regulator/I2C etc are missing. The first patch fixes that.

The next 3 patches make sure that omapdrm module can be inserted and removed
successively, and that omapdss is left in a consistent state when omapdrm is
removed.

In the previous version of this series, there was a warning related to apply_irq
being registered seen while removing omapdrm. This was a relatively scary
warning, therefore, the "change dev_unload order" patch was added to make sure
we don't see that.

After these fixes, I still see the warning below once in a while. I don't know
how to fix it at the moment, but it's harmless and omapdrm is now usable again.
These are critical fixes which I have posted since 3.12-rcs, it would be nice if
they can go in as soon as possible.

# rmmod omapdrm.ko
[  108.826568] [drm:drm_crtc_helper_set_config],
[  108.826568] [drm:drm_crtc_helper_set_config], [CRTC:7] [FB:15] #connectors=1 (x y) (0 0)
[  108.840362] [drm:drm_crtc_helper_set_config], [CONNECTOR:4:HDMI-A-1] to [CRTC:7]
[  108.844879] [drm:drm_crtc_helper_set_config],
[  108.852813] [drm:drm_crtc_helper_set_config], [CRTC:9] [NOFB]
[  108.866821] drm_kms_helper: drm: unregistered panic notifier
[  108.901977] [drm:drm_crtc_helper_set_config],
[  108.901977] [drm:drm_crtc_helper_set_config], [CRTC:7] [NOFB]
[  108.918731] ------------[ cut here ]------------
[  108.918731] WARNING: CPU: 1 PID: 1611 at drivers/gpu/drm/drm_crtc.c:4079 drm_mode_config_cleanup+0x238/0x250 [drm]()
[  108.918731] Modules linked in: omapdrm(-) connector_hdmi encoder_tpd12s015 omapdss sysfillrect sysimgblt syscopyarea fb_sys_fops drm_kms_helper drm
[  108.918975] CPU: 1 PID: 1611 Comm: rmmod Not tainted 3.13.0-rc5-00003-gdf839f2 #137
[  108.918975] [<c0015ef8>] (unwind_backtrace+0x0/0xf0) from [<c0012c9c>] (show_stack+0x10/0x14)
[  108.918975] [<c0012c9c>] (show_stack+0x10/0x14) from [<c0591f58>] (dump_stack+0x70/0x8c)
[  108.919036] [<c0591f58>] (dump_stack+0x70/0x8c) from [<c0042f30>] (warn_slowpath_common+0x6c/0x8c)
[  108.919067] [<c0042f30>] (warn_slowpath_common+0x6c/0x8c) from [<c0042f6c>] (warn_slowpath_null+0x1c/0x24)
[  108.919067] [<c0042f6c>] (warn_slowpath_null+0x1c/0x24) from [<bf00f3a4>] (drm_mode_config_cleanup+0x238/0x250 [drm])
[  108.919067] [<bf00f3a4>] (drm_mode_config_cleanup+0x238/0x250 [drm]) from [<bf0e7454>] (dev_unload+0x40/0x94 [omapdrm])
[  108.919067] [<bf0e7454>] (dev_unload+0x40/0x94 [omapdrm]) from [<bf008830>] (drm_dev_unregister+0x24/0xb4 [drm])
[  108.919067] [<bf008830>] (drm_dev_unregister+0x24/0xb4 [drm]) from [<bf0090dc>] (drm_put_dev+0x2c/0x58 [drm])
[  108.919067] [<bf0090dc>] (drm_put_dev+0x2c/0x58 [drm]) from [<bf00a52c>] (drm_platform_exit+0x30/0x5c [drm])
[  108.919067] [<bf00a52c>] (drm_platform_exit+0x30/0x5c [drm]) from [<bf0e7604>] (pdev_remove+0x28/0x54 [omapdrm])
[  108.919067] [<bf0e7604>] (pdev_remove+0x28/0x54 [omapdrm]) from [<c037ddb8>] (platform_drv_remove+0x18/0x1c)
[  108.920074] [<c037ddb8>] (platform_drv_remove+0x18/0x1c) from [<c037c534>] (__device_release_driver+0x70/0xcc)
[  108.920074] [<c037c534>] (__device_release_driver+0x70/0xcc) from [<c037cd64>] (driver_detach+0xb4/0xb8)
[  108.920104] [<c037cd64>] (driver_detach+0xb4/0xb8) from [<c037c35c>] (bus_remove_driver+0x4c/0x90)
[  108.920135] [<c037c35c>] (bus_remove_driver+0x4c/0x90) from [<c00b179c>] (SyS_delete_module+0x120/0x1a0)
[  108.920135] [<c00b179c>] (SyS_delete_module+0x120/0x1a0) from [<c000ea60>] (ret_fast_syscall+0x0/0x48)
[  108.920135] ---[ end trace ea955a36fdb8bfbc ]---


Archit Taneja (4):
  drm/omap: fix: Defer probe if an omapdss device requests for it at
    connect
  drm/omap: fix: disconnect devices when omapdrm module is removed
  drm/omap: fix: disable encoder before destroying it
  drm/omap: fix: change dev_unload order

 drivers/gpu/drm/omapdrm/omap_crtc.c    |  5 ++
 drivers/gpu/drm/omapdrm/omap_drv.c     | 83 ++++++++++++++++++++++++----------
 drivers/gpu/drm/omapdrm/omap_drv.h     |  1 +
 drivers/gpu/drm/omapdrm/omap_encoder.c |  3 ++
 4 files changed, 67 insertions(+), 25 deletions(-)

-- 
1.8.3.2

