From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 2/2] arm/dts: Configure pinmuxs for user leds
 control on Bone
Date: Tue, 24 Jul 2012 01:30:08 -0700
Message-ID: <20120724083007.GU6522@atomide.com>
References: <1342769508-24810-1-git-send-email-anilkumar@ti.com>
 <1342769508-24810-3-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:26906 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755613Ab2GXIaL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jul 2012 04:30:11 -0400
Content-Disposition: inline
In-Reply-To: <1342769508-24810-3-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca

* AnilKumar Ch <anilkumar@ti.com> [120720 00:36]:
> Adds GPIO pinctrl nodes to am3358_pinmux master node to control
> user leds (USR0, USR1, USR2 and USR3) present on BeagleBone.
> 
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> ---
>  arch/arm/boot/dts/am335x-bone.dts |   15 +++++++++++++++
>  1 files changed, 15 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
> index a4d4415..452ce3f 100644
> --- a/arch/arm/boot/dts/am335x-bone.dts
> +++ b/arch/arm/boot/dts/am335x-bone.dts
> @@ -28,3 +28,18 @@
>  };
>  
>  /include/ "tps65217.dtsi"
> +
> +&am3358_pinmux {
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&userled_pins>;
> +
> +	userled_pins: pinmux_userled_pins {
> +		pinctrl-single,pins = <
> +			0x54 0x7	/* gpmc_a5.gpio1_21, OMAP_PIN_OUTPUT | OMAP_MUX_MODE7 */
> +			0x58 0x17	/* gpmc_a6.gpio1_22, OMAP_PIN_OUTPUT_PULLUP | OMAP_MUX_MODE7 */
> +			0x5C 0x7	/* gpmc_a7.gpio1_23, OMAP_PIN_OUTPUT | OMAP_MUX_MODE7 */
> +			0x60 0x17	/* gpmc_a8.gpio1_24, OMAP_PIN_OUTPUT_PULLUP | OMAP_MUX_MODE7 */
> +		>;
> +	};
> +};

Let's standardize on the following minimal commenting as those can be
search and replaced the same way when we have preprocessing available:

		pinctrl-single,pins = <
			0x54 0x7	/* gpmc_a5.gpio1_21  OUTPUT | MODE7 */
			0x58 0x17	/* gpmc_a6.gpio1_22, OUTPUT_PULLUP | MODE7 */
			0x5C 0x7	/* gpmc_a7.gpio1_23, OUTPUT | MODE7 */
			0x60 0x17	/* gpmc_a8.gpio1_24, OUTPUT_PULLUP | MODE7 */
		>;

Regards,

Tony
