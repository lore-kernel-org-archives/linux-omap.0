From: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v4 0/7] Use DRM component API in tilcdc to connect to tda998x
Date: Wed, 1 Apr 2015 11:49:24 +0300
Message-ID: <cover.1427877412.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: tomi.valkeinen-l0cyMroinI0@public.gmane.org, rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, moinejf-GANU6spQydw@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Ok, let's do one more full review round. The mode filtering issue was
the main reason for this new patch series version. However, I found
couple other things to fix too after scrutinizing the patches once
more.

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
 drivers/gpu/drm/tilcdc/Kconfig                     |  12 +
 drivers/gpu/drm/tilcdc/Makefile                    |   5 +-
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c               |  36 +-
 drivers/gpu/drm/tilcdc/tilcdc_drv.c                |  94 +++--
 drivers/gpu/drm/tilcdc/tilcdc_drv.h                |   6 +-
 drivers/gpu/drm/tilcdc/tilcdc_external.c           | 159 ++++++++
 drivers/gpu/drm/tilcdc/tilcdc_external.h           |  25 ++
 drivers/gpu/drm/tilcdc/tilcdc_slave.c              | 411 ---------------------
 drivers/gpu/drm/tilcdc/tilcdc_slave.h              |  26 --
 drivers/gpu/drm/tilcdc/tilcdc_slave_compat.c       | 270 ++++++++++++++
 drivers/gpu/drm/tilcdc/tilcdc_slave_compat.dts     |  72 ++++
 drivers/gpu/drm/tilcdc/tilcdc_slave_compat.h       |  25 ++
 16 files changed, 718 insertions(+), 490 deletions(-)
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
