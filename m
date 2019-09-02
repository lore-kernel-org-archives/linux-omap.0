From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [RFC 5/5] ARM: dts: omap3-beagle: make explicitly compatible to ti,omap34xx
Date: Mon,  2 Sep 2019 12:55:51 +0200
Message-ID: <150eb34a95b2e7ead8ac81a9ab275592ea31595b.1567421751.git.hns@goldelico.com>
References: <cover.1567421750.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1567421750.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Adam Ford <aford173@gmail.com>, =?UTF-8?q?Andr=C3=A9=20Roth?= <neolynx@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Matching the ti-cpufreq driver needs to specify explicitly if
a board uses an omap34xx or omap36xx chip.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-beagle.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index e3df3c166902..d47213c7a4d0 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -8,7 +8,7 @@
 
 / {
 	model = "TI OMAP3 BeagleBoard";
-	compatible = "ti,omap3-beagle", "ti,omap3";
+	compatible = "ti,omap3-beagle", "ti,omap34xx", "ti,omap3";
 
 	cpus {
 		cpu@0 {
-- 
2.19.1
