From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP: HWMOD: Bug fixes in hwmod structure definitions
Date: Thu, 18 Feb 2010 13:49:46 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002181348120.24812@utopia.booyaka.com>
References: <1266483755-22878-1-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35206 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757699Ab0BRUtr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 15:49:47 -0500
In-Reply-To: <1266483755-22878-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org

Hello Thara,

some comments.

On Thu, 18 Feb 2010, Thara Gopinath wrote:

> This patch corrects the width of some variables in hwmod structures
> where the values to be stored in these variables exceed the current
> field width.
> 
> Signed-off-by: Thara Gopinath <thara@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/plat-omap/include/plat/omap_hwmod.h |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> index 921990e..06a7f20 100644
> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> @@ -258,7 +258,7 @@ struct omap_hwmod_sysconfig {
>  	u16 sysc_offs;
>  	u16 syss_offs;
>  	u8 idlemodes;
> -	u8 sysc_flags;
> +	u16 sysc_flags;

This part is fine.

>  	u8 clockact;
>  };
>  
> @@ -280,9 +280,9 @@ struct omap_hwmod_sysconfig {
>  struct omap_hwmod_omap2_prcm {
>  	s16 module_offs;
>  	u8 prcm_reg_id;
> -	u8 module_bit;
> +	u32 module_bit;
>  	u8 idlest_reg_id;
> -	u8 idlest_idle_bit;
> +	u32 idlest_idle_bit;
>  	u8 idlest_stdby_bit;
>  };

This part I don't understand.  These are bit shifts in a 32 bit register, 
e.g., (1 << idlest_idle_bit), so how could these ever exceed 31?


- Paul
