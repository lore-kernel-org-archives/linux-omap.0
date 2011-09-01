From: "Roedel, Joerg" <Joerg.Roedel@amd.com>
Subject: Re: [PATCH] iommu: omap_iovmm: support non page-aligned buffers in
 iommu_vmap
Date: Thu, 1 Sep 2011 11:35:18 +0200
Message-ID: <20110901093518.GC15287@amd.com>
References: <1314646569-16738-1-git-send-email-ohad@wizery.com>
 <CAK=Wgbb06Z0_8OKFf6MKjYe+SJN16Mh9PA6z_T+cpSpB9EKHFw@mail.gmail.com>
 <20110831130642.GQ12940@amd.com>
 <201108311856.26969.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from db3ehsobe002.messaging.microsoft.com ([213.199.154.140]:36853
	"EHLO DB3EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750879Ab1IAJgd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Sep 2011 05:36:33 -0400
Content-Disposition: inline
In-Reply-To: <201108311856.26969.laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>

On Wed, Aug 31, 2011 at 12:56:26PM -0400, Laurent Pinchart wrote:
> True, but if we implement address rounding transparently in the IOMMU layer 
> Ohad's concern can be valid, depending on whether the device is trusted. If we 
> decide to push address rounding to the drivers that decision can be made on a 
> per-device basis. However, drivers are usually not aware of what granularity 
> the IOMMU works on, so that wouldn't be straightforward and clean.

Drivers usually just use the DMA-API, so they can not assume at all that
any protection happens. The problem also can't be really solved without
changing/breaking the DMA-API. It is defined to work on byte granularity
while the hardware only works with pages.

The only way to work around this it to implement the driver in a way so
that they only map page-aligned buffers where the size is also a
multiple of a page-size.

In this case you can assume the page-size you are working on because you
already assume in the driver that an iommu is in use.

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632

