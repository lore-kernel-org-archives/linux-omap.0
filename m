From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/5] ARM: dts: Add twl keypad map for LDP
Date: Wed, 5 Nov 2014 10:44:03 -0800
Message-ID: <20141105184403.GW31454@atomide.com>
References: <1415212550-24692-1-git-send-email-tony@atomide.com>
 <1415212550-24692-5-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:32798 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750891AbaKESpD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Nov 2014 13:45:03 -0500
Content-Disposition: inline
In-Reply-To: <1415212550-24692-5-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

* Tony Lindgren <tony@atomide.com> [141105 10:39]:
> Looks like we're still missing the keypad map for LDP.
> Let's add it since we have the binding now available
> for the twl4030_keypad as otherwise we get the following
> errors during the boot:
> 
> twl4030_keypad keypad.31: OF: linux,keymap property not defined
> in /ocp/i2c@48070000/twl@48/keypad
> twl4030_keypad keypad.31: Failed to build keymap
> twl4030_keypad: probe of keypad.31 failed with error -2

Uhh, this should say EVM instead of LDP.. Copy paste description
from the LDP patch.

Regards,

Tony
 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/boot/dts/omap3-evm-common.dtsi | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap3-evm-common.dtsi b/arch/arm/boot/dts/omap3-evm-common.dtsi
> index c8747c7..127f3e7 100644
> --- a/arch/arm/boot/dts/omap3-evm-common.dtsi
> +++ b/arch/arm/boot/dts/omap3-evm-common.dtsi
> @@ -2,6 +2,7 @@
>   * Common support for omap3 EVM boards
>   */
>  
> +#include <dt-bindings/input/input.h>
>  #include "omap-gpmc-smsc911x.dtsi"
>  
>  / {
> @@ -111,6 +112,26 @@
>  	ti,use-leds;
>  };
>  
> +&twl_keypad {
> +	linux,keymap = <
> +			MATRIX_KEY(2, 2, KEY_1)
> +			MATRIX_KEY(1, 1, KEY_2)
> +			MATRIX_KEY(0, 0, KEY_3)
> +			MATRIX_KEY(3, 2, KEY_4)
> +			MATRIX_KEY(2, 1, KEY_5)
> +			MATRIX_KEY(1, 0, KEY_6)
> +			MATRIX_KEY(1, 3, KEY_7)
> +			MATRIX_KEY(3, 1, KEY_8)
> +			MATRIX_KEY(2, 0, KEY_9)
> +			MATRIX_KEY(2, 3, KEY_KPASTERISK)
> +			MATRIX_KEY(0, 2, KEY_0)
> +			MATRIX_KEY(3, 0, KEY_KPDOT)
> +			/* s4 not wired */
> +			MATRIX_KEY(1, 2, KEY_BACKSPACE)
> +			MATRIX_KEY(0, 1, KEY_ENTER)
> +			>;
> +};
> +
>  &usb_otg_hs {
>  	interface-type = <0>;
>  	usb-phy = <&usb2_phy>;
> -- 
> 2.1.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
