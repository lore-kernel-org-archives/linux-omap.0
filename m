From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [RFC 3/5] ARM: dts: omap3-evm-37xx: fix compatible from omap3630 to omap36xx
Date: Mon,  2 Sep 2019 12:55:49 +0200
Message-ID: <ed0a59b81da33ec0989cffb94b07091f95c4927e.1567421751.git.hns@goldelico.com>
References: <cover.1567421750.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1567421750.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Adam Ford <aford173@gmail.com>, =?UTF-8?q?Andr=C3=A9=20Roth?= <neolynx@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

All other boards use compatible = "omap36xx".

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-evm-37xx.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-evm-37xx.dts b/arch/arm/boot/dts/omap3-evm-37xx.dts
index e0c0382388f0..311550ee4eae 100644
--- a/arch/arm/boot/dts/omap3-evm-37xx.dts
+++ b/arch/arm/boot/dts/omap3-evm-37xx.dts
@@ -10,7 +10,7 @@
 
 / {
 	model = "TI OMAP37XX EVM (TMDSEVM3730)";
-	compatible = "ti,omap3-evm-37xx", "ti,omap3630", "ti,omap3";
+	compatible = "ti,omap3-evm-37xx", "ti,omap36xx", "ti,omap3";
 };
 
 &omap3_pmx_core2 {
-- 
2.19.1
