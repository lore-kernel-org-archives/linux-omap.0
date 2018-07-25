From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 22/32] ARM: dts: omap3-gta04a3: fix model name for A3 variant
Date: Wed, 25 Jul 2018 08:58:54 +0200
Message-ID: <1952698afac4630752f8d6e3aa922a17ea42a4fa.1532501910.git.hns@goldelico.com>
References: <cover.1532501910.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1532501910.git.hns@goldelico.com>
In-Reply-To: <cover.1532501910.git.hns@goldelico.com>
References: <cover.1532501910.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Belisko <marek@goldelico.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

GTA04 is the project name and Letux 2804 the product name.
Report both.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04a3.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-gta04a3.dts b/arch/arm/boot/dts/omap3-gta04a3.dts
index 3099a892cf50..cc9244956679 100644
--- a/arch/arm/boot/dts/omap3-gta04a3.dts
+++ b/arch/arm/boot/dts/omap3-gta04a3.dts
@@ -9,7 +9,7 @@
 #include "omap3-gta04.dtsi"
 
 / {
-	model = "Goldelico GTA04A3";
+	model = "Goldelico GTA04A3/Letux 2804";
 };
 
 &i2c2 {
-- 
2.12.2
