From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: Add build target for omap4-panda-a4
Date: Fri, 14 Dec 2012 14:51:01 -0800
Message-ID: <20121214225100.GP4989@atomide.com>
References: <1355522139-8241-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:12142 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756626Ab2LNWvG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Dec 2012 17:51:06 -0500
Content-Disposition: inline
In-Reply-To: <1355522139-8241-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, device-tree <devicetree-discuss@lists.ozlabs.org>

* Jon Hunter <jon-hunter@ti.com> [121214 13:58]:
> Commit 0d9250c (ARM: dts: omap4-panda: Add pinmux configuration for
> HDMI) added a new device-tree source file for Rev A4 of the OMAP4430
> Panda board but it did not add this version to the makefile. Hence,
> add this file to the makefile.

Thanks applying into omap-for-v3.8/fixes-for-merge-window.

Tony
 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
>  arch/arm/boot/dts/Makefile |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 2af359c..f8b4ff4 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -105,6 +105,7 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
>  	omap3-evm.dtb \
>  	omap3-tobi.dtb \
>  	omap4-panda.dtb \
> +	omap4-panda-a4.dtb \
>  	omap4-panda-es.dtb \
>  	omap4-var-som.dtb \
>  	omap4-sdp.dtb \
> -- 
> 1.7.10.4
> 
