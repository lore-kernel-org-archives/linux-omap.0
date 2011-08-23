From: "Roedel, Joerg" <Joerg.Roedel@amd.com>
Subject: Re: [PATCH 1/7] omap: iommu: migrate to the generic IOMMU API
Date: Tue, 23 Aug 2011 16:07:46 +0200
Message-ID: <20110823140746.GP2079@amd.com>
References: <1313622608-30397-1-git-send-email-ohad@wizery.com>
 <1313622608-30397-2-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]:5729
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754879Ab1HWOIE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Aug 2011 10:08:04 -0400
Content-Disposition: inline
In-Reply-To: <1313622608-30397-2-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Arnd Bergmann <arnd@arndb.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>

On Wed, Aug 17, 2011 at 07:10:02PM -0400, Ohad Ben-Cohen wrote:
> +/**
> + * omap_iommu_attach() - attach iommu device to an iommu domain
> + * @dev:       target omap iommu device
> + * @iopgd:     page table
>   **/
> -struct iommu *iommu_get(const char *name)
> +static struct iommu *omap_iommu_attach(struct device *dev, u32 *iopgd)
>  {
>         int err = -ENOMEM;
> -       struct device *dev;
> -       struct iommu *obj;
> -
> -       dev = driver_find_device(&omap_iommu_driver.driver, NULL, (void *)name,
> -                                device_match_by_alias);
> -       if (!dev)
> -               return ERR_PTR(-ENODEV);
> -
> -       obj = to_iommu(dev);
> +       struct iommu *obj = to_iommu(dev);
> 
>         mutex_lock(&obj->iommu_lock);

I don't think using a mutex here is a good idea. This prevents this
function to be called from atomic context. The iommu_map and _unmap
functions need to allowed in atomic-context and I don't want different
context constraints within the iommu-api. Can this be easily converted
to a spin_lock?

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632

