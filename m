From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/5] arm: boot: dts: am437x-sk: add power button binding
Date: Wed, 7 Jan 2015 16:09:27 -0800
Message-ID: <20150108000926.GN13010@atomide.com>
References: <1419622104-25812-1-git-send-email-balbi@ti.com>
 <1419622104-25812-5-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:38709 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084AbbAHANO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jan 2015 19:13:14 -0500
Content-Disposition: inline
In-Reply-To: <1419622104-25812-5-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

* Felipe Balbi <balbi@ti.com> [141226 11:31]:
> Let this board report KEY_POWER so upper layers
> can decide what to do when power button is pressed.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>

Applying this one into omap-for-v3.20/dt thanks.

Tony

> ---
>  arch/arm/boot/dts/am437x-sk-evm.dts | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
> index 53bbfc9..c53840c 100644
> --- a/arch/arm/boot/dts/am437x-sk-evm.dts
> +++ b/arch/arm/boot/dts/am437x-sk-evm.dts
> @@ -386,6 +386,11 @@
>  			regulator-always-on;
>  		};
>  
> +		power-button {
> +			compatible = "ti,tps65218-pwrbutton";
> +			status = "okay";
> +			interrupts = <3 IRQ_TYPE_EDGE_BOTH>;
> +		};
>  	};
>  
>  	at24@50 {
> -- 
> 2.2.0
> 
