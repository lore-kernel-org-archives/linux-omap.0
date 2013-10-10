From: Suman Anna <s-anna@ti.com>
Subject: [PATCHv3 8/8] ARM: dts: AM33XX: Add hwspinlock node
Date: Thu, 10 Oct 2013 16:15:35 -0500
Message-ID: <1381439735-52888-9-git-send-email-s-anna@ti.com>
References: <1381439735-52888-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1381439735-52888-1-git-send-email-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>, Kumar Gala <galak@codeaurora.org>, Paul Walmsley <paul@pwsan.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Suman Anna <s-anna@ti.com>
List-Id: linux-omap@vger.kernel.org

Add the hwspinlock device tree node for AM33xx family
of SoCs.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 8692490..49dfb86 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -285,6 +285,12 @@
 			status = "disabled";
 		};
 
+		hwspinlock: spinlock@480ca000 {
+			compatible = "ti,omap4-hwspinlock";
+			reg = <0x480ca000 0x1000>;
+			ti,hwmods = "spinlock";
+		};
+
 		wdt2: wdt@44e35000 {
 			compatible = "ti,omap3-wdt";
 			ti,hwmods = "wd_timer2";
-- 
1.8.4
