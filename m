From: Benoit Cousson <b-cousson@ti.com>
Subject: [RFC PATCH 09/10] arm/dts: OMAP4: Add gpio nodes
Date: Wed, 24 Aug 2011 15:09:15 +0200
Message-ID: <1314191356-10963-10-git-send-email-b-cousson@ti.com>
References: <1314191356-10963-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53861 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751266Ab1HXNLY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Aug 2011 09:11:24 -0400
In-Reply-To: <1314191356-10963-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grant.likely@secretlab.ca, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, devicetree-discuss@lists.ozlabs.org, manjugk@ti.com, Benoit Cousson <b-cousson@ti.com>, Charulatha V <charu@ti.com>

Add the 6 GPIOs controller nodes.
Since the GPIO driver is still under cleanup, a couple of temp
hacks are needed. They will be removed as soon as the driver will
be cleaned.

Remove gpio static device initialisation if CONFIG_OF is defined.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Charulatha V <charu@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi |   69 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/gpio.c   |    2 +
 2 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 231d7b4..f672927 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -110,5 +110,74 @@
 			compatible = "ti,omap-spinlock";
 			hwmods = "spinlock";
 		};
+
+		gpio1: gpio@1 {
+			compatible = "ti,omap4-gpio", "ti,omap-gpio";
+			hwmods = "gpio1";
+			/* id should not be needed with a global GPIO parent */
+			id = <1>;
+			bank_width = <32>;
+			debounce;
+			/* XXX: big hack until the bank_count is removed */
+			bank_count = <6>;
+			no_idle_on_suspend;
+			#gpio-cells = <2>;
+			gpio-controller;
+		};
+
+		gpio2: gpio@2 {
+			compatible = "ti,omap4-gpio", "ti,omap-gpio";
+			hwmods = "gpio2";
+			id = <2>;
+			bank_width = <32>;
+			debounce;
+			no_idle_on_suspend;
+			#gpio-cells = <2>;
+			gpio-controller;
+		};
+
+		gpio3: gpio@3 {
+			compatible = "ti,omap4-gpio", "ti,omap-gpio";
+			hwmods = "gpio3";
+			id = <3>;
+			bank_width = <32>;
+			debounce;
+			no_idle_on_suspend;
+			#gpio-cells = <2>;
+			gpio-controller;
+		};
+
+		gpio4: gpio@4 {
+			compatible = "ti,omap4-gpio", "ti,omap-gpio";
+			hwmods = "gpio4";
+			id = <4>;
+			bank_width = <32>;
+			debounce;
+			no_idle_on_suspend;
+			#gpio-cells = <2>;
+			gpio-controller;
+		};
+
+		gpio5: gpio@5 {
+			compatible = "ti,omap4-gpio", "ti,omap-gpio";
+			hwmods = "gpio5";
+			id = <5>;
+			bank_width = <32>;
+			debounce;
+			no_idle_on_suspend;
+			#gpio-cells = <2>;
+			gpio-controller;
+		};
+
+		gpio6: gpio@6 {
+			compatible = "ti,omap4-gpio", "ti,omap-gpio";
+			hwmods = "gpio6";
+			id = <6>;
+			bank_width = <32>;
+			debounce;
+			no_idle_on_suspend;
+			#gpio-cells = <2>;
+			gpio-controller;
+		};
 	};
 };
diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index 8cbfbc2..c51e952 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -16,6 +16,7 @@
  * GNU General Public License for more details.
  */
 
+#ifndef CONFIG_OF
 #include <linux/gpio.h>
 #include <linux/err.h>
 #include <linux/slab.h>
@@ -126,3 +127,4 @@ static int __init omap2_gpio_init(void)
 						NULL);
 }
 postcore_initcall(omap2_gpio_init);
+#endif
-- 
1.7.0.4

