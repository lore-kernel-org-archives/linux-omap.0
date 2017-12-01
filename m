From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v4 0/2] Fixes for omapdrm on OpenPandora and GTA04
Date: Fri,  1 Dec 2017 08:41:21 +0100
Message-ID: <cover.1512114082.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Sean Paul <seanpaul@chromium.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com
List-Id: linux-omap@vger.kernel.org

Changes V4:
* removed already accepted panel driver patches
* reworded commit subject to clarify

2017-11-28 16:49:00: Changes V3:
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

H. Nikolaus Schaller (2):
  DTS: GTA04: improve panel compatibility string
  DTS: Pandora: fix panel compatibility string

 arch/arm/boot/dts/omap3-gta04.dtsi          | 2 +-
 arch/arm/boot/dts/omap3-pandora-common.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.12.2
