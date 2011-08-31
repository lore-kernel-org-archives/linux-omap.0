From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] iommu: omap_iovmm: support non page-aligned buffers in iommu_vmap
Date: Wed, 31 Aug 2011 20:16:18 +0300
Message-ID: <CAK=WgbZeOaMduf6xDb2j6OzbDBC4c8Qd2q0zfYf-VeG6Tbcwhw@mail.gmail.com>
References: <1314646569-16738-1-git-send-email-ohad@wizery.com>
 <CAK=Wgbb06Z0_8OKFf6MKjYe+SJN16Mh9PA6z_T+cpSpB9EKHFw@mail.gmail.com>
 <20110831130642.GQ12940@amd.com> <201108311856.26969.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53827 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753985Ab1HaRQj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Aug 2011 13:16:39 -0400
Received: by wyh22 with SMTP id 22so325920wyh.19
        for <linux-omap@vger.kernel.org>; Wed, 31 Aug 2011 10:16:38 -0700 (PDT)
In-Reply-To: <201108311856.26969.laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: "Roedel, Joerg" <Joerg.Roedel@amd.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>

Hi Laurent, Joerg,

On Wed, Aug 31, 2011 at 7:56 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Wednesday 31 August 2011 15:06:42 Roedel, Joerg wrote:
>> Do you mean the parts of the pages you map to the device that are not in
>> the requested range (basically everything before offset and all after
>> size)?
>> This issue exists in other iommu drivers as well. It is inherent to how
>> the dma-api is defined and how the iommu hardware works.
>> The dma-api can work on byte granularity while the hardware usually only
>> works on page granularity.
>
> True, but if we implement address rounding transparently in the IOMMU layer
> Ohad's concern can be valid, depending on whether the device is trusted. If we
> decide to push address rounding to the drivers that decision can be made on a
> per-device basis. However, drivers are usually not aware of what granularity
> the IOMMU works on, so that wouldn't be straightforward and clean.

I think the confusion lies in the fact that omap's iovmm should be
treated as the DMA-API (which will soon replace it altogether anyway)
and not as an IOMMU driver, and in that sense, Laurent's patch does
sound reasonable.

However, one needs to keep this in mind (e.g. map only page-aligned
buffers ?) when using the upcoming iommu-based DMA-API with untrusted
devices (such as remote processors running arbitrary code). It is
completely wrong to allow these devices access to random physical
memory regions. We might want to come up with a way to prevent this
from happening...

Thanks,
Ohad.
