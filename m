From: Rob Clark <robdclark@gmail.com>
Subject: [PATCH 0/4] TI LCDC DRM driver
Date: Tue, 22 Jan 2013 16:36:21 -0600
Message-ID: <1358894185-21617-1-git-send-email-robdclark@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:43731 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683Ab3AVWga (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jan 2013 17:36:30 -0500
Received: by mail-oa0-f52.google.com with SMTP id o6so7678339oag.39
        for <linux-omap@vger.kernel.org>; Tue, 22 Jan 2013 14:36:29 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org
Cc: patches@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rob Clark <robdclark@gmail.com>

I think this driver is ready to go, so I've removed the 'RFC' tag.  Prove
me wrong by reviewing the patches and sending comments ;-)

The first patch adds the basic driver and TFP410 DVI output.

The second patch adds support for NXP TDA998x family of i2c connected
HDMI encoders.  It is split out into an i2c encoder-slave in case someone
else has hw with the same HDMI encoder.

The final patch adds support for LCD panels, with timings and panel info
coming from device-tree.

The patch set has dependencies on the following patches that I have sent
earlier (which have not changed since then so I am not resending):

 * drm/cma: add debugfs helpers
 * drm: i2c encoder helper wrappers

In addition, the LCD panel patch also depends on Steffen Trumtrar's OF
display helper series. I've moved this patch to last so it can be merged
later if needed.  Although I really see no reason not to merge the OF
display helper series for 3.9.

These patches and their dependencies can also be found here:

  git://people.freedesktop.org/~robclark/linux tilcdc-next
  http://cgit.freedesktop.org/~robclark/linux/log/?h=tilcdc-next

Rob Clark (4):
  drm/tilcdc: add TI LCD Controller DRM driver (v3)
  drm/i2c: nxp-tda998x (v2)
  drm/tilcdc: add encoder slave
  drm/tilcdc: add support for LCD panels (v4)

 drivers/gpu/drm/Kconfig                |   2 +
 drivers/gpu/drm/Makefile               |   1 +
 drivers/gpu/drm/i2c/Makefile           |   3 +
 drivers/gpu/drm/i2c/tda998x_drv.c      | 908 +++++++++++++++++++++++++++++++++
 drivers/gpu/drm/tilcdc/Kconfig         |  25 +
 drivers/gpu/drm/tilcdc/Makefile        |  10 +
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c   | 597 ++++++++++++++++++++++
 drivers/gpu/drm/tilcdc/tilcdc_drv.c    | 611 ++++++++++++++++++++++
 drivers/gpu/drm/tilcdc/tilcdc_drv.h    | 159 ++++++
 drivers/gpu/drm/tilcdc/tilcdc_panel.c  | 443 ++++++++++++++++
 drivers/gpu/drm/tilcdc/tilcdc_panel.h  |  26 +
 drivers/gpu/drm/tilcdc/tilcdc_regs.h   | 154 ++++++
 drivers/gpu/drm/tilcdc/tilcdc_slave.c  | 380 ++++++++++++++
 drivers/gpu/drm/tilcdc/tilcdc_slave.h  |  26 +
 drivers/gpu/drm/tilcdc/tilcdc_tfp410.c | 423 +++++++++++++++
 drivers/gpu/drm/tilcdc/tilcdc_tfp410.h |  26 +
 16 files changed, 3794 insertions(+)
 create mode 100644 drivers/gpu/drm/i2c/tda998x_drv.c
 create mode 100644 drivers/gpu/drm/tilcdc/Kconfig
 create mode 100644 drivers/gpu/drm/tilcdc/Makefile
 create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_crtc.c
 create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_drv.c
 create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_drv.h
 create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_panel.c
 create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_panel.h
 create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_regs.h
 create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_slave.c
 create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_slave.h
 create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_tfp410.c
 create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_tfp410.h

-- 
1.8.1

