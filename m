From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 2/6] omap iommu: omap2 architecture specific functions
Date: Thu, 07 May 2009 08:12:59 +0300 (EEST)
Message-ID: <20090507.081259.233680638.Hiroshi.DOYU@nokia.com>
References: <20090505123905.4583.69865.stgit@oreo.research.nokia.com>
	<20090505124655.4583.73497.stgit@oreo.research.nokia.com>
	<8F7AF80515AF0D4D93307E594F3CB40E2AE46FB2@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:60292 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991AbZEGFNV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 May 2009 01:13:21 -0400
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E2AE46FB2@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: h-kanigeri2@ti.com
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, omar.ramirez@ti.com, sakari.ailus@maxwell.research.nokia.com, tony@atomide.com, vpasam@ti.com

From: "ext Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 2/6] omap iommu: omap2 architecture specific functions
Date: Wed, 6 May 2009 16:31:37 +0200

> Hi,
> 
> > +static u32 omap2_iommu_fault_isr(struct iommu *obj, u32 *ra)
> > +{
> > +	int i;
> > +	u32 stat, da;
> > +	const char *err_msg[] =	{
> > +		"tlb miss",
> > +		"translation fault",
> > +		"emulation miss",
> > +		"table walk fault",
> > +		"multi hit fault",
> > +	};
> > +
> > +	stat = iommu_read_reg(obj, MMU_IRQSTATUS);
> > +	stat &= MMU_IRQ_MASK;
> > +	if (!stat)
> > +		return 0;
> > +
> > +	da = iommu_read_reg(obj, MMU_FAULT_AD);
> > +	*ra = da;
> > +
> > +	dev_err(obj->dev, "%s:\tda:%08x ", __func__, da);
> > +
> > +	for (i = 0; i < ARRAY_SIZE(err_msg); i++) {
> > +		if (stat & (1 << i))
> > +			printk("%s ", err_msg[i]);
> > +	}
> > +	printk("\n");
> > +
> > +	iommu_write_reg(obj, stat, MMU_IRQSTATUS);
> > +	return stat;
> > +}
> > +
> 
> -- I see you are acking the MMU fault in the ISR, but I don't think
> this will be enough to stop the further generation of MMU faults as
> the device will again try to access the same fault address. 

My idea is that, an iommu fault should be handled by a client
specific/provided callback function enough flexibly that it can handle
more complecated use cases like implementing on-demand dynamic memory
mapping at getting an iommu fault.

linux/arch/arm/plat-omap/iommu.c:

+static irqreturn_t iommu_fault_handler(int irq, void *data)
+{
+       u32 stat, da;
+       u32 *iopgd, *iopte;
+       int err = -EIO;
+       struct iommu *obj = data;
+
+       if (!obj->refcount)
+               return IRQ_NONE;
+
+       /* Dynamic loading TLB or PTE */
+       if (obj->isr)
+               err = obj->isr(obj);
		      ^^^^^^^^^^^^^^

If the above "isr" function sets a new "tlb" or "pte" entry, then
further iommu fault won't happen anymore.

> 
> In the mean time before the callback mechanism is implemented, we
> should consider disabling the MMU for the device that caused the MMU
> fault to stop further generation of MMU faults.
> 
> +	printk("\n");
> +
> +	iommu_write_reg(obj, stat, MMU_IRQSTATUS);
> +	omap2_iommu_disable(obj) -----------------------> [HK]
> +	return stat;
> +}

It's not bad idea at all to disable iommu temporary as a default
behavior, but maybe it should be done in the latter half of
"iommu_fault_handler()".

> 
> Thank you,
> Best regards,
> Hari
