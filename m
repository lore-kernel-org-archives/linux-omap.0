From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: [PATCH 3/3] omap iommu: fix incorrect address for supersection
 1st entry
Date: Mon, 11 Jan 2010 16:00:07 -0600
Message-ID: <A24693684029E5489D1D202277BE8944513DBE61@dlee02.ent.ti.com>
References: <1263195995-23244-1-git-send-email-Hiroshi.DOYU@nokia.com>
 <1263195995-23244-2-git-send-email-Hiroshi.DOYU@nokia.com>
 <1263195995-23244-3-git-send-email-Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36277 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752276Ab0AKV5h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jan 2010 16:57:37 -0500
In-Reply-To: <1263195995-23244-3-git-send-email-Hiroshi.DOYU@nokia.com>
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
> Subject: [PATCH 3/3] omap iommu: fix incorrect address for supersection
> 1st entry
> 
> From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

... and description missing here too.

Regards,
Sergio
> 
> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> ---
>  arch/arm/plat-omap/iommu.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
> index ccf25b3..ce0072a 100644
> --- a/arch/arm/plat-omap/iommu.c
> +++ b/arch/arm/plat-omap/iommu.c
> @@ -667,7 +667,7 @@ static size_t iopgtable_clear_entry_core(struct iommu
> *obj, u32 da)
>  		if ((*iopgd & IOPGD_SUPER) == IOPGD_SUPER) {
>  			nent *= 16;
>  			/* rewind to the 1st entry */
> -			iopgd = (u32 *)((u32)iopgd & IOSUPER_MASK);
> +			iopgd = iopgd_offset(obj, (da & IOSUPER_MASK));
>  		}
>  		bytes *= nent;
>  	}
> --
> 1.6.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
