From: Rob Clark <robdclark@gmail.com>
Subject: [PATCH 0/4] TI LCDC DRM driver
Date: Tue, 29 Jan 2013 11:23:00 -0600
Message-ID: <1359480184-9168-1-git-send-email-robdclark@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f45.google.com ([209.85.219.45]:61367 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753481Ab3A2RXP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jan 2013 12:23:15 -0500
Received: by mail-oa0-f45.google.com with SMTP id o6so703579oag.32
        for <linux-omap@vger.kernel.org>; Tue, 29 Jan 2013 09:23:14 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org
Cc: patches@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rob Clark <robdclark@gmail.com>

One more iteration.. now with more cowbell!

The first patch adds the basic driver and TFP410 DVI output.

The second patch adds support for NXP TDA998x family of i2c connected
HDMI encoders.  It is split out into an i2c encoder-slave in case someone
else has hw with the same HDMI encoder.

The final patch adds support for LCD panels, with timings and panel info
coming from device-tree.

The patch set has dependencies on the following patches that I have sent
earlier (which have not changed since then so I am not resending):

 * drm/cma: add debugfs helpers -
     https://patchwork.kernel.org/patch/1876721/
 * drm: i2c encoder helper wrappers -
     https://patchwork.kernel.org/patch/1950971/
 * drm/i2c: give i2c it's own Kconfig -
     https://patchwork.kernel.org/patch/2037181/

In addition, the LCD panel patch also depends on Steffen Trumtrar's OF
display helper series. I've moved this patch to last so it can be merged
later if needed.  Although I really see no reason not to merge the OF
display helper series for 3.9.

These patches and their dependencies can also be found here:

  git://people.freedesktop.org/~robclark/linux tilcdc-next
  http://cgit.freedesktop.org/~robclark/linux/log/?h=tilcdc-next

Rob Clark (4):
  drm/tilcdc: add TI LCD Controller DRM driver (v4)
  drm/i2c: nxp-tda998x (v3)
  drm/tilcdc: add encoder slave (v2)
  drm/tilcdc: add support for LCD panels (v5)

 .../devicetree/bindings/drm/tilcdc/panel.txt       |  59 ++
 .../devicetree/bindings/drm/tilcdc/slave.txt       |  19 +
 .../devicetree/bindings/drm/tilcdc/tfp410.txt      |  21 +
 .../devicetree/bindings/drm/tilcdc/tilcdc.txt      |  21 +
 drivers/gpu/drm/Kconfig                            |   2 +
 drivers/gpu/drm/Makefile                           |   1 +
 drivers/gpu/drm/i2c/Kconfig                        |   6 +
 drivers/gpu/drm/i2c/Makefile                       |   3 +
 drivers/gpu/drm/i2c/tda998x_drv.c                  | 906 +++++++++++++++++++++
 drivers/gpu/drm/tilcdc/Kconfig                     |  13 +
 drivers/gpu/drm/tilcdc/Makefile                    |  10 +
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c               | 602 ++++++++++++++
 drivers/gpu/drm/tilcdc/tilcdc_drv.c                | 611 ++++++++++++++
 drivers/gpu/drm/tilcdc/tilcdc_drv.h                | 150 ++++
 drivers/gpu/drm/tilcdc/tilcdc_panel.c              | 436 ++++++++++
 drivers/gpu/drm/tilcdc/tilcdc_panel.h              |  26 +
 drivers/gpu/drm/tilcdc/tilcdc_regs.h               | 154 ++++
 drivers/gpu/drm/tilcdc/tilcdc_slave.c              | 376 +++++++++
 drivers/gpu/drm/tilcdc/tilcdc_slave.h              |  26 +
 drivers/gpu/drm/tilcdc/tilcdc_tfp410.c             | 419 ++++++++++
 drivers/gpu/drm/tilcdc/tilcdc_tfp410.h             |  26 +
 21 files changed, 3887 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/drm/tilcdc/panel.txt
 create mode 100644 Documentation/devicetree/bindings/drm/tilcdc/slave.txt
 create mode 100644 Documentation/devicetree/bindings/drm/tilcdc/tfp410.txt
 create mode 100644 Documentation/devicetree/bindings/drm/tilcdc/tilcdc.txt
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

