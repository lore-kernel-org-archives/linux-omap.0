From: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 03/13] arm/dts: OMAP4: Add gpio nodes
Date: Mon, 26 Sep 2011 18:50:11 +0200
Message-ID: <1317055821-20652-4-git-send-email-b-cousson@ti.com>
References: <1317055821-20652-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1317055821-20652-1-git-send-email-b-cousson-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org
Cc: khilman-l0cyMroinI0@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Charulatha V <charu-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add the 6 GPIOs controller nodes.
Since the GPIO driver is still under cleanup, a couple of temp
hacks are needed. They will be removed as soon as the driver will
be cleaned.

Remove gpio static device initialisation if DT is populated.

Remove un-needed LF.

Signed-off-by: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Charulatha V <charu-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap4.dtsi |   69 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/gpio.c   |    8 ++++-
 2 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 7a7f31e..bb19bca 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -104,5 +104,74 @@
 			compatible = "ti,omap4-spinlock";
 			ti,hwmods = "spinlock";
 		};
+
+		gpio1: gpio@1 {
+			compatible = "ti,omap4-gpio";
+			ti,hwmods = "gpio1";
+			/* id should not be needed with a global GPIO parent */
+			id = <1>;
+			bank-width = <32>;
+			debounce;
+			/* XXX: big hack until the bank_count is removed */
+			bank-count = <6>;
+			ti,no-idle-on-suspend;
+			#gpio-cells = <2>;
+			gpio-controller;
+		};
+
+		gpio2: gpio@2 {
+			compatible = "ti,omap4-gpio";
+			ti,hwmods = "gpio2";
+			id = <2>;
+			bank-width = <32>;
+			debounce;
+			ti,no-idle-on-suspend;
+			#gpio-cells = <2>;
+			gpio-controller;
+		};
+
+		gpio3: gpio@3 {
+			compatible = "ti,omap4-gpio";
+			ti,hwmods = "gpio3";
+			id = <3>;
+			bank-width = <32>;
+			debounce;
+			ti,no-idle-on-suspend;
+			#gpio-cells = <2>;
+			gpio-controller;
+		};
+
+		gpio4: gpio@4 {
+			compatible = "ti,omap4-gpio";
+			ti,hwmods = "gpio4";
+			id = <4>;
+			bank-width = <32>;
+			debounce;
+			ti,no-idle-on-suspend;
+			#gpio-cells = <2>;
+			gpio-controller;
+		};
+
+		gpio5: gpio@5 {
+			compatible = "ti,omap4-gpio";
+			ti,hwmods = "gpio5";
+			id = <5>;
+			bank-width = <32>;
+			debounce;
+			ti,no-idle-on-suspend;
+			#gpio-cells = <2>;
+			gpio-controller;
+		};
+
+		gpio6: gpio@6 {
+			compatible = "ti,omap4-gpio";
+			ti,hwmods = "gpio6";
+			id = <6>;
+			bank-width = <32>;
+			debounce;
+			ti,no-idle-on-suspend;
+			#gpio-cells = <2>;
+			gpio-controller;
+		};
 	};
 };
diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index 8cbfbc2..8412746 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -20,6 +20,7 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
+#include <linux/of.h>
 
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
@@ -122,7 +123,10 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
  */
 static int __init omap2_gpio_init(void)
 {
-	return omap_hwmod_for_each_by_class("gpio", omap2_gpio_dev_init,
-						NULL);
+	/* If dtb is there, the devices will be created dynamically */
+	if (of_have_populated_dt())
+		return -ENODEV;
+
+	return omap_hwmod_for_each_by_class("gpio", omap2_gpio_dev_init, NULL);
 }
 postcore_initcall(omap2_gpio_init);
-- 
1.7.0.4
