From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH] omap_iommu: Correct function name in the comment
Date: Mon, 20 Apr 2009 09:31:00 +0300 (EEST)
Message-ID: <20090420.093100.212696479.Hiroshi.DOYU@nokia.com>
References: <1239976445-18356-1-git-send-email-ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:30342 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752393AbZDTGbP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Apr 2009 02:31:15 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n3K6UiWd028201
	for <linux-omap@vger.kernel.org>; Mon, 20 Apr 2009 09:31:10 +0300
In-Reply-To: <1239976445-18356-1-git-send-email-ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ameya.palande@nokia.com
Cc: linux-omap@vger.kernel.org

Hi Ameya,

From: "Palande Ameya (Nokia-D/Helsinki)" <ameya.palande@nokia.com>
Subject: [PATCH] omap_iommu: Correct function name in the comment
Date: Fri, 17 Apr 2009 15:54:05 +0200

> From: Ameya Palande <ameya.palande@nokia.com>
> 
> Signed-off-by: Ameya Palande <ameya.palande@nokia.com>

I'll merge this into my gitorious repository.
Thanks.

> ---
>  arch/arm/plat-omap/iommu.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
> index 40e089f..0cec3f0 100644
> --- a/arch/arm/plat-omap/iommu.c
> +++ b/arch/arm/plat-omap/iommu.c
> @@ -779,7 +779,7 @@ static int device_match_by_alias(struct device *dev, void *data)
>  }
>  
>  /**
> - * iommu_put() - Get iommu handler
> + * iommu_get() - Get iommu handler
>   * @name:	target iommu name
>   **/
>  struct iommu *iommu_get(const char *name)
> -- 
> 1.6.2.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
