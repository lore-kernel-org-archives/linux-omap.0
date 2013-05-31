From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH v2 1/1] ARM: dts: OMAP4/AM35xx: Fix missing dtb in the
 dtbs target
Date: Fri, 31 May 2013 16:45:22 +0200
Message-ID: <51A8B782.2020203@ti.com>
References: <1370009151-32362-1-git-send-email-florian.vaussard@epfl.ch> <1370009151-32362-2-git-send-email-florian.vaussard@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42806 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486Ab3EaOpd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 May 2013 10:45:33 -0400
In-Reply-To: <1370009151-32362-2-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Vaussard <florian.vaussard@epfl.ch>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

On 05/31/2013 04:05 PM, Florian Vaussard wrote:
> When making the dtbs target on OMAP/AM35xx, some trees are not
> built.
> 
> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>

Thanks for the fix Florian.

I need to applied your AM series first to take that one otherwise the
am3517-evm will fail since it depends on omap3.dtsi.

BTW, I applied some more AM patches in my branch, and I cannot apply
"ARM: dts: AM33XX: Use pinctrl constants" anymore.

Just wait for some review from AM folks before updating the whole series.

Regards,
Benoit

> ---
>  arch/arm/boot/dts/Makefile |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index b9f7121..8eadd4e 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -149,10 +149,13 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
>  	omap4-panda-es.dtb \
>  	omap4-var-som.dtb \
>  	omap4-sdp.dtb \
> +	omap4-sdp-es23plus.dtb \
>  	omap5-evm.dtb \
>  	am335x-evm.dtb \
>  	am335x-evmsk.dtb \
> -	am335x-bone.dtb
> +	am335x-bone.dtb \
> +	am3517-evm.dtb \
> +	am3517_mt_ventoux.dtb
>  dtb-$(CONFIG_ARCH_ORION5X) += orion5x-lacie-ethernet-disk-mini-v2.dtb
>  dtb-$(CONFIG_ARCH_PRIMA2) += prima2-evb.dtb
>  dtb-$(CONFIG_ARCH_U8500) += snowball.dtb \
> 

