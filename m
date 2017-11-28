From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v3 3/4] DTS: GTA04: fix panel compatibility string
Date: Tue, 28 Nov 2017 16:48:56 +0100
Message-ID: <5f68789942fb8063ba5a98f5dd7989a05f94c0d6.1511884135.git.hns@goldelico.com>
References: <cover.1511884135.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1511884135.git.hns@goldelico.com>
In-Reply-To: <cover.1511884135.git.hns@goldelico.com>
References: <cover.1511884135.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Sean Paul <seanpaul@chromium.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com
List-Id: linux-omap@vger.kernel.org

Official vendor string is now "tpo" and not "toppoly".

Requires patch "omapdrm: panel: fix compatible vendor string for td028ttec1"

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 4504908c23fe..ec27ed67a22a 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -86,7 +86,7 @@
 
 		/* lcd panel */
 		lcd: td028ttec1@0 {
-			compatible = "toppoly,td028ttec1";
+			compatible = "tpo,td028ttec1";
 			reg = <0>;
 			spi-max-frequency = <100000>;
 			spi-cpol;
-- 
2.12.2
