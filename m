From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 0/3] OMAPFB: Move auto-update to omapfb
Date: Mon, 13 Jun 2011 12:12:51 +0300
Message-ID: <1307956374-1107-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:32840 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755110Ab1FMJNE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Jun 2011 05:13:04 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

OMAP DSS driver has currently support to change the display's update mode from
manual to auto, but it's up to the display to implement support for this.
Normally displays only support one update mode.

As the the update mode support adds extra code to a place where it doesn't
really belong, this patch set removes update mode support from omapdss, and
implements a simple version of it in omapfb.

This will:
* Clean up omapdss
* Keep the omapfb's ioctl interface intact with functional update-mode ioctls
* Allow us to support auto-update for manual update displays for testing
* Allow us to do the above with the code in single place, for all manual-update
  displays, without any changes needed in display drivers

Auto-update for manual-update displays should be considered a hack, used only
for testing or temporarily running a userspace that doesn't properly support
manual-update displays. It should not be used in production systems.

The patches create a private workqueue for the update work to minimize impact
on other parts of the system. As this auto-update feature is not normally used,
the workqueue is only created when needed.

 Tomi

Tomi Valkeinen (3):
  OMAP: DSS2: OMAPFB: Add struct to store per-display data
  OMAP: DSS2: OMAPFB: Implement auto-update mode
  OMAP: DSS2: remove update_mode from omapdss

 drivers/video/omap2/displays/panel-taal.c |   17 ---
 drivers/video/omap2/dss/display.c         |   45 --------
 drivers/video/omap2/dss/manager.c         |   59 +++--------
 drivers/video/omap2/dss/venc.c            |   17 ---
 drivers/video/omap2/omapfb/omapfb-ioctl.c |   72 +++++++-------
 drivers/video/omap2/omapfb/omapfb-main.c  |  159 +++++++++++++++++++++++------
 drivers/video/omap2/omapfb/omapfb-sysfs.c |   34 ++++++
 drivers/video/omap2/omapfb/omapfb.h       |   37 ++++++-
 include/video/omapdss.h                   |   11 --
 9 files changed, 241 insertions(+), 210 deletions(-)

-- 
1.7.4.1

