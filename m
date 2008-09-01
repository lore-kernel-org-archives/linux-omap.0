From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/3] Runtime check for OMAP35x
Date: Mon, 1 Sep 2008 21:10:58 +0100
Message-ID: <20080901201058.GE28999@flint.arm.linux.org.uk>
References: <1220299067-17307-1-git-send-email-premi@ti.com> <1220299067-17307-2-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:49478 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351AbYIAULJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Sep 2008 16:11:09 -0400
Content-Disposition: inline
In-Reply-To: <1220299067-17307-2-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

On Tue, Sep 02, 2008 at 01:27:46AM +0530, Sanjeev Premi wrote:
> Based on earlier review comments, added runtime
> check of the OMAP35x via omap2_set_globasl_3503() etc.
> ---
>  arch/arm/plat-omap/common.c        |   76 ++++++++++++++++++++++++++++++++++
>  include/asm-arm/arch-omap/common.h |    4 ++
>  include/asm-arm/arch-omap/cpu.h    |   79 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 159 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
> index 3a5f05e..f8b04cc 100644
> --- a/arch/arm/plat-omap/common.c
> +++ b/arch/arm/plat-omap/common.c
> @@ -334,3 +334,79 @@ void __init omap2_set_globals_343x(void)
>  }
>  #endif
>  
> +#if defined(CONFIG_ARCH_OMAP3503)
> +
> +static struct omap_globals omap3503_globals = {
> +	.class	= OMAP35XX_CLASS,
> +	.tap	= (__force void __iomem *)OMAP2_IO_ADDRESS(0x4830A000),

See my comments elsewhere about why this is Really Bad.  Any casts
outside of a few header files using __force are basically a bug.

In this case, you're being forced to use them because OMAP2_IO_ADDRESS
doesn't return the proper pointer values.  (I produced a patch for
comment on this list last week over this issue.)
