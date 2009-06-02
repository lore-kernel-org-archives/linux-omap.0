From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP3 Overo: add EXPORT_SYMBOLs for Overo ASoC audio
	to be built as a module.
Date: Tue, 2 Jun 2009 10:35:43 -0700
Message-ID: <20090602173543.GE27332@atomide.com>
References: <5a7b8b7b0906011802y4abc5ba6m8813d6884825e805@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:53879 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755174AbZFBRfo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Jun 2009 13:35:44 -0400
Content-Disposition: inline
In-Reply-To: <5a7b8b7b0906011802y4abc5ba6m8813d6884825e805@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hugo Vincent <hugo.vincent@gmail.com>
Cc: linux-omap@vger.kernel.org

* Hugo Vincent <hugo.vincent@gmail.com> [090601 18:03]:
> I'm pretty new to kernel development, so I don't know any potential
> problems with doing this, but without this, audio/ASoC support must be
> built into the kernel (modpost fails when trying to build as modules),
> whereas with this patch, it can be built and used as a module.
> 
> Comments?

To me it looks like we should rather fix sound/soc/omap/omap-mcbsp.c
to use the clock framework rather than access omap_ctrl_read/write
directly.

Tony
 
> diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
> index 5f3aad9..aa3d123 100644
> --- a/arch/arm/mach-omap2/control.c
> +++ b/arch/arm/mach-omap2/control.c
> @@ -46,6 +46,7 @@ u32 omap_ctrl_readl(u16 offset)
>  {
>  	return __raw_readl(OMAP_CTRL_REGADDR(offset));
>  }
> +EXPORT_SYMBOL(omap_ctrl_readl);
> 
>  void omap_ctrl_writeb(u8 val, u16 offset)
>  {
> @@ -61,4 +62,5 @@ void omap_ctrl_writel(u32 val, u16 offset)
>  {
>  	__raw_writel(val, OMAP_CTRL_REGADDR(offset));
>  }
> +EXPORT_SYMBOL(omap_ctrl_writel);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
