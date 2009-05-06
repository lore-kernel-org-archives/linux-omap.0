From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 2/6] omap iommu: omap2 architecture specific functions
Date: Wed, 6 May 2009 09:31:37 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E2AE46FB2@dlee03.ent.ti.com>
References: <20090505123905.4583.69865.stgit@oreo.research.nokia.com>
 <20090505124655.4583.73497.stgit@oreo.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50676 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758348AbZEFOcD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 May 2009 10:32:03 -0400
In-Reply-To: <20090505124655.4583.73497.stgit@oreo.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "sakari.ailus@maxwell.research.nokia.com" <sakari.ailus@maxwell.research.nokia.com>, "tony@atomide.com" <tony@atomide.com>, "Pasam, Vijay" <vpasam@ti.com>

Hi,

> +static u32 omap2_iommu_fault_isr(struct iommu *obj, u32 *ra)
> +{
> +	int i;
> +	u32 stat, da;
> +	const char *err_msg[] =	{
> +		"tlb miss",
> +		"translation fault",
> +		"emulation miss",
> +		"table walk fault",
> +		"multi hit fault",
> +	};
> +
> +	stat = iommu_read_reg(obj, MMU_IRQSTATUS);
> +	stat &= MMU_IRQ_MASK;
> +	if (!stat)
> +		return 0;
> +
> +	da = iommu_read_reg(obj, MMU_FAULT_AD);
> +	*ra = da;
> +
> +	dev_err(obj->dev, "%s:\tda:%08x ", __func__, da);
> +
> +	for (i = 0; i < ARRAY_SIZE(err_msg); i++) {
> +		if (stat & (1 << i))
> +			printk("%s ", err_msg[i]);
> +	}
> +	printk("\n");
> +
> +	iommu_write_reg(obj, stat, MMU_IRQSTATUS);
> +	return stat;
> +}
> +

-- I see you are acking the MMU fault in the ISR, but I don't think this will be enough to stop the further generation of MMU faults as the device will again try to access the same fault address. 

In the mean time before the callback mechanism is implemented, we should consider disabling the MMU for the device that caused the MMU fault to stop further generation of MMU faults.

+	printk("\n");
+
+	iommu_write_reg(obj, stat, MMU_IRQSTATUS);
+	omap2_iommu_disable(obj) -----------------------> [HK]
+	return stat;
+}

Thank you,
Best regards,
Hari
