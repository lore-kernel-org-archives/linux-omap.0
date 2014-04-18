From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: AM335X: EVM: fix pinmux documentation in devicetree
Date: Fri, 18 Apr 2014 15:31:41 -0700
Message-ID: <20140418223140.GI21823@atomide.com>
References: <1396370358-778-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:61746 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752007AbaDRWbr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Apr 2014 18:31:47 -0400
Content-Disposition: inline
In-Reply-To: <1396370358-778-1-git-send-email-wsa@the-dreams.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-arm-kernel@lists.infradead.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org

* Wolfram Sang <wsa@the-dreams.de> [140401 09:43]:
> Wrong documentation in pinmux description can be especially confusing.
> Keep it proper.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Applying into omap-for-v3.15/fixes thanks.

Tony

>  arch/arm/boot/dts/am335x-evm.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
> index 7e6c64ed966d..fb5dc92692cf 100644
> --- a/arch/arm/boot/dts/am335x-evm.dts
> +++ b/arch/arm/boot/dts/am335x-evm.dts
> @@ -295,8 +295,8 @@
>  
>  	am335x_evm_audio_pins: am335x_evm_audio_pins {
>  		pinctrl-single,pins = <
> -			0x10c (PIN_INPUT_PULLDOWN | MUX_MODE4) /* mii1_rx_dv.mcasp1_aclkx */
> -			0x110 (PIN_INPUT_PULLDOWN | MUX_MODE4) /* mii1_txd3.mcasp1_fsx */
> +			0x10c (PIN_INPUT_PULLDOWN | MUX_MODE4) /* mii1_crs.mcasp1_aclkx */
> +			0x110 (PIN_INPUT_PULLDOWN | MUX_MODE4) /* mii1_rxerr.mcasp1_fsx */
>  			0x108 (PIN_OUTPUT_PULLDOWN | MUX_MODE4) /* mii1_col.mcasp1_axr2 */
>  			0x144 (PIN_INPUT_PULLDOWN | MUX_MODE4) /* rmii1_ref_clk.mcasp1_axr3 */
>  		>;
> -- 
> 1.9.0
> 
