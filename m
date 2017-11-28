From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v3 0/4] Fixes for omapdrm on OpenPandora and GTA04
Date: Tue, 28 Nov 2017 16:48:53 +0100
Message-ID: <cover.1511884135.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Sean Paul <seanpaul@chromium.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com
List-Id: linux-omap@vger.kernel.org

Changes V3:
* stay compatible with old DTB files which still use "toppoly" (suggested by Tomi Valkeinen)
* replaced MODULE_ALIAS entries by MODULE_DEVICE_TABLE (suggested by Andrew F. Davis)
* removed DSI VDDS patch as it has already been accepted

2017-11-16 09:50:22: Changes V2:
* replaced patch to fix DSI VDDS for OMAP3 by equivalent patch from Laurent Pinchart
* keep previous compatibility option in panel driver to handle older device tree binaries

2017-11-08 22:09:36:
This patch set fixes vendor names of the panels
and fixes a problem on omapdrm with enabling
VDD_DSI for OMAP3 which is needed for displaying
the Red and Green channel on OMAP3530 (Pandora).

H. Nikolaus Schaller (4):
  omapdrm: panel: fix compatible vendor string for td028ttec1
  omapdrm: panel: td028ttec1: replace MODULE_ALIAS by
    MODULE_DEVICE_TABLE
  DTS: GTA04: fix panel compatibility string
  DTS: Pandora: fix panel compatibility string

 .../panel/{toppoly,td028ttec1.txt => tpo,td028ttec1.txt}    |  4 ++--
 arch/arm/boot/dts/omap3-gta04.dtsi                          |  2 +-
 arch/arm/boot/dts/omap3-pandora-common.dtsi                 |  2 +-
 drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c     | 13 ++++++++++++-
 .../fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c      | 12 +++++++++++-
 5 files changed, 27 insertions(+), 6 deletions(-)
 rename Documentation/devicetree/bindings/display/panel/{toppoly,td028ttec1.txt => tpo,td028ttec1.txt} (84%)

-- 
2.12.2
