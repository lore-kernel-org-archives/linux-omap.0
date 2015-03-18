From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v3 0/7] Use DRM component API in tilcdc to connect to tda998x
Date: Wed, 18 Mar 2015 11:06:29 +0200
Message-ID: <cover.1426668480.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37704 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754722AbbCRJHT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Mar 2015 05:07:19 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, tony@atomide.com
Cc: tomi.valkeinen@ti.com, rmk+kernel@arm.linux.org.uk, robdclark@gmail.com, moinejf@free.fr, Jyri Sarha <jsarha@ti.com>

I think the patches 1-5 are ready for merging. See the details below.

I moved the "drm/tilcdc: Decrement refcount of ep-node from
of_graph_get_next_endpoint" to last in the set and I think it can be
dropped. The "of: Decrement refcount of previous endpoint in
of_graph_get_next_endpoint" is eventually going to be merged and
before that leaking of two of-node refcount increments each time the
module is loaded is not that serious. The of-nodes live forever anyway.

The merge of the dts patch can be delayed until the next merger
window. The DRM_TILCDC_SLAVE_COMPAT should keep the bbb HDMI
operational until then.

Changes since v2 version of the patch-set:
- use obj-y in Makefle for tilcdc subdir in:
  "drm/tilcdc: Force building of DRM_TILCDC_SLAVE_COMPAT"
- move to last:
  "drm/tilcdc: Decrement refcount of ep-node from of_graph_get_next_endpoint"

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
  drm/tilcdc: Add DRM_TILCDC_SLAVE_COMPAT for ti,tilcdc,slave binding
    support
  drm/tilcdc: Force building of DRM_TILCDC_SLAVE_COMPAT
  ARM: dts: am335x-boneblack: Use new binding for HDMI
  drm/tilcdc: Decrement refcount of ep-node from
    of_graph_get_next_endpoint

 .../devicetree/bindings/drm/tilcdc/slave.txt       |  18 -
 .../devicetree/bindings/drm/tilcdc/tilcdc.txt      |  27 ++
 arch/arm/boot/dts/am335x-boneblack.dts             |  20 +-
 drivers/gpu/drm/Makefile                           |   2 +-
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
 15 files changed, 633 insertions(+), 490 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/drm/tilcdc/slave.txt
 create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_external.c
 create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_external.h
 delete mode 100644 drivers/gpu/drm/tilcdc/tilcdc_slave.c
 delete mode 100644 drivers/gpu/drm/tilcdc/tilcdc_slave.h
 create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_slave_compat.c
 create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_slave_compat.dts

-- 
1.9.1

