From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 08/11] OMAP4: Adding dev atrributes to OMAP4
 smartreflex hwmod data
Date: Thu, 14 Oct 2010 11:56:34 -0700
Message-ID: <1287082594.14514.120.camel@localhost>
References: <1285419086-13047-1-git-send-email-thara@ti.com>
	 <1285419086-13047-9-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:35512 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932125Ab0JNV5n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Oct 2010 17:57:43 -0400
Received: by iwn35 with SMTP id 35so80667iwn.19
        for <linux-omap@vger.kernel.org>; Thu, 14 Oct 2010 14:57:42 -0700 (PDT)
In-Reply-To: <1285419086-13047-9-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

On Sat, 2010-09-25 at 18:21 +0530, Thara Gopinath wrote:
> diff --git a/arch/arm/plat-omap/include/plat/control.h
> b/arch/arm/plat-omap/include/plat/control.h
> index 042eb6e..1e8f6ec 100644
> --- a/arch/arm/plat-omap/include/plat/control.h
> +++ b/arch/arm/plat-omap/include/plat/control.h
> @@ -181,6 +181,18 @@
>  #define OMAP3630_CONTROL_FUSE_OPP50_VDD2
> (OMAP2_CONTROL_GENERAL + 0x0128)
>  #define OMAP3630_CONTROL_FUSE_OPP100_VDD2
> (OMAP2_CONTROL_GENERAL + 0x012C)
>  
> +/* 44xx control efuse offsets */
> +#define OMAP44XX_CONTROL_FUSE_IVA_OPP50                0x22C
> +#define OMAP44XX_CONTROL_FUSE_IVA_OPP100       0x22F
> +#define OMAP44XX_CONTROL_FUSE_IVA_OPPTURBO     0x232
> +#define OMAP44XX_CONTROL_FUSE_IVA_OPPNITRO     0x235
> +#define OMAP44XX_CONTROL_FUSE_MPU_OPP50                0x240
> +#define OMAP44XX_CONTROL_FUSE_MPU_OPP100       0x243
> +#define OMAP44XX_CONTROL_FUSE_MPU_OPPTURBO     0x246
> +#define OMAP44XX_CONTROL_FUSE_MPU_OPPNITRO     0x249
> +#define OMAP44XX_CONTROL_FUSE_CORE_OPP50       0x254
> +#define OMAP44XX_CONTROL_FUSE_CORE_OPP100      0x257
> +

These names are not consistent with the TRM (ES2.x NDA TRM vL).  e.g.
rather than MPU_OPP50, OPP1, the TRM has MPU_0, MPU_1.  However, the 
TRM is confusing here too since the register names are MPU_0,
MPU_1, etc. but the field names in the register descriptions use   
OPP50, OPP100, etc.  What a mess.  We need a consistent naming for these.

Benoit?

Also, based on the TRM, the offsets here don't look quite right.  
e.g. there is no MPU OPP at 0x240, so the OMAP4 the code reading these is 
using reserved/undocumented bits for the first OPP.

Also, the single byte offsets here could use a better explanation, not
necessarily here but in the omap4 code that reads the nvalues.  I expected that these
would be single byte aligned to compact the address space and remove some unused
space, but no, they seem to be arbitrarily shifted around.  

Kevin


