From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v3 4/4] DT: OpenPandora: fix for configuration of bq27500 fuel gauge
Date: Thu, 31 Aug 2017 10:21:52 +0200
Message-ID: <4ad788c51070bf48099c9352cfc51b556f29e1bc.1504167711.git.hns@goldelico.com>
References: <cover.1504167711.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1504167711.git.hns@goldelico.com>
In-Reply-To: <cover.1504167711.git.hns@goldelico.com>
References: <cover.1504167711.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: afd@ti.com, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, gta04-owner@goldelico.com, marek@goldelico.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Using the latest driver features requires to use "ti,bq27500-1"
instead of "ti,bq27500" as the compatible property.

Also add a reference to the monitored-battery.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-pandora-common.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-pandora-common.dtsi b/arch/arm/boot/dts/omap3-pandora-common.dtsi
index 154865289dba..bdf082246f9b 100644
--- a/arch/arm/boot/dts/omap3-pandora-common.dtsi
+++ b/arch/arm/boot/dts/omap3-pandora-common.dtsi
@@ -545,8 +545,9 @@
 	clock-frequency = <100000>;
 
 	bq27500@55 {
-		compatible = "ti,bq27500";
+		compatible = "ti,bq27500-1";
 		reg = <0x55>;
+		monitored-battery = <&bat>;
 	};
 
 };
-- 
2.12.2
