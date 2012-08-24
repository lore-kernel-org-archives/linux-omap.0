From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: omap: add dtb targets
Date: Fri, 24 Aug 2012 13:18:13 -0700
Message-ID: <20120824201813.GA11011@atomide.com>
References: <1345740689-21676-1-git-send-email-olof@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:47892 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932890Ab2HXUSP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Aug 2012 16:18:15 -0400
Content-Disposition: inline
In-Reply-To: <1345740689-21676-1-git-send-email-olof@lixom.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Olof Johansson <olof@lixom.net> [120823 09:52]:
> Makes it easier to just do 'make dtbs' for whatever the kernel was
> configured for, just like some other platforms.

Thanks applying into omap devel-dt branch.

Tony
 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
>  arch/arm/mach-omap2/Makefile.boot | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/Makefile.boot b/arch/arm/mach-omap2/Makefile.boot
> index b03e562..6cf1c2d 100644
> --- a/arch/arm/mach-omap2/Makefile.boot
> +++ b/arch/arm/mach-omap2/Makefile.boot
> @@ -1,3 +1,9 @@
>    zreladdr-y		+= 0x80008000
>  params_phys-y		:= 0x80000100
>  initrd_phys-y		:= 0x80800000
> +
> +dtb-$(CONFIG_SOC_OMAP2420)	+= omap2420-h4.dtb
> +dtb-$(CONFIG_ARCH_OMAP3)	+= omap3-beagle.dtb omap3-evm.dtb
> +dtb-$(CONFIG_ARCH_OMAP4)	+= omap4-panda.dtb omap4-pandaES.dtb
> +dtb-$(CONFIG_ARCH_OMAP4)	+= omap4-var_som.dtb omap4-sdp.dtb
> +dtb-$(CONFIG_SOC_OMAP5)		+= omap5-evm.dtb
> -- 
> 1.7.10.1.488.g05fbf7a
> 
