From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 0/4] iommu: Prevent oops in iommu_get() and while arch_iommu is in use
Date: Tue, 29 Mar 2011 17:32:52 +0200
Message-ID: <201103291732.52620.laurent.pinchart@ideasonboard.com>
References: <4D8CB106.7030608@maxwell.research.nokia.com> <AANLkTikxd4kRu1+XskohhQzpqHaZTvK+afbgE-qRSOqN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:54742 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750Ab1C2Pcg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Mar 2011 11:32:36 -0400
In-Reply-To: <AANLkTikxd4kRu1+XskohhQzpqHaZTvK+afbgE-qRSOqN@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, Cohen David Abraham <david.cohen@nokia.com>

On Friday 25 March 2011 20:37:55 Ramirez Luna, Omar wrote:
> On Fri, Mar 25, 2011 at 10:13 AM, Sakari Ailus
> 
> <sakari.ailus@maxwell.research.nokia.com> wrote:
> > Hi,
> > 
> > This patchset is aimed to fix a problem in arch_iommu implementation
> > references. When an actual arch_iommu implementation is not loaded while
> > iommu_get() is being called results to a kernel oops, as well as
> > removing an arch_iommu implementation which is in use.
> 
> How about fixing the dependency instead? Right now iommu2 depends on
> iommu because of the calls to
> install_iommu_arch/uninstall_iommu_arch... we should change that
> dependency to iommu depend on iommu2. Something like iommu (plat)
> querying iommu2 (mach) for devices to install.

The reason why iommu depends on iommu2 and not the other way around is because 
several mach-specific iommu implementations should be able to coexist in the 
same kernel. The right one should be loaded at runtime.

I think that Sakari's patches correcty fix the problems he noticed. However, 
they won't fix one basic issue, which is that the iommu2 module won't be 
automatically pulled in when the omap3isp module is loaded. The omap3isp 
driver will then fail to probe the device. That's better than crashing though.

One possible solution for that is to turn the tristate option for iommu2 into 
a bool option. I've also read a couple of times that the kernel provides a 
standard iommu API. Maybe switching to it would help.

> This way depmod (if I'm not mistaken) can do its job, you won't be
> able to remove iommu2 in the middle of execution nor install iommu
> without its mach counterpart being there first, it should also fix
> clients depending on this modules, e.g "modprobe bridgedriver" would
> only install iommu and bridgedriver, with this new dependency iommu2
> should be installed as well. BTW same happens with omap mailbox.
> 
> $ lsmod
> iovmm                   7225  1 bridgedriver
> iommu                  11084  2 bridgedriver,iovmm
> iommu2                  4783  1 iommu
> 
> I can send as a patch if the mailer screws the spacing, also just
> copy-pasted and played with the pointers, if needed we can give better
> naming.

-- 
Regards,

Laurent Pinchart
