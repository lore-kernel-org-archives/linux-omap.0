From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 4/4] x86: intel-iommu: move to drivers/iommu/
Date: Wed, 08 Jun 2011 10:17:38 +0100
Message-ID: <1307524659.4771.12.camel@i7.infradead.org>
References: <1307522062-19273-1-git-send-email-ohad@wizery.com>
	 <1307522062-19273-5-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1307522062-19273-5-git-send-email-ohad@wizery.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Joerg Roedel <Joerg.Roedel@amd.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, David Brown <davidb@codeaurora.org>, iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, 2011-06-08 at 11:34 +0300, Ohad Ben-Cohen wrote:
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -30,7 +30,7 @@ obj-$(CONFIG_PCI_MSI) += msi.o
>  obj-$(CONFIG_HT_IRQ) += htirq.o
>  
>  # Build Intel IOMMU support
> -obj-$(CONFIG_DMAR) += dmar.o iova.o intel-iommu.o
> +obj-$(CONFIG_DMAR) += dmar.o iova.o
>  
>  obj-$(CONFIG_INTR_REMAP) += dmar.o intr_remapping.o
>  

At least iova.o wants to go with it. That's one of the parts that is a
candidate for harmonisation across IOMMU implementations, either by
removing it or by having others use it too. It's how we allocate virtual
I/O address space.

I suspect the interrupt remapping support may well want to move with it
too. It's no more out-of-place in drivers/iommu than it is in
drivers/pci. And then you can certainly move dmar.o too.

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation
