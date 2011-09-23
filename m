From: "Roedel, Joerg" <Joerg.Roedel@amd.com>
Subject: Re: [PATCH] iommu/omap: Fix build error with !IOMMU_SUPPORT
Date: Fri, 23 Sep 2011 11:05:57 +0200
Message-ID: <20110923090557.GB16329@amd.com>
References: <1316009259-18052-1-git-send-email-joerg.roedel@amd.com>
 <201109180202.23123.laurent.pinchart@ideasonboard.com>
 <20110920100146.GA2078@amd.com>
 <201109201254.39542.laurent.pinchart@ideasonboard.com>
 <CAMP44s2-sBUGsOYzOxTMamOfw+Od4jOWriRinG=qkpt68WvQ9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from am1ehsobe005.messaging.microsoft.com ([213.199.154.208]:46279
	"EHLO AM1EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752266Ab1IWJGL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Sep 2011 05:06:11 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s2-sBUGsOYzOxTMamOfw+Od4jOWriRinG=qkpt68WvQ9Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Sep 22, 2011 at 09:48:27AM -0400, Felipe Contreras wrote:
> On Tue, Sep 20, 2011 at 1:54 PM, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> > On Tuesday 20 September 2011 12:01:46 Roedel, Joerg wrote:
> >> On Sat, Sep 17, 2011 at 08:02:22PM -0400, Laurent Pinchart wrote:
> >> > On Wednesday 14 September 2011 16:07:39 Joerg Roedel wrote:
> >> > > Without this patch it is possible to select the VIDEO_OMAP3
> >> > > driver which then selects OMAP_IOVMM. But the omap iommu
> >> > > driver is not compiled without IOMMU_SUPPORT enabled. Fix
> >> > > that by forcing OMAP_IOMMU and OMAP_IOVMM are enabled before
> >> > > VIDEO_OMAP3 can be selected.
> >> >
> >> > What about making VIDEO_OMAP3 select IOMMU_SUPPORT instead then ? Your
> >> > patch would make the OMAP3 ISP driver disappear from the menu until
> >> > IOMMU_SUPPORT gets turned on, which can confuse users.
> >>
> >> Using 'depends on' rather then 'selects' is common standard in Kconfig.
> >> You can't select PCI drivers without selecting PCI first, for example.
> >
> > You wouldn't expect a PCI driver to work without PCI support. My concern is
> > that most OMAP3 ISP users won't know that IOMMU supports is required. Feel
> > free to ignore it though :-)
> 
> I agree with Laurent. As a user, why should I care about IOMMU? I just
> want this thing.

Because enabling IOMMU can have other side-effects on the system and as
a user you want to be aware that it is enabled. A user not wanting the
iommu driver can just disable it then without the need to de-select all
drivers depending on it first.

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632

