From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/2] ARM: dts: AM33XX: Set pinmux for clkout2 pad used
 for clock output
Date: Mon, 20 May 2013 02:51:02 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1305200250250.2656@utopia.booyaka.com>
References: <1367919574-21353-1-git-send-email-hvaibhav@ti.com> <1367919574-21353-3-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:44350 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754374Ab3ETCvD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 19 May 2013 22:51:03 -0400
In-Reply-To: <1367919574-21353-3-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org

Hi

something that you should fix:

On Tue, 7 May 2013, Vaibhav Hiremath wrote:

> xdma_event_intr1.clkout2 pad can be used to source clock
> from either 32K OSC or any of the PLL (except MPU) outputs.
> On the existing AM335x based boards (EVM, EVM-SK and Bone),
> this pad is used to feed the clock to audio codes.
> 
> So, this patch configures the pinmux to get clkout2 on the pad.
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> ---
>  arch/arm/boot/dts/am335x-bone.dts  |    8 +++++++-
>  arch/arm/boot/dts/am335x-evm.dts   |    8 +++++++-
>  arch/arm/boot/dts/am335x-evmsk.dts |    8 +++++++-
>  3 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
> index bfba6fc..f4630a3 100644
> --- a/arch/arm/boot/dts/am335x-bone.dts
> +++ b/arch/arm/boot/dts/am335x-bone.dts
> @@ -26,7 +26,7 @@
>  
>  	am33xx_pinmux: pinmux@44e10800 {
>  		pinctrl-names = "default";
> -		pinctrl-0 = <>;
> +		pinctrl-0 = <&clkout2_pin>;
>  
>  		user_leds_s0: user_leds_s0 {
>  			pinctrl-single,pins = <
> @@ -50,6 +50,12 @@
>  				0x174 0x00	/* uart0_txd.uart0_txd PULLDOWN | MODE0 */
>  			>;
>  		};
> +
> +		clkout2_pin: pinumx_clkout2_pin {

"pinmux" is misspelled here and in several other parts of this file.




- Paul
