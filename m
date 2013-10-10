From: Suman Anna <s-anna@ti.com>
Subject: [PATCHv3 7/8] ARM: dts: OMAP5: Add hwspinlock node
Date: Thu, 10 Oct 2013 16:15:34 -0500
Message-ID: <1381439735-52888-8-git-send-email-s-anna@ti.com>
References: <1381439735-52888-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1381439735-52888-1-git-send-email-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>, Kumar Gala <galak@codeaurora.org>, Paul Walmsley <paul@pwsan.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Suman Anna <s-anna@ti.com>
List-Id: linux-omap@vger.kernel.org

Add the hwspinlock device tree node for OMAP5 SoCs.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 86295d2..2a98a59 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -275,6 +275,12 @@
 			ti,hwmods = "i2c5";
 		};
 
+		hwspinlock: spinlock@4a0f6000 {
+			compatible = "ti,omap4-hwspinlock";
+			reg = <0x4a0f6000 0x1000>;
+			ti,hwmods = "spinlock";
+		};
+
 		mcspi1: spi@48098000 {
 			compatible = "ti,omap4-mcspi";
 			reg = <0x48098000 0x200>;
-- 
1.8.4
