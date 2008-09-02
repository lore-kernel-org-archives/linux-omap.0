From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH 2/3] Runtime check for OMAP35x
Date: Tue, 2 Sep 2008 11:59:35 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301A031B784@dbde02.ent.ti.com>
References: <1220299067-17307-1-git-send-email-premi@ti.com>
 <1220299067-17307-2-git-send-email-premi@ti.com>
 <20080901201058.GE28999@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60790 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752169AbYIBG3u convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Sep 2008 02:29:50 -0400
In-Reply-To: <20080901201058.GE28999@flint.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


-----Original Message-----
From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk] 
Sent: Tuesday, September 02, 2008 1:41 AM
To: Premi, Sanjeev
Cc: linux-omap@vger.kernel.org
Subject: Re: [PATCH 2/3] Runtime check for OMAP35x

On Tue, Sep 02, 2008 at 01:27:46AM +0530, Sanjeev Premi wrote:
> Based on earlier review comments, added runtime check of the OMAP35x 
> via omap2_set_globasl_3503() etc.
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
> @@ -334,3 +334,79 @@ void __init omap2_set_globals_343x(void)  }  
> #endif
>  
> +#if defined(CONFIG_ARCH_OMAP3503)
> +
> +static struct omap_globals omap3503_globals = {
> +	.class	= OMAP35XX_CLASS,
> +	.tap	= (__force void __iomem *)OMAP2_IO_ADDRESS(0x4830A000),

See my comments elsewhere about why this is Really Bad.  Any casts outside of a few header files using __force are basically a bug.

In this case, you're being forced to use them because OMAP2_IO_ADDRESS doesn't return the proper pointer values.  (I produced a patch for comment on this list last week over this issue.)

[sp] I was trying to be consistent/similar with current code in the file. Will make appropriate changes as you suggest.
