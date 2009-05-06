From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 1/6] omap iommu: tlb and pagetable primitives
Date: Wed, 06 May 2009 08:56:46 +0300 (EEST)
Message-ID: <20090506.085646.70211243.Hiroshi.DOYU@nokia.com>
References: <20090505123905.4583.69865.stgit@oreo.research.nokia.com>
	<20090505124650.4583.39458.stgit@oreo.research.nokia.com>
	<8F7AF80515AF0D4D93307E594F3CB40E2AE46B4D@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:22567 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753126AbZEFF5H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 May 2009 01:57:07 -0400
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E2AE46B4D@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: h-kanigeri2@ti.com
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, omar.ramirez@ti.com, sakari.ailus@maxwell.research.nokia.com, tony@atomide.com, vpasam@ti.com

Hi Hari,

From: "ext Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 1/6] omap iommu: tlb and pagetable primitives
Date: Tue, 5 May 2009 22:19:55 +0200

> Hi Doyu-san,
> 
> +static void iotlb_lock_set(struct iommu *obj, struct iotlb_lock *l) {
> +	u32 val;
> +
> +	BUG_ON(l->base != 0); /* Currently no preservation is used */
> 
> -- Did you notice any issues in the IOMMU driver by enabling the preservation? 
> 
> Bridge driver is locking the memory segment that is used for IPC in
> the TLB and by not having the preservation we might see a hit in the
> performance.

The current user of this driver is "camera isp" and no need for tlb
preservation for it, but it's on todo list for other clients.


