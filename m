From: "Roedel, Joerg" <Joerg.Roedel@amd.com>
Subject: Re: [PATCH v2 0/7] omap: iommu migration, relocation and cleanups
Date: Fri, 26 Aug 2011 13:25:31 +0200
Message-ID: <20110826112531.GQ1923@amd.com>
References: <1314205694-28935-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ch1ehsobe006.messaging.microsoft.com ([216.32.181.186]:43203
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750983Ab1HZLZk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Aug 2011 07:25:40 -0400
Content-Disposition: inline
In-Reply-To: <1314205694-28935-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Arnd Bergmann <arnd@arndb.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>

On Wed, Aug 24, 2011 at 01:08:07PM -0400, Ohad Ben-Cohen wrote:
> Ohad Ben-Cohen (7):
>   omap: iommu: migrate to the generic IOMMU API
>   omap: iommu/iovmm: move to dedicated iommu folder
>   omap: iommu: stop exporting local functions
>   omap: iommu: PREFETCH_IOTLB cleanup
>   omap: iovmm: remove unused functionality
>   omap: iommu: remove unused exported API
>   omap: iommu: omapify 'struct iommu' and exposed API

Applied all to arm/omap, thanks Ohad. I also put a commit on-top which
finished the mutex->spin_lock conversion. Looks like one call-place was
missed. See attached patch.

commit 4234541f1a64d9dc6d489cf8f614dc01c62360f6
Author: Joerg Roedel <joerg.roedel@amd.com>
Date:   Fri Aug 26 13:20:06 2011 +0200

    omap: iommu: Fix up mutex->spin_lock conversion of iommu_lock
    
    The omap_iommu_set_isr() was still using the mutex functions
    but the iommu_lock was converted to a spin_lock. Fix that
    up.
    
    Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index dad45ab..90744af 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -918,14 +918,14 @@ int omap_iommu_set_isr(const char *name,
 		return -ENODEV;
 
 	obj = to_iommu(dev);
-	mutex_lock(&obj->iommu_lock);
+	spin_lock(&obj->iommu_lock);
 	if (obj->refcount != 0) {
-		mutex_unlock(&obj->iommu_lock);
+		spin_unlock(&obj->iommu_lock);
 		return -EBUSY;
 	}
 	obj->isr = isr;
 	obj->isr_priv = isr_priv;
-	mutex_unlock(&obj->iommu_lock);
+	spin_unlock(&obj->iommu_lock);
 
 	return 0;
 }

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632

