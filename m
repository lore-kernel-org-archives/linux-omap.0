From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/4] ARM: dts: Configure duovero for to allow core retention
 during idle
Date: Thu, 17 May 2018 16:35:41 -0700
Message-ID: <20180517233542.30629-4-tony@atomide.com>
References: <20180517233542.30629-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180517233542.30629-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Marcel Partap <mpartap@gmx.net>, Dave Gerlach <d-gerlach@ti.com>, Pavel Machek <pavel@ucw.cz>, Keerthy <j-keerthy@ti.com>, Merlijn Wajer <merlijn@wizzup.org>, Sebastian Reichel <sre@kernel.org>, Tero Kristo <t-kristo@ti.com>, NeKit <nekit1000@gmail.com>, Eyal Reizer <eyalr@ti.com>, Ash Charles <ash@gumstix.com>, Michael Scott <hashcode0f@gmail.com>, Kalle Valo <kvalo@codeaurora.org>
List-Id: linux-omap@vger.kernel.org

By reconfiguring few GPIOs in the dts file we can make duovero parlor
hit retention during idle:

1. Let's a larger debounce value for gpio-keys

This will then make gpio-keys use software debounce and the GPIO
debounce clock is not enabled.

2. Let's allow WLAN suspend for mwifiex

This can be done just by adding keep-power-in-suspend.

3. Let's reconfigure smsc911x driver to use GPIO edge interrupt

This will allow using NFSroot while the system idles, and the kernel
has quite a few dts files with "smsc,lan9115" compatible using edge
interrupts.

Then to have the system hit core retention during idle, the UARTs
needs to be idled and USB modules need to be unloaded or unbound.

Cc: Ash Charles <ash@gumstix.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap4-duovero-parlor.dts | 3 ++-
 arch/arm/boot/dts/omap4-duovero.dtsi       | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap4-duovero-parlor.dts b/arch/arm/boot/dts/omap4-duovero-parlor.dts
--- a/arch/arm/boot/dts/omap4-duovero-parlor.dts
+++ b/arch/arm/boot/dts/omap4-duovero-parlor.dts
@@ -36,6 +36,7 @@
 			label = "button0";
 			linux,code = <BTN_0>;
 			gpios = <&gpio4 25 GPIO_ACTIVE_LOW>;	/* gpio_121 */
+			debounce-interval = <10>;
 			wakeup-source;
 		};
 	};
@@ -140,7 +141,7 @@
 	ethernet@gpmc {
 		reg = <5 0 0xff>;
 		interrupt-parent = <&gpio2>;
-		interrupts = <12 IRQ_TYPE_LEVEL_LOW>;		/* gpio_44 */
+		interrupts = <12 IRQ_TYPE_EDGE_FALLING>;	/* gpio_44 */
 
 		phy-mode = "mii";
 
diff --git a/arch/arm/boot/dts/omap4-duovero.dtsi b/arch/arm/boot/dts/omap4-duovero.dtsi
--- a/arch/arm/boot/dts/omap4-duovero.dtsi
+++ b/arch/arm/boot/dts/omap4-duovero.dtsi
@@ -248,6 +248,7 @@
 	ti,bus-width = <4>;
 	ti,non-removable;
 	cap-power-off-card;
+	keep-power-in-suspend;
 };
 
 &twl_usb_comparator {
-- 
2.17.0
