From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v3 3/4] DT: OpenPandora: add battery node to describe OpenPandora battery
Date: Thu, 31 Aug 2017 08:59:52 +0200
Message-ID: <9930208cc7cde7c595b95469804e09b674a57ef4.1504162792.git.hns@goldelico.com>
References: <cover.1504162792.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1504162792.git.hns@goldelico.com>
In-Reply-To: <cover.1504162792.git.hns@goldelico.com>
References: <cover.1504162792.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: afd@ti.com, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, gta04-owner@goldelico.com, marek@goldelico.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Add DT node to describe the standard OpenPandora battery PB-4000-001
so that its properties can be used by the fuel gauge driver.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-pandora-common.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-pandora-common.dtsi b/arch/arm/boot/dts/omap3-pandora-common.dtsi
index 582e1fe25602..154865289dba 100644
--- a/arch/arm/boot/dts/omap3-pandora-common.dtsi
+++ b/arch/arm/boot/dts/omap3-pandora-common.dtsi
@@ -273,6 +273,14 @@
 		enable-active-high;
 		gpio = <&twl_gpio 13 GPIO_ACTIVE_HIGH>;
 	};
+
+	/* standard OpenPandora battery (PB-4000-001) */
+	bat: battery {
+		compatible = "simple-battery", "openpandora-battery";
+		voltage-min-design-microvolt = <3200000>;
+		energy-full-design-microwatt-hours = <14800000>;
+		charge-full-design-microamp-hours = <4000000>;
+	};
 };
 
 &omap3_pmx_core {
-- 
2.12.2
