From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: [PATCH 1/3] omap iommu: cleanup iommu page address mask and
 definitions
Date: Mon, 11 Jan 2010 15:53:16 -0600
Message-ID: <A24693684029E5489D1D202277BE8944513DBE43@dlee02.ent.ti.com>
References: <1263195995-23244-1-git-send-email-Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40375 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917Ab0AKVwz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jan 2010 16:52:55 -0500
In-Reply-To: <1263195995-23244-1-git-send-email-Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Nagalla, Hari" <hnagalla@ti.com>

Hi Hiroshi,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Hiroshi DOYU
> Sent: Monday, January 11, 2010 1:47 AM
> To: linux-omap@vger.kernel.org
> Cc: Nagalla, Hari; Hiroshi DOYU
> Subject: [PATCH 1/3] omap iommu: cleanup iommu page address mask and
> definitions
> 
> From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Maybe a small description would help here...

Are you just reshuffling defines, or are you also adding new ones?

Is this just a cleanup or is it fixing a hidden bug?

Regards,
Sergio
> 
> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> ---
>  arch/arm/plat-omap/iopgtable.h |   50 +++++++++++++++++++++++++++++++----
> ----
>  1 files changed, 39 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/iopgtable.h b/arch/arm/plat-
> omap/iopgtable.h
> index 37dac43..ab23b6a 100644
> --- a/arch/arm/plat-omap/iopgtable.h
> +++ b/arch/arm/plat-omap/iopgtable.h
> @@ -1,7 +1,7 @@
>  /*
>   * omap iommu: pagetable definitions
>   *
> - * Copyright (C) 2008-2009 Nokia Corporation
> + * Copyright (C) 2008-2010 Nokia Corporation
>   *
>   * Written by Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
>   *
> @@ -13,26 +13,52 @@
>  #ifndef __PLAT_OMAP_IOMMU_H
>  #define __PLAT_OMAP_IOMMU_H
> 
> +/*
> + * "L2 table" address mask and size definitions.
> + */
>  #define IOPGD_SHIFT		20
> -#define IOPGD_SIZE		(1 << IOPGD_SHIFT)
> +#define IOPGD_SIZE		(1UL << IOPGD_SHIFT)
>  #define IOPGD_MASK		(~(IOPGD_SIZE - 1))
> -#define IOSECTION_MASK		IOPGD_MASK
> -#define PTRS_PER_IOPGD		(1 << (32 - IOPGD_SHIFT))
> -#define IOPGD_TABLE_SIZE	(PTRS_PER_IOPGD * sizeof(u32))
> 
> -#define IOSUPER_SIZE		(IOPGD_SIZE << 4)
> +/*
> + * "section" address mask and size definitions.
> + */
> +#define IOSECTION_SHIFT		20
> +#define IOSECTION_SIZE		(1UL << IOSECTION_SHIFT)
> +#define IOSECTION_MASK		(~(IOSECTION_SIZE - 1))
> +
> +/*
> + * "supersection" address mask and size definitions.
> + */
> +#define IOSUPER_SHIFT		24
> +#define IOSUPER_SIZE		(1UL << IOSUPER_SHIFT)
>  #define IOSUPER_MASK		(~(IOSUPER_SIZE - 1))
> 
> +#define PTRS_PER_IOPGD		(1UL << (32 - IOPGD_SHIFT))
> +#define IOPGD_TABLE_SIZE	(PTRS_PER_IOPGD * sizeof(u32))
> +
> +/*
> + * "small page" address mask and size definitions.
> + */
>  #define IOPTE_SHIFT		12
> -#define IOPTE_SIZE		(1 << IOPTE_SHIFT)
> +#define IOPTE_SIZE		(1UL << IOPTE_SHIFT)
>  #define IOPTE_MASK		(~(IOPTE_SIZE - 1))
> -#define IOPAGE_MASK		IOPTE_MASK
> -#define PTRS_PER_IOPTE		(1 << (IOPGD_SHIFT - IOPTE_SHIFT))
> -#define IOPTE_TABLE_SIZE	(PTRS_PER_IOPTE * sizeof(u32))
> 
> -#define IOLARGE_SIZE		(IOPTE_SIZE << 4)
> +/*
> + * "large page" address mask and size definitions.
> + */
> +#define IOLARGE_SHIFT		16
> +#define IOLARGE_SIZE		(1UL << IOLARGE_SHIFT)
>  #define IOLARGE_MASK		(~(IOLARGE_SIZE - 1))
> 
> +#define PTRS_PER_IOPTE		(1UL << (IOPGD_SHIFT - IOPTE_SHIFT))
> +#define IOPTE_TABLE_SIZE	(PTRS_PER_IOPTE * sizeof(u32))
> +
> +#define IOPAGE_MASK		IOPTE_MASK
> +
> +/*
> + * some descriptor attributes.
> + */
>  #define IOPGD_TABLE		(1 << 0)
>  #define IOPGD_SECTION		(2 << 0)
>  #define IOPGD_SUPER		(1 << 18 | 2 << 0)
> @@ -40,12 +66,14 @@
>  #define IOPTE_SMALL		(2 << 0)
>  #define IOPTE_LARGE		(1 << 0)
> 
> +/* to find an entry in a page-table-directory */
>  #define iopgd_index(da)		(((da) >> IOPGD_SHIFT) &
> (PTRS_PER_IOPGD - 1))
>  #define iopgd_offset(obj, da)	((obj)->iopgd + iopgd_index(da))
> 
>  #define iopte_paddr(iopgd)	(*iopgd & ~((1 << 10) - 1))
>  #define iopte_vaddr(iopgd)	((u32 *)phys_to_virt(iopte_paddr(iopgd)))
> 
> +/* to find an entry in the second-level page table. */
>  #define iopte_index(da)		(((da) >> IOPTE_SHIFT) &
> (PTRS_PER_IOPTE - 1))
>  #define iopte_offset(iopgd, da)	(iopte_vaddr(iopgd) + iopte_index(da))
> 
> --
> 1.6.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
