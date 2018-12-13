From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] ARM: dts: omap4-droid4: Configure wlcore wakeirq
Date: Thu, 13 Dec 2018 15:26:11 -0800
Message-ID: <20181213232611.GT6707@atomide.com>
References: <20181213230411.5009-1-tony@atomide.com>
 <20181213230411.5009-3-tony@atomide.com>
 <20181213232228.beiwpqeixfvadjjf@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20181213232228.beiwpqeixfvadjjf@earth.universe>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre@kernel.org> [181213 23:22]:
> Hi,
> 
> On Thu, Dec 13, 2018 at 03:04:11PM -0800, Tony Lindgren wrote:
> > With wlcore supporting optional wakeirqs, we can configure it
> > for pandaboard.
> 
> -ENOPANDA

Oops, thanks for catching the typo. Updated patch below.

Regards,

Tony

8< ----------------------
>From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Thu, 13 Dec 2018 15:03:21 -0800
Subject: [PATCH] ARM: dts: omap4-droid4: Configure wlcore wakeirq

With wlcore supporting optional wakeirqs, we can configure it
for droid 4. This makes ssh connection usable with the SoC
entering deeper idle states.

Let's configure a wakeirq both for the wlcore GPIO and the SDIO
dat1 pin in case wlcore starts supporting SDIO dat1 interrupt at
some point.

And let's also add the missing keep-power-in-suspend while at it.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap4-droid4-xt894.dts | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -359,20 +359,24 @@
 
 &mmc3 {
 	vmmc-supply = <&wl12xx_vmmc>;
+	/* uart2_tx.sdmmc3_dat1 pad as wakeirq */
 	interrupts-extended = <&wakeupgen GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH
 			       &omap4_pmx_core 0xde>;
-
+	interrupt-names = "irq", "wakeup";
 	non-removable;
 	bus-width = <4>;
 	cap-power-off-card;
+	keep-power-in-suspend;
 
 	#address-cells = <1>;
 	#size-cells = <0>;
 	wlcore: wlcore@2 {
 		compatible = "ti,wl1285", "ti,wl1283";
 		reg = <2>;
-		interrupt-parent = <&gpio4>;
-		interrupts = <4 IRQ_TYPE_EDGE_RISING>; /* gpio100 */
+		/* gpio_100 with gpmc_wait2 pad as wakeirq */
+		interrupts-extended = <&gpio4 4 IRQ_TYPE_EDGE_RISING>,
+				      <&omap4_pmx_core 0x4e>;
+		interrupt-names = "irq", "wakeup";
 		ref-clock-frequency = <26000000>;
 		tcxo-clock-frequency = <26000000>;
 	};
-- 
2.19.2
