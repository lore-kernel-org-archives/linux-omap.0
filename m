From: "Roedel, Joerg" <Joerg.Roedel@amd.com>
Subject: Re: [PATCH] iommu/omap: Fix build error with !IOMMU_SUPPORT
Date: Thu, 15 Sep 2011 12:45:24 +0200
Message-ID: <20110915104524.GY11701@amd.com>
References: <1316009259-18052-1-git-send-email-joerg.roedel@amd.com>
 <CAK=WgbbCgXjOQ=xXSwnVhT9sqsYtpo6cFcRQYSEGY2ow215n=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK=WgbbCgXjOQ=xXSwnVhT9sqsYtpo6cFcRQYSEGY2ow215n=Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 14, 2011 at 02:57:13PM -0400, Ohad Ben-Cohen wrote:
> On Wed, Sep 14, 2011 at 5:07 PM, Joerg Roedel <joerg.roedel@amd.com> wrote:
> > Without this patch it is possible to select the VIDEO_OMAP3
> > driver which then selects OMAP_IOVMM. But the omap iommu
> > driver is not compiled without IOMMU_SUPPORT enabled. Fix
> > that by forcing OMAP_IOMMU and OMAP_IOVMM are enabled before
> > VIDEO_OMAP3 can be selected.
> 
> I'm ok with this but wouldn't it be simpler if we drop IOMMU_SUPPORT
> altogether (and just use a plain menu instead) ?
> 
> Users will then be presented with only a single iommu-related
> question: whether they want their iommu driver built or not.

This doesn't work on platforms that may have more than one possible
iommu driver, like x86 for example.

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
