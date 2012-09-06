From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v6 2/3] arm/dts: AM33XX: Configure pinmuxs for user
 leds control on Bone
Date: Thu, 6 Sep 2012 13:58:12 -0700
Message-ID: <20120906205811.GO1303@atomide.com>
References: <1346845260-10978-1-git-send-email-anilkumar@ti.com>
 <1346845260-10978-3-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:32307 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759932Ab2IFU6Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Sep 2012 16:58:24 -0400
Content-Disposition: inline
In-Reply-To: <1346845260-10978-3-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: wg@grandegger.com, mkl@pengutronix.de, bryan.wu@canonical.com, rpurdie@rpsys.net, linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca

* AnilKumar Ch <anilkumar@ti.com> [120905 04:42]:
> Adds GPIO pinctrl nodes to am3358_pinmux master node to control
> user leds (USR0, USR1, USR2 and USR3) present on BeagleBone.
> 
> [koen@dominion.thruhere.net: led0, led1 suggested by koen]
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> ---
>  arch/arm/boot/dts/am335x-bone.dts |   43 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
> index c634f87..822efe6 100644
> --- a/arch/arm/boot/dts/am335x-bone.dts
> +++ b/arch/arm/boot/dts/am335x-bone.dts
> @@ -18,11 +18,54 @@
>  		reg = <0x80000000 0x10000000>; /* 256 MB */
>  	};
>  
> +	am3358_pinmux: pinmux@44e10800 {
> +		userled_pins: pinmux_userled_pins {
> +			pinctrl-single,pins = <
> +				0x54 0x7	/* gpmc_a5.gpio1_21, OUTPUT | MODE7 */
> +				0x58 0x17	/* gpmc_a6.gpio1_22, OUTPUT_PULLUP | MODE7 */
> +				0x5c 0x7	/* gpmc_a7.gpio1_23, OUTPUT | MODE7 */
> +				0x60 0x17	/* gpmc_a8.gpio1_24, OUTPUT_PULLUP | MODE7 */
> +			>;
> +		};
> +	};
> +

Just checking.. am3358_pinmux should be am33xx_pinmux in this patch
too as discussed.

Regards,

Tony
