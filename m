From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH 2/5] omap:hwspinlock-define HWSPINLOCK base address
Date: Tue, 27 Jul 2010 21:29:34 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E7DA2246@dbde02.ent.ti.com>
References: <1279558221-14954-1-git-send-email-h-kanigeri2@ti.com>
 <1279558221-14954-3-git-send-email-h-kanigeri2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33836 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751716Ab0G0P7k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Jul 2010 11:59:40 -0400
In-Reply-To: <1279558221-14954-3-git-send-email-h-kanigeri2@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>, Linux Omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Que, Simon" <sque@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kanigeri, Hari
> Sent: Monday, July 19, 2010 10:20 PM
> To: Linux Omap; Tony Lindgren
> Cc: Shilimkar, Santosh; Cousson, Benoit; Que, Simon; Kanigeri, Hari
> Subject: [PATCH 2/5] omap:hwspinlock-define HWSPINLOCK base address
> 
> From: Simon Que <sque@ti.com>
> 
> Add HWSPINLCOK base address information in omap44xx.h
> 
> Signed-off-by: Simon Que <sque@ti.com>
> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> ---
>  arch/arm/plat-omap/include/plat/omap44xx.h |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/omap44xx.h 
> b/arch/arm/plat-omap/include/plat/omap44xx.h
> index 76832d3..8016508 100644
> --- a/arch/arm/plat-omap/include/plat/omap44xx.h
> +++ b/arch/arm/plat-omap/include/plat/omap44xx.h
> @@ -49,5 +49,10 @@
>  #define OMAP44XX_MAILBOX_BASE		(L4_44XX_BASE + 0xF4000)
>  #define OMAP44XX_HSUSB_OTG_BASE		(L4_44XX_BASE + 0xAB000)
>  
> +#define OMAP4_MMU1_BASE			0x55082000
> +#define OMAP4_MMU2_BASE			0x4A066000

[sp] Are these 2 base addresses related to this patch?

~sanjeev

> +
> +#define OMAP44XX_SPINLOCK_BASE		(L4_44XX_BASE + 0xF6000)
> +
>  #endif /* __ASM_ARCH_OMAP44XX_H */
>  
> -- 
> 1.7.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 