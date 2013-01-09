From: Rob Clark <robdclark@gmail.com>
Subject: [RFC 0/4] TI LCDC DRM driver
Date: Tue,  8 Jan 2013 22:11:21 -0600
Message-ID: <1357704685-3600-1-git-send-email-robdclark@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:61830 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756575Ab3AIELk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jan 2013 23:11:40 -0500
Received: by mail-pa0-f42.google.com with SMTP id rl6so763167pac.1
        for <linux-omap@vger.kernel.org>; Tue, 08 Jan 2013 20:11:40 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org
Cc: patches@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rob Clark <robdclark@gmail.com>

Updated version of DRM driver for TI LCD Controller.  Since the initial
version of the patch, which only supported TFP410 DVI output, I've added
an output driver for LCD panels (for example, LCD3 or LCD7 cape for the
beagle-bone), and initial support for HDMI output via NXP TDA19988 HDMI
encoder (via i2c encoder-slave output driver).

At this point, I think the basic lcdc drm driver plus TFP410 DVI output
(first patch) is in reasonable shape (barring potential rename, if lcdc
is too generic of a name... but I was not feeling creative enough yet to
pick a new name).

The second patch, adding LCD panel support, still needs backlight
support.  And the DT bindings for panel parameters should probably be
made more generic.  But I guess someone should have some opinions on
that so I figured it would be good to send as an RFC in it's current
form and hear other's opinions.

The remaining two patches, adding support for HDMI output via NXP
TDA998x i2c encoder are fairly preliminary, but basically working (for
some definitions of working).  At this point, there is only basic DVI
output support.  Audio, HDCP, etc, can come later.

Rob Clark (4):
  RFC: drm/lcdc: add TI LCD Controller DRM driver (v2)
  RFC: drm/lcdc: add support for LCD panels (v2)
  RFC: drm/i2c: nxp-tda998x
  RFC: drm/lcdc: add encoder slave

 drivers/gpu/drm/Kconfig            |   2 +
 drivers/gpu/drm/Makefile           |   1 +
 drivers/gpu/drm/i2c/Makefile       |   3 +
 drivers/gpu/drm/i2c/tda998x_drv.c  | 907 +++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/lcdc/Kconfig       |  24 +
 drivers/gpu/drm/lcdc/Makefile      |  10 +
 drivers/gpu/drm/lcdc/lcdc_crtc.c   | 598 ++++++++++++++++++++++++
 drivers/gpu/drm/lcdc/lcdc_drv.c    | 608 +++++++++++++++++++++++++
 drivers/gpu/drm/lcdc/lcdc_drv.h    | 164 +++++++
 drivers/gpu/drm/lcdc/lcdc_panel.c  | 458 +++++++++++++++++++
 drivers/gpu/drm/lcdc/lcdc_panel.h  |  26 ++
 drivers/gpu/drm/lcdc/lcdc_regs.h   | 154 +++++++
 drivers/gpu/drm/lcdc/lcdc_slave.c  | 384 ++++++++++++++++
 drivers/gpu/drm/lcdc/lcdc_slave.h  |  26 ++
 drivers/gpu/drm/lcdc/lcdc_tfp410.c | 425 +++++++++++++++++
 drivers/gpu/drm/lcdc/lcdc_tfp410.h |  26 ++
 16 files changed, 3816 insertions(+)
 create mode 100644 drivers/gpu/drm/i2c/tda998x_drv.c
 create mode 100644 drivers/gpu/drm/lcdc/Kconfig
 create mode 100644 drivers/gpu/drm/lcdc/Makefile
 create mode 100644 drivers/gpu/drm/lcdc/lcdc_crtc.c
 create mode 100644 drivers/gpu/drm/lcdc/lcdc_drv.c
 create mode 100644 drivers/gpu/drm/lcdc/lcdc_drv.h
 create mode 100644 drivers/gpu/drm/lcdc/lcdc_panel.c
 create mode 100644 drivers/gpu/drm/lcdc/lcdc_panel.h
 create mode 100644 drivers/gpu/drm/lcdc/lcdc_regs.h
 create mode 100644 drivers/gpu/drm/lcdc/lcdc_slave.c
 create mode 100644 drivers/gpu/drm/lcdc/lcdc_slave.h
 create mode 100644 drivers/gpu/drm/lcdc/lcdc_tfp410.c
 create mode 100644 drivers/gpu/drm/lcdc/lcdc_tfp410.h

-- 
1.8.0.2

