From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v2 0/7] Use DRM component API in tilcdc to connect to tda998x
Date: Fri, 6 Mar 2015 17:36:28 +0200
Message-ID: <cover.1425656120.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37532 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754729AbbCFPg7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 Mar 2015 10:36:59 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, tony@atomide.com
Cc: tomi.valkeinen@ti.com, rmk+kernel@arm.linux.org.uk, robdclark@gmail.com, moinejf@free.fr, Jyri Sarha <jsarha@ti.com>

Changes since first version of the patch-set:
- Rename DRM_TILCDC_INIT to DRM_TILCDC_SLAVE_COMPAT and make it visible
- Add separate: 
  drm/tilcdc: Decrement refcount of ep-node from of_graph_get_next_endpoint
- Reduce info-level spam
- Use component_master_add_with_match()
- Be more explicit about tda998x being the only supported external encoder

Remove tilcdc slave support and connect to tda998x trough its
component DRM API. For dtb backward compatibility the code creates at
boot time a DT overlay based on the earlier binding. The overlay
conforms to the new graph based binding.

The first patch is just a bugfix and can be applied or dropped
independently.

Jyri Sarha (7):
  drm/tilcdc: Fix module unloading
  drm/tilcdc: Remove tilcdc slave support for tda998x driver
  drm/tilcdc: Add support for external tda998x encoder
  drm/tilcdc: Decrement refcount of ep-node from
    of_graph_get_next_endpoint
  drm/tilcdc: Add DRM_TILCDC_SLAVE_COMPAT for ti,tilcdc,slave binding
    support
  drm/tilcdc: Force building of DRM_TILCDC_SLAVE_COMPAT
  ARM: dts: am335x-boneblack: Use new binding for HDMI

 .../devicetree/bindings/drm/tilcdc/slave.txt       |  18 -
 .../devicetree/bindings/drm/tilcdc/tilcdc.txt      |  27 ++
 arch/arm/boot/dts/am335x-boneblack.dts             |  20 +-
 drivers/gpu/drm/Makefile                           |   1 +
 drivers/gpu/drm/tilcdc/Kconfig                     |  13 +
 drivers/gpu/drm/tilcdc/Makefile                    |   5 +-
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c               |  36 +-
 drivers/gpu/drm/tilcdc/tilcdc_drv.c                |  89 +++--
 drivers/gpu/drm/tilcdc/tilcdc_drv.h                |   5 +-
 drivers/gpu/drm/tilcdc/tilcdc_external.c           | 105 ++++++
 drivers/gpu/drm/tilcdc/tilcdc_external.h           |  24 ++
 drivers/gpu/drm/tilcdc/tilcdc_slave.c              | 411 ---------------------
 drivers/gpu/drm/tilcdc/tilcdc_slave.h              |  26 --
 drivers/gpu/drm/tilcdc/tilcdc_slave_compat.c       | 270 ++++++++++++++
 drivers/gpu/drm/tilcdc/tilcdc_slave_compat.dts     |  72 ++++
 15 files changed, 633 insertions(+), 489 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/drm/tilcdc/slave.txt
 create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_external.c
 create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_external.h
 delete mode 100644 drivers/gpu/drm/tilcdc/tilcdc_slave.c
 delete mode 100644 drivers/gpu/drm/tilcdc/tilcdc_slave.h
 create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_slave_compat.c
 create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_slave_compat.dts

-- 
1.9.1

