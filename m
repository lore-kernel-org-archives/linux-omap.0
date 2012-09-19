From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 0/8] OMAPDSS: dss device model changes
Date: Wed, 19 Sep 2012 11:30:30 +0300
Message-ID: <1348043438-2624-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:54273 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752313Ab2ISIbC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Sep 2012 04:31:02 -0400
Received: by lbbgj3 with SMTP id gj3so618879lbb.19
        for <linux-omap@vger.kernel.org>; Wed, 19 Sep 2012 01:31:00 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Steve Sakoman <steve@sakoman.com>, Lajos Molnar <lajos@ti.com>, Jassi Brar <jaswinder.singh@linaro.org>, Grazvydas Ignotas <notasas@gmail.com>, Vaibhav Hiremath <hvaibhav@ti.com>

Hi,

This series contains patches that change how omapdss's panel devices
(omap_dss_device) are initialized and registered. There are two patches that
change behaviour, the rest should be just cleanups:

The patch "omap_dss_register_device() doesn't take display index" affects the
number for the "displayX" sysfs files. This hopefully doesn't affect the
userspace, as the number has never been a clear indication of what the
particular display is.

The patch "register only one display device per output" affects how panel
devices are created. Currently we support multiple panels per output, i.e. you
could have DVI and an LCD displays using the same DPI output, as long as the
DVI and LCD are not used at the same time.

This patch changes the omapdss driver to only register one display device per
output. If there are multiple displays for the output, either the first one is
picked or, if def_display has been defined in kernel parameters and the
def_display is one of the displays for this output, the def_display is picked.
See the patch for more information.

My belief is that neither patch should break things, but there's the
possibility. So I've tried to cc people who might have an opinion about this,
or perhaps test their setup with these patches.

The series is based on the latest omapdss master branch, and is available at:

git://gitorious.org/linux-omap-dss2/linux.git work/devtree-base

 Tomi

Tomi Valkeinen (8):
  OMAPDSS: omap_dss_register_device() doesn't take display index
  OMAPDSS: Add dss_get_default_display_name()
  OMAPDSS: register only one display device per output
  OMAPDSS: explicitely initialize dssdev->channel for new displays
  OMAPDSS: handle errors in dss_init_device
  OMAPDSS: cleanup dss_recheck_connections
  OMAPDSS: cleanup dss_recheck_connections further
  OMAPDSS: alloc dssdevs dynamically

 drivers/video/omap2/dss/core.c    |   91 +++++++++++++++++++------------------
 drivers/video/omap2/dss/display.c |   85 +++++++++++++++++++++++++++++++---
 drivers/video/omap2/dss/dpi.c     |   58 ++++++++++++++++++-----
 drivers/video/omap2/dss/dsi.c     |   62 +++++++++++++++++++------
 drivers/video/omap2/dss/dss.h     |   15 +++---
 drivers/video/omap2/dss/hdmi.c    |   70 ++++++++++++++++++++++------
 drivers/video/omap2/dss/overlay.c |   69 ----------------------------
 drivers/video/omap2/dss/rfbi.c    |   58 ++++++++++++++++++-----
 drivers/video/omap2/dss/sdi.c     |   58 ++++++++++++++++++-----
 drivers/video/omap2/dss/venc.c    |   60 +++++++++++++++++++-----
 10 files changed, 428 insertions(+), 198 deletions(-)

-- 
1.7.9.5

