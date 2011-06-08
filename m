From: "Roedel, Joerg" <Joerg.Roedel@amd.com>
Subject: Re: [PATCH 0/4] drivers/iommu/ relocations
Date: Wed, 8 Jun 2011 15:35:55 +0200
Message-ID: <20110608133555.GC21591@amd.com>
References: <1307522062-19273-1-git-send-email-ohad@wizery.com>
 <20110608130522.GC29089@parisc-linux.org>
 <BANLkTin5JYt4=gru181N_BuvnHB7kUTUeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <BANLkTin5JYt4=gru181N_BuvnHB7kUTUeQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Matthew Wilcox <matthew@wil.cx>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, David Brown <davidb@codeaurora.org>, David Woodhouse <dwmw2@infradead.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 08, 2011 at 09:11:16AM -0400, Ohad Ben-Cohen wrote:
> On Wed, Jun 8, 2011 at 4:05 PM, Matthew Wilcox <matthew@wil.cx> wrote:
> > You've missed at least parisc, ia64, alpha, sparc, powerpc and sh which
> > have IOMMUs.
> 
> None of these seem to call register_iommu.
> 
> > Not that they necessarily all need to be moved across in
> > one patchset, but saying "all iommu drivers" is clearly false.
> 
> I've moved only the existing IOMMU API users.

And I think that is good for now. The iommu-api needs to be extended to
cover all kinds of iommus (like the iommus available on other
architectures). It is definitly the plan to do that and have a common
dma_ops implementation for all of them. But lets start small by now and
move forward step by step :-)

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
