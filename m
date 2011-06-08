From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH 0/4] drivers/iommu/ relocations
Date: Wed, 8 Jun 2011 07:05:22 -0600
Message-ID: <20110608130522.GC29089@parisc-linux.org>
References: <1307522062-19273-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1307522062-19273-1-git-send-email-ohad@wizery.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Joerg Roedel <Joerg.Roedel@amd.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, David Brown <davidb@codeaurora.org>, David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 08, 2011 at 11:34:18AM +0300, Ohad Ben-Cohen wrote:
> Create a dedicated iommu drivers folder, put the base iommu code there,
> and move the existing IOMMU API users as well (msm-iommu, amd_iommu and
> intel-iommu).
> 
> Putting all iommu drivers together will ease finding similarities
> between different platforms, with the intention of solving problems once,
> in a generic framework, which everyone can use.
> 
> OMAP's iommu will be moved too as soon as it's migrated.
> 
> For previous discussions on this, please see:
> https://lkml.org/lkml/2011/6/2/369
> 
> Ohad Ben-Cohen (4):
>   drivers: iommu: move to a dedicated folder
>   msm: iommu: move to drivers/iommu/
>   x86: amd_iommu: move to drivers/iommu/
>   x86: intel-iommu: move to drivers/iommu/

You've missed at least parisc, ia64, alpha, sparc, powerpc and sh which
have IOMMUs.  Not that they necessarily all need to be moved across in
one patchset, but saying "all iommu drivers" is clearly false.

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
