From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] iommu: omap_iovmm: support non page-aligned buffers in iommu_vmap
Date: Wed, 31 Aug 2011 13:27:27 +0200
Message-ID: <201108311327.28843.laurent.pinchart@ideasonboard.com>
References: <1314646569-16738-1-git-send-email-ohad@wizery.com> <CAK=Wgbb06Z0_8OKFf6MKjYe+SJN16Mh9PA6z_T+cpSpB9EKHFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:48651 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755163Ab1HaL1A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Aug 2011 07:27:00 -0400
In-Reply-To: <CAK=Wgbb06Z0_8OKFf6MKjYe+SJN16Mh9PA6z_T+cpSpB9EKHFw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, Joerg Roedel <Joerg.Roedel@amd.com>, iommu@lists.linux-foundation.org

Hi Ohad,

On Wednesday 31 August 2011 12:52:08 Ohad Ben-Cohen wrote:
> On Mon, Aug 29, 2011 at 10:36 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> > From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > 
> > omap_iovmm requires page-aligned buffers, and that sometimes causes
> > omap3isp failures (i.e. whenever the buffer passed from userspace is not
> > page-aligned).
> > 
> > Remove this limitation by rounding the address of the first page entry
> > down, and adding the offset back to the device address.
> 
> I'm having second thoughts about this.
> 
> Obviously it works for omap3isp and its users because the buffer gets
> mapped and everyone is happy.
> 
> But I'm not sure this is a valid IOMMU interface that the kernel
> should have, because effectively we're now mapping physical memory
> which nobody asked us to, and which might contain sensitive stuff we
> don't want to give the device (e.g. a remote processor which might be
> running rogue code) access to.
> 
> Thoughts ?

That can indeed be an issue, depending on whether we consider the device as 
trusted or not. This decision can't obviously be taken by the IOMMU layer.

Do you think it would be better to move this code to the OMAP3 ISP driver ?

-- 
Regards,

Laurent Pinchart
