From: "Roedel, Joerg" <Joerg.Roedel@amd.com>
Subject: Re: [PATCH 4/4] x86: intel-iommu: move to drivers/iommu/
Date: Wed, 8 Jun 2011 11:38:01 +0200
Message-ID: <20110608093801.GH4407@amd.com>
References: <1307522062-19273-1-git-send-email-ohad@wizery.com>
 <1307522062-19273-5-git-send-email-ohad@wizery.com>
 <1307524659.4771.12.camel@i7.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ch1ehsobe001.messaging.microsoft.com ([216.32.181.181]:22179
	"EHLO CH1EHSOBE009.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752955Ab1FHJhp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Jun 2011 05:37:45 -0400
Content-Disposition: inline
In-Reply-To: <1307524659.4771.12.camel@i7.infradead.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, David Brown <davidb@codeaurora.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>

On Wed, Jun 08, 2011 at 05:17:38AM -0400, David Woodhouse wrote:
> On Wed, 2011-06-08 at 11:34 +0300, Ohad Ben-Cohen wrote:
> > --- a/drivers/pci/Makefile
> > +++ b/drivers/pci/Makefile
> > @@ -30,7 +30,7 @@ obj-$(CONFIG_PCI_MSI) += msi.o
> >  obj-$(CONFIG_HT_IRQ) += htirq.o
> >  
> >  # Build Intel IOMMU support
> > -obj-$(CONFIG_DMAR) += dmar.o iova.o intel-iommu.o
> > +obj-$(CONFIG_DMAR) += dmar.o iova.o
> >  
> >  obj-$(CONFIG_INTR_REMAP) += dmar.o intr_remapping.o
> >  
> 
> At least iova.o wants to go with it. That's one of the parts that is a
> candidate for harmonisation across IOMMU implementations, either by
> removing it or by having others use it too. It's how we allocate virtual
> I/O address space.
> 
> I suspect the interrupt remapping support may well want to move with it
> too. It's no more out-of-place in drivers/iommu than it is in
> drivers/pci. And then you can certainly move dmar.o too.

Interrupt remapping certainly makes sense too. I am not sure yet how to
generalize it because the AMD version of it is significantly different
from VT-d, but we'll see.

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632

