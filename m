From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v5 0/6] Use DRM component API in tilcdc to connect to tda998x
Date: Fri, 8 May 2015 14:27:13 +0300
Message-ID: <cover.1431083641.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34300 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752799AbbEHL1k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 May 2015 07:27:40 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, tony@atomide.com
Cc: tomi.valkeinen@ti.com, rmk+kernel@arm.linux.org.uk, robdclark@gmail.com, moinejf@free.fr, Jyri Sarha <jsarha@ti.com>

For all that I know this should be good for taking.

Changes since v4
* Rebased on top linux-4.1-rc2
* Drop "drm/tilcdc: Decrement refcount of ep-node from of_graph_get_next_..."
* Make connector_funcs const in struct tilcdc_drm_private because
  struct drm_connector's helper_private has been qualified as const in
  linux-4.1
* Check if a subcomponent has already triggered the unloading.
  - Fixes an oops if the external encoder is unloaded first and tilcdc after
* Add comment to explain hijacking of external drm connectors helper hijacking

Changes since v3 version of the patch-set:
* drm/tilcdc: Add support for external tda998x encoder
 - Hijack external connectors helper functions
 - Remove select of nonexistent DRM_TILCDC_INIT in tilcdc Kconfig
 - Correct author mail address to tilcdc_exteral.h
* drm/tilcdc: Add DRM_TILCDC_SLAVE_COMPAT for ti,tilcdc,slave binding
 - Add a header file for tilcdc_slave_compat.dtb symbol declarations

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

The "drm/tilcdc: Decrement refcount of ep-node from
of_graph_get_next_endpoint" should probably not be merged. The "of:
Decrement refcount of previous endpoint in of_graph_get_next_endpoint"
is eventually going to be merged and before that leaking of two
of-node refcount increments each time the module is loaded is not that
serious. The of-nodes live forever anyway.

The merge of the dts patch can be delayed until the next merger
window, when the other patches are already in. The
DRM_TILCDC_SLAVE_COMPAT should keep the bbb HDMI operational until
then.

The first patch is just a bugfix and can be applied or dropped
independently.

Jyri Sarha (6):
  drm/tilcdc: Fix module unloading
  drm/tilcdc: Remove tilcdc slave support for tda998x driver
  drm/tilcdc: Add support for external tda998x encoder
  drm/tilcdc: Add DRM_TILCDC_SLAVE_COMPAT for ti,tilcdc,slave binding
    support
  drm/tilcdc: Force building of DRM_TILCDC_SLAVE_COMPAT
  ARM: dts: am335x-boneblack: Use new binding for HDMI

 .../devicetree/bindings/drm/tilcdc/slave.txt       |  18 -
 .../devicetree/bindings/drm/tilcdc/tilcdc.txt      |  27 ++
 arch/arm/boot/dts/am335x-boneblack.dts             |  20 +-
 drivers/gpu/drm/Makefile                           |   2 +-
 drivers/gpu/drm/tilcdc/Kconfig                     |  12 +
 drivers/gpu/drm/tilcdc/Makefile                    |   5 +-
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c               |  36 +-
 drivers/gpu/drm/tilcdc/tilcdc_drv.c                |  98 +++--
 drivers/gpu/drm/tilcdc/tilcdc_drv.h                |   6 +-
 drivers/gpu/drm/tilcdc/tilcdc_external.c           | 166 +++++++++
 drivers/gpu/drm/tilcdc/tilcdc_external.h           |  25 ++
 drivers/gpu/drm/tilcdc/tilcdc_slave.c              | 411 ---------------------
 drivers/gpu/drm/tilcdc/tilcdc_slave.h              |  26 --
 drivers/gpu/drm/tilcdc/tilcdc_slave_compat.c       | 270 ++++++++++++++
 drivers/gpu/drm/tilcdc/tilcdc_slave_compat.dts     |  72 ++++
 drivers/gpu/drm/tilcdc/tilcdc_slave_compat.h       |  25 ++
 16 files changed, 729 insertions(+), 490 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/drm/tilcdc/slave.txt
 create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_external.c
 create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_external.h
 delete mode 100644 drivers/gpu/drm/tilcdc/tilcdc_slave.c
 delete mode 100644 drivers/gpu/drm/tilcdc/tilcdc_slave.h
 create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_slave_compat.c
 create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_slave_compat.dts
 create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_slave_compat.h

-- 
1.9.1

