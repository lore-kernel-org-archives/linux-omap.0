From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/2] ARM: dts: am57xx-beagle-x15: Switch UART mux pins
Date: Thu, 9 Apr 2015 17:56:01 -0500
Message-ID: <20150409225600.GA17542@kahuna>
References: <1428618797-17190-1-git-send-email-nm@ti.com>
 <1428618797-17190-2-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1428618797-17190-2-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 17:33-20150409, Nishanth Menon wrote:
> BeagleBoard-X15 pre-production change includes switching over to UART
> pins that now allow for UART download capability. All original boards
> should either have been returned for modifications or already modified
> for the required change and maintaining compatibility for older boards
> are no longer needed.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/boot/dts/am57xx-beagle-x15.dts |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
> index 15f198e4864d..cea3be3a051c 100644
> --- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
> +++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
> @@ -130,8 +130,8 @@
>  
>  	uart3_pins_default: uart3_pins_default {
>  		pinctrl-single,pins = <
> -			0x248 (PIN_INPUT_SLEW | MUX_MODE0) /* uart3_rxd.rxd */
> -			0x24c (PIN_INPUT_SLEW | MUX_MODE0) /* uart3_txd.txd */
> +			0x3f8 (PIN_INPUT_SLEW | MUX_MODE2) /* uart2_ctsn.uart3_rxd */
> +			0x3fc (PIN_INPUT_SLEW | MUX_MODE1) /* uart2_rtsn.uart3_txd */
>  		>;
>  	};
>  
> -- 
> 1.7.9.5
> 

Drat!.. I missed the daisychain merge that took place :( updated V2 patch
below. Do let me know if you'd like me to repost this.

---8<---
>From 055f2837f8eebd680e954088908c43dbe16b15d7 Mon Sep 17 00:00:00 2001
From: Nishanth Menon <nm@ti.com>
Date: Wed, 8 Apr 2015 17:40:59 -0500
Subject: [PATCH V2 1/2] ARM: dts: am57xx-beagle-x15: Switch UART mux pins

BeagleBoard-X15 pre-production change includes switching over to UART
pins that now allow for UART download capability. All original boards
should either have been returned for modifications or already modified
for the required change and maintaining compatibility for older boards
are no longer needed.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/am57xx-beagle-x15.dts |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index 15f198e4864d..01661e9013fe 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -130,8 +130,8 @@
 
 	uart3_pins_default: uart3_pins_default {
 		pinctrl-single,pins = <
-			0x248 (PIN_INPUT_SLEW | MUX_MODE0) /* uart3_rxd.rxd */
-			0x24c (PIN_INPUT_SLEW | MUX_MODE0) /* uart3_txd.txd */
+			0x3f8 (PIN_INPUT_SLEW | MUX_MODE2) /* uart2_ctsn.uart3_rxd */
+			0x3fc (PIN_INPUT_SLEW | MUX_MODE1) /* uart2_rtsn.uart3_txd */
 		>;
 	};
 
@@ -478,7 +478,7 @@
 &uart3 {
 	status = "okay";
 	interrupts-extended = <&crossbar_mpu GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
-			      <&dra7_pmx_core 0x248>;
+			      <&dra7_pmx_core 0x3f8>;
 
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart3_pins_default>;
-- 
1.7.9.5


-- 
Regards,
Nishanth Menon
