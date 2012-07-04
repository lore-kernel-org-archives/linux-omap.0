From: Archit Taneja <archit@ti.com>
Subject: [PATCH 0/2] OMAPDSS: PM runtime fixes for 3.5-rc
Date: Wed, 4 Jul 2012 18:13:47 +0530
Message-ID: <1341405829-16964-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38452 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153Ab2GDMpJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jul 2012 08:45:09 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: FlorianSchandinat@gmx.de
Cc: tomi.valkeinen@ti.com, jaswinder.singh@linaro.org, jw@terrafix.co.uk, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Hi Florian,

These are 2 fixes which Tomi had intended to push for the coming rcs. He is
currently on vacation and asked me to post the patches on his behalf.

The first patch ensures that system suspend doesn't break on OMAP if DSS is
enabled. The second patch prevents some warning backtraces when the kernel is
not built with PM runtime.

Could you please queue these for the upcoming rc?

Thanks,
Archit

Tomi Valkeinen (2):
  OMAPDSS: Use PM notifiers for system suspend
  OMAPDSS: fix warnings if CONFIG_PM_RUNTIME=n

 drivers/video/omap2/dss/core.c  |   45 +++++++++++++++++++++++++--------------
 drivers/video/omap2/dss/dispc.c |    2 +-
 drivers/video/omap2/dss/dsi.c   |    2 +-
 drivers/video/omap2/dss/dss.c   |    2 +-
 drivers/video/omap2/dss/hdmi.c  |    2 +-
 drivers/video/omap2/dss/rfbi.c  |    2 +-
 drivers/video/omap2/dss/venc.c  |    2 +-
 7 files changed, 35 insertions(+), 22 deletions(-)

-- 
1.7.9.5

