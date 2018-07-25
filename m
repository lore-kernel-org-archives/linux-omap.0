From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 23/32] ARM: dts: omap3-gta04a4: fix model name for A4 variant
Date: Wed, 25 Jul 2018 08:58:55 +0200
Message-ID: <ae6ee3fbc2ac0fe2040c435a995a7a61fea45061.1532501910.git.hns@goldelico.com>
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
