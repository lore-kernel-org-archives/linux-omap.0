From: "Roedel, Joerg" <Joerg.Roedel@amd.com>
Subject: Re: [PATCH] iommu/omap: Fix build error with !IOMMU_SUPPORT
Date: Tue, 20 Sep 2011 12:01:46 +0200
Message-ID: <20110920100146.GA2078@amd.com>
References: <1316009259-18052-1-git-send-email-joerg.roedel@amd.com>
 <201109180202.23123.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201109180202.23123.laurent.pinchart@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Laurent,

On Sat, Sep 17, 2011 at 08:02:22PM -0400, Laurent Pinchart wrote:
> On Wednesday 14 September 2011 16:07:39 Joerg Roedel wrote:
> > Without this patch it is possible to select the VIDEO_OMAP3
> > driver which then selects OMAP_IOVMM. But the omap iommu
> > driver is not compiled without IOMMU_SUPPORT enabled. Fix
> > that by forcing OMAP_IOMMU and OMAP_IOVMM are enabled before
> > VIDEO_OMAP3 can be selected.
> 
> What about making VIDEO_OMAP3 select IOMMU_SUPPORT instead then ? Your patch 
> would make the OMAP3 ISP driver disappear from the menu until IOMMU_SUPPORT 
> gets turned on, which can confuse users.

Using 'depends on' rather then 'selects' is common standard in Kconfig.
You can't select PCI drivers without selecting PCI first, for example.
Further selecting whole drivers implicitly isn't a good idea. This can
grow out of control very quickly.

Regards,

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
