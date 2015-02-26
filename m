From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH RFC 0/6] Use DRM component API in tilcdc to connect to tda998x
Date: Thu, 26 Feb 2015 16:55:29 +0200
Message-ID: <cover.1424961754.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41747 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753825AbbBZO4K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Feb 2015 09:56:10 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, tony@atomide.com
Cc: tomi.valkeinen@ti.com, detheridge@ti.com, moinejf@free.fr, linux@arm.linux.org.uk, Jyri Sarha <jsarha@ti.com>

Remove tilcdc slave support and connect to tda998x trough its
component DRM API. For dtb backward compatibility the code creates at
boot time a DT overlay based on the earlier binding. The overlay
conforms to the new graph based binding.

The first patch is just a bugfix and can be applied or dropped
independenty.

Jyri Sarha (6):
  drm/tilcdc: Fix module unloading
  drm/tilcdc: Remove tilcdc slave support for tda998x driver
  drm/tilcdc: Add support for external compontised DRM encoder
  drm/tilcdc: Add DRM_TILCDC_INIT for "ti,tilcdc,slave" binding support
  drm/tilcdc: Force building of DRM_TILCDC_INIT
  ARM: dts: am335x-boneblack: Use new binding for HDMI

 .../devicetree/bindings/drm/tilcdc/slave.txt       |  18 -
 .../devicetree/bindings/drm/tilcdc/tilcdc.txt      |  27 ++
 arch/arm/boot/dts/am335x-boneblack.dts             |  20 +-
 drivers/gpu/drm/Makefile                           |   1 +
 drivers/gpu/drm/tilcdc/Kconfig                     |   6 +
 drivers/gpu/drm/tilcdc/Makefile                    |   4 +-
 drivers/gpu/drm/tilcdc/tilcdc_boot_init.c          | 270 ++++++++++++++
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c               |  36 +-
 drivers/gpu/drm/tilcdc/tilcdc_drv.c                |  69 ++--
 drivers/gpu/drm/tilcdc/tilcdc_drv.h                |   3 +-
 drivers/gpu/drm/tilcdc/tilcdc_external.c           | 105 ++++++
 drivers/gpu/drm/tilcdc/tilcdc_external.h           |  24 ++
 drivers/gpu/drm/tilcdc/tilcdc_slave.c              | 411 ---------------------
 drivers/gpu/drm/tilcdc/tilcdc_slave.h              |  26 --
 drivers/gpu/drm/tilcdc/tilcdc_slave_convert.dts    |  70 ++++
 15 files changed, 601 insertions(+), 489 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/drm/tilcdc/slave.txt
 create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_boot_init.c
 create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_external.c
 create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_external.h
 delete mode 100644 drivers/gpu/drm/tilcdc/tilcdc_slave.c
 delete mode 100644 drivers/gpu/drm/tilcdc/tilcdc_slave.h
 create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_slave_convert.dts

-- 
1.9.1

