From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 1/7] omap: iommu: migrate to the generic IOMMU API
Date: Thu, 18 Aug 2011 11:01:57 +0200
Message-ID: <201108181101.57882.laurent.pinchart@ideasonboard.com>
References: <1313622608-30397-1-git-send-email-ohad@wizery.com> <1313622608-30397-2-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:48210 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755217Ab1HRJB5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Aug 2011 05:01:57 -0400
In-Reply-To: <1313622608-30397-2-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Joerg Roedel <Joerg.Roedel@amd.com>, Arnd Bergmann <arnd@arndb.de>, iommu@lists.linux-foundation.org

Hi Ohad,

Thanks for the patch.

Just one small comment in case you resubmit the whole series for another 
reason.

On Thursday 18 August 2011 01:10:02 Ohad Ben-Cohen wrote:
> Migrate OMAP's iommu driver to the generic IOMMU API, so users can stay
> generic, and any generic IOMMU functionality can be developed once
> in the generic framework.
> 
> Migrate omap's iovmm (virtual memory manager) to the generic IOMMU API,
> and adapt omap3isp as needed, so the latter won't break.
> 
> The plan is to eventually remove iovmm completely by replacing it
> with the (upcoming) IOMMU-based DMA-API.
> 
> Tested on OMAP3 (with omap3isp) and OMAP4 (with rpmsg/remoteproc).
> 
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>

[snip]

> +static void omap_iommu_detach_dev(struct iommu_domain *domain,
> +				 struct device *dev)
> +{
> +	struct omap_iommu_domain *omap_domain = domain->priv;
> +	struct iommu *oiommu = to_iommu(dev);
> +
> +	mutex_lock(&omap_domain->lock);
> +
> +	/* only a single device is supported per domain for now */
> +	if (omap_domain->iommu_dev != oiommu) {
> +		dev_err(dev, "invalid iommu device\n");
> +		goto out;
> +	}
> +
> +	iopgtable_clear_entry_all(oiommu);
> +
> +	omap_iommu_detach(oiommu);
> +
> +	omap_domain->iommu_dev = NULL;
> +
> +out:
> +	mutex_unlock(&omap_domain->lock);
> +}
> +
> +static int omap_iommu_domain_init(struct iommu_domain *domain)
> +{
> +	struct omap_iommu_domain *omap_domain;
> +
> +	omap_domain = kzalloc(sizeof(*omap_domain), GFP_KERNEL);
> +	if (!omap_domain) {
> +		pr_err("kzalloc failed\n");
> +		goto out;

You can directly return -ENOMEM here, and remove the "out:" label.

> +	}
> +
> +	omap_domain->pgtable = kzalloc(IOPGD_TABLE_SIZE, GFP_KERNEL);
> +	if (!omap_domain->pgtable) {
> +		pr_err("kzalloc failed\n");
> +		goto fail_nomem;
> +	}
> +
> +	/*
> +	 * should never fail, but please keep this around to ensure
> +	 * we keep the hardware happy
> +	 */
> +	BUG_ON(!IS_ALIGNED((long)omap_domain->pgtable, IOPGD_TABLE_SIZE));
> +
> +	clean_dcache_area(omap_domain->pgtable, IOPGD_TABLE_SIZE);
> +	mutex_init(&omap_domain->lock);
> +
> +	domain->priv = omap_domain;
> +
> +	return 0;
> +
> +fail_nomem:
> +	kfree(omap_domain);
> +out:
> +	return -ENOMEM;
> +}

-- 
Regards,

Laurent Pinchart
