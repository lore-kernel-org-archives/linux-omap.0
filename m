From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH 2/2] iommu/omap: Remove omap_iommu unused owner field
Date: Tue, 9 Sep 2014 16:41:05 -0500
Message-ID: <540F73F1.6060701@ti.com>
References: <1410277545-32157-1-git-send-email-laurent.pinchart@ideasonboard.com> <1410277545-32157-3-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35248 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750910AbaIIVlS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 9 Sep 2014 17:41:18 -0400
In-Reply-To: <1410277545-32157-3-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, iommu@lists.linux-foundation.org
Cc: linux-omap@vger.kernel.org, Florian Vaussard <florian.vaussard@epfl.ch>, Joerg Roedel <joro@8bytes.org>

Hi Laurent,

On 09/09/2014 10:45 AM, Laurent Pinchart wrote:
> The owner field is never set. Remove it.

Thanks, this seems to have been dead code since the days OMAP IOMMU has
been converted from building as modules to built-in as part of the IOMMU
API adoption. So,

Acked-by: Suman Anna <s-anna@ti.com>

regards
Suman

> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  drivers/iommu/omap-iommu.c | 11 -----------
>  drivers/iommu/omap-iommu.h |  1 -
>  2 files changed, 12 deletions(-)
> 
> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> index 192c367..fdfe732 100644
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c
> @@ -861,20 +861,11 @@ static struct omap_iommu *omap_iommu_attach(const char *name, u32 *iopgd)
>  		goto err_enable;
>  	flush_iotlb_all(obj);
>  
> -	if (!try_module_get(obj->owner)) {
> -		dev_err(obj->dev, "%s: can't get owner\n", __func__);
> -		err = -ENODEV;
> -		goto err_module;
> -	}
> -
>  	spin_unlock(&obj->iommu_lock);
>  
>  	dev_dbg(obj->dev, "%s: %s\n", __func__, obj->name);
>  	return obj;
>  
> -err_module:
> -	if (obj->refcount == 1)
> -		iommu_disable(obj);
>  err_enable:
>  	obj->refcount--;
>  	spin_unlock(&obj->iommu_lock);
> @@ -895,8 +886,6 @@ static void omap_iommu_detach(struct omap_iommu *obj)
>  	if (--obj->refcount == 0)
>  		iommu_disable(obj);
>  
> -	module_put(obj->owner);
> -
>  	obj->iopgd = NULL;
>  
>  	spin_unlock(&obj->iommu_lock);
> diff --git a/drivers/iommu/omap-iommu.h b/drivers/iommu/omap-iommu.h
> index 7a90800..2c3b85c 100644
> --- a/drivers/iommu/omap-iommu.h
> +++ b/drivers/iommu/omap-iommu.h
> @@ -28,7 +28,6 @@ struct iotlb_entry {
>  
>  struct omap_iommu {
>  	const char	*name;
> -	struct module	*owner;
>  	void __iomem	*regbase;
>  	struct device	*dev;
>  	void		*isr_priv;
> 

