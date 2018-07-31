From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 23/32] ARM: dts: omap3-gta04a4: fix model name for A4 variant
Date: Tue, 31 Jul 2018 09:11:26 +0200
Message-ID: <26d4a75a6dcb46e187719802ec7436fa09b75fdf.1533021093.git.hns@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ladis@linux-mips.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Marek Belisko <marek@goldelico.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

GTA04 is the project name and Letux 2804 the product name.
Report both.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04a4.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-gta04a4.dts b/arch/arm/boot/dts/omap3-gta04a4.dts
index c918bb1f0529..77afc711fe4f 100644
--- a/arch/arm/boot/dts/omap3-gta04a4.dts
+++ b/arch/arm/boot/dts/omap3-gta04a4.dts
@@ -9,5 +9,5 @@
 #include "omap3-gta04.dtsi"
 
 / {
-	model = "Goldelico GTA04A4";
+	model = "Goldelico GTA04A4/Letux 2804";
 };
-- 
2.12.2
