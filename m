From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 1/2] omap: add bits for future 3430/3630 ES
 revisions
Date: Tue, 20 Oct 2009 17:14:38 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0910201649060.22645@utopia.booyaka.com>
References: <1256077586-11636-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60852 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752766AbZJTXOd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Oct 2009 19:14:33 -0400
In-Reply-To: <1256077586-11636-1-git-send-email-vikram.pandita@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vikram Pandita <vikram.pandita@ti.com>, r-woodruff2@ti.com, "Menon, Nishanth" <nm@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Vikram, Nishanth, Richard,

a few comments on this:

On Tue, 20 Oct 2009, Vikram Pandita wrote:

> Add bits for future expansion of omap_chip_id type field.
> This is needed to accomodate 3630ES1 chip id which is bit10

...

> diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
> index 7cb0556..922bf1c 100644
> --- a/arch/arm/plat-omap/include/plat/cpu.h
> +++ b/arch/arm/plat-omap/include/plat/cpu.h
> @@ -45,7 +45,7 @@ int omap_type(void);
>  
>  struct omap_chip_id {
>  	u8 oc;
> -	u8 type;
> +	u32 type;
>  };

Just wanted to understand the motivation for using the u32.  

Earlier in the life of these patches, two comments were mentioned: the 
desire to 'futureproof' and the desire to reserve space for other 
34xx-family parts.

Regarding 'futureproofing:' that's part of the reason that a separate 
struct was defined for this: to prevent code that uses it from depending 
on the size of the type.  (Originally it was a typedef, but Linus hates 
typedefs...)  So it shouldn't matter how big or small the type is here, as 
long as it can handle all of the bits allocated for it.

Also mentioned was the idea of reserving space for other 34xx-family 
chips.  I'd suggest simply renumbering the bits when and if those versions 
appear.  Code that uses the omap_chip_id system should always use the 
macros (e.g. CHIP_IS_OMAP3430) and not encode separate bit shift values, 
so renumbering should be completely safe and transparent for core code.  
Module code shouldn't be using the omap_chip code, it's for core usage 
only.

So, since only one bit is being added, why not continue the use of the u8?  
Then when the next bits need to be added, the type can be expanded at that 
point, and the bits renumbered if necessary.  This should be a completely 
transparent operation for code that uses it.  Vikram's original patch:

    http://patchwork.kernel.org/patch/54847/

should be fine.

Or am I missing something?


- Paul
