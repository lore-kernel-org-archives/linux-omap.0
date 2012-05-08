From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2PLUS: Enable HIGHMEM
Date: Tue, 8 May 2012 16:59:27 -0700
Message-ID: <20120508235926.GY5088@atomide.com>
References: <1335983327-14561-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:33431 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241Ab2EHX73 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 19:59:29 -0400
Content-Disposition: inline
In-Reply-To: <1335983327-14561-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>

* Jon Hunter <jon-hunter@ti.com> [120502 11:34]:
> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> HIGMEM support in kernel is quite mature now and we have boards
> like ZOOM, PANDA, SDP where 1 GB memories are installed. With
> HIGHMEM disabled not all of the 1GB of RAM (only ~700MB) can be
> accessed. Hence, enable HIGMEM to make use of the entire memory.
> 
> On the boards which doesn't have more than 768 MB memory, all
> the memory is directly mapped in "lowmem" and highmem isn't
> exercised. Hence, there should be no impact by enabling HIGHMEM
> for boards that do not need it.
> 
> Tested on OMAP4460 Panda-ES.
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> Tested-by: Jon Hunter <jon-hunter@ti.com>
> ---
>  arch/arm/mach-omap2/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 8141b76..964ee67 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -17,6 +17,7 @@ config ARCH_OMAP2PLUS_TYPICAL
>  	select MENELAUS if ARCH_OMAP2
>  	select TWL4030_CORE if ARCH_OMAP3 || ARCH_OMAP4
>  	select TWL4030_POWER if ARCH_OMAP3 || ARCH_OMAP4
> +	select HIGHMEM
>  	help
>  	  Compile a kernel suitable for booting most boards

Thanks applying into board branch.

Regards,

Tony
