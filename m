From: "Roedel, Joerg" <Joerg.Roedel@amd.com>
Subject: Re: [PATCH] iommu: omap_iovmm: support non page-aligned buffers in
 iommu_vmap
Date: Thu, 1 Sep 2011 15:42:09 +0200
Message-ID: <20110901134209.GD16691@amd.com>
References: <1314646569-16738-1-git-send-email-ohad@wizery.com>
 <CAK=Wgbb06Z0_8OKFf6MKjYe+SJN16Mh9PA6z_T+cpSpB9EKHFw@mail.gmail.com>
 <CAK=WgbaOSaKcxmsG2L3G3g+bORvtq4nyzCg9yhA=tTLhsYmh3w@mail.gmail.com>
 <201109011531.13980.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:22206 "EHLO
	TX2EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757520Ab1IANmP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Sep 2011 09:42:15 -0400
Content-Disposition: inline
In-Reply-To: <201109011531.13980.laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>

On Thu, Sep 01, 2011 at 09:31:13AM -0400, Laurent Pinchart wrote:
> Hi Ohad,
> 
> On Thursday 01 September 2011 13:47:26 Ohad Ben-Cohen wrote:
> > On Wed, Aug 31, 2011 at 1:52 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> > > From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > 
> > > omap_iovmm requires page-aligned buffers, and that sometimes causes
> > > omap3isp failures (i.e. whenever the buffer passed from userspace is not
> > > page-aligned).
> > > 
> > > Remove this limitation by rounding the address of the first page entry
> > > down, and adding the offset back to the device address.
> > 
> > Seems like the unmap paths were skipped (need to adjust the sizes in
> > the unmap path too).
> > 
> > Laurent, if it looks good to you, I'll just squash it to the original
> > patch and repost:
> 
> Do you have a tree where the current code base can be found ?

Please base your upstream-patches against

	git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git arm/omap

Thanks,

	Joerg


-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632

