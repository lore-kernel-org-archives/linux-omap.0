From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH 2/4 v2] omap: hwspinlock: Add HWSPINLOCK base address
 information in omap44xx.h
Date: Thu, 12 Aug 2010 14:59:24 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E8147031@dbde02.ent.ti.com>
References: <F39349C6FA641B4A831B7BF4EBF4D4E1480D9E47@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46128 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660Ab0HLJ3c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Aug 2010 05:29:32 -0400
In-Reply-To: <F39349C6FA641B4A831B7BF4EBF4D4E1480D9E47@dlee03.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Que, Simon" <sque@ti.com>, Linux Omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>

> -----Original Message-----
> From: Que, Simon 
> Sent: Thursday, August 12, 2010 6:00 AM
> To: Linux Omap; Tony Lindgren
> Cc: Cousson, Benoit; Shilimkar, Santosh; Premi, Sanjeev; 
> Kanigeri, Hari
> Subject: [PATCH 2/4 v2] omap: hwspinlock: Add HWSPINLOCK base 
> address information in omap44xx.h
> 
> Add HWSPINLOCK base address information in omap44xx.h
> 
> Signed-off-by: Simon Que <sque@ti.com>
> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> ---
>  arch/arm/plat-omap/include/plat/omap44xx.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/omap44xx.h 
> b/arch/arm/plat-omap/include/plat/omap44xx.h
> index 8b3f12f..8016508 100644
> --- a/arch/arm/plat-omap/include/plat/omap44xx.h
> +++ b/arch/arm/plat-omap/include/plat/omap44xx.h
> @@ -52,5 +52,7 @@
>  #define OMAP4_MMU1_BASE                        0x55082000
>  #define OMAP4_MMU2_BASE                        0x4A066000
> 
> +#define OMAP44XX_SPINLOCK_BASE         (L4_44XX_BASE + 0xF6000)
> +

[sp] Can this be simply OMAP4_SPINLOCK_BASE equiv to OMAP4_MMUx_BASE
     defined just above. OR is this address specific to OMAP44xx only?
     (I haven't checked what is the the convention followed in rest of
     the file)

>  #endif /* __ASM_ARCH_OMAP44XX_H */
> --
> 1.7.1
> 