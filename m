From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: omap2: select ARM_AMBA if OMAP3_EMU is defined
Date: Fri, 18 Nov 2011 16:25:42 -0800
Message-ID: <20111119002542.GY31337@atomide.com>
References: <1320726974-11912-1-git-send-email-tom.leiming@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:33023 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750988Ab1KSAZp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Nov 2011 19:25:45 -0500
Content-Disposition: inline
In-Reply-To: <1320726974-11912-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tom.leiming@gmail.com
Cc: khilman@deeprootsystems.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* tom.leiming@gmail.com <tom.leiming@gmail.com> [111107 20:02]:
> From: Ming Lei <tom.leiming@gmail.com>
> 
> This patch selects ARM_AMBA if OMAP3_EMU is defined because
> OC_ETM depends on ARM_AMBA, so fix the link failure[1].

Thanks applying into fixes.

Tony

> 
> [1],
> arch/arm/kernel/built-in.o: In function `etm_remove':
> /home/tom/git/omap/linux-2.6-omap/arch/arm/kernel/etm.c:609: undefined
> reference to `amba_release_regions'
> arch/arm/kernel/built-in.o: In function `etb_remove':
> /home/tom/git/omap/linux-2.6-omap/arch/arm/kernel/etm.c:409: undefined
> reference to `amba_release_regions'
> arch/arm/kernel/built-in.o: In function `etm_init':
> /home/tom/git/omap/linux-2.6-omap/arch/arm/kernel/etm.c:640: undefined
> reference to `amba_driver_register'
> /home/tom/git/omap/linux-2.6-omap/arch/arm/kernel/etm.c:646: undefined
> reference to `amba_driver_register'
> /home/tom/git/omap/linux-2.6-omap/arch/arm/kernel/etm.c:648: undefined
> reference to `amba_driver_unregister'
> arch/arm/kernel/built-in.o: In function `etm_probe':
> /home/tom/git/omap/linux-2.6-omap/arch/arm/kernel/etm.c:545: undefined
> reference to `amba_request_regions'
> /home/tom/git/omap/linux-2.6-omap/arch/arm/kernel/etm.c:595: undefined
> reference to `amba_release_regions'
> arch/arm/kernel/built-in.o: In function `etb_probe':
> /home/tom/git/omap/linux-2.6-omap/arch/arm/kernel/etm.c:347: undefined
> reference to `amba_request_regions'
> /home/tom/git/omap/linux-2.6-omap/arch/arm/kernel/etm.c:392: undefined
> reference to `amba_release_regions'
> arch/arm/mach-omap2/built-in.o: In function `emu_init':
> /home/tom/git/omap/linux-2.6-omap/arch/arm/mach-omap2/emu.c:62:
> undefined reference to `amba_device_register'
> /home/tom/git/omap/linux-2.6-omap/arch/arm/mach-omap2/emu.c:63:
> undefined reference to `amba_device_register'
> make: *** [.tmp_vmlinux1] Error 1
> making modules
> 
> Signed-off-by: Ming Lei <tom.leiming@gmail.com>
> ---
>  arch/arm/mach-omap2/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 5034147..e1293aa 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -334,6 +334,7 @@ config MACH_OMAP4_PANDA
>  config OMAP3_EMU
>  	bool "OMAP3 debugging peripherals"
>  	depends on ARCH_OMAP3
> +	select ARM_AMBA
>  	select OC_ETM
>  	help
>  	  Say Y here to enable debugging hardware of omap3
> -- 
> 1.7.5.4
> 
