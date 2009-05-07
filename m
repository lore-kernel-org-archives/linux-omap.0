From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 2/6] omap iommu: omap2 architecture specific functions
Date: Thu, 7 May 2009 09:40:35 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E2AE47A12@dlee03.ent.ti.com>
References: <20090505123905.4583.69865.stgit@oreo.research.nokia.com>
	<20090505124655.4583.73497.stgit@oreo.research.nokia.com>
	<8F7AF80515AF0D4D93307E594F3CB40E2AE46FB2@dlee03.ent.ti.com>
 <20090507.081259.233680638.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50271 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752918AbZEGOlF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 May 2009 10:41:05 -0400
In-Reply-To: <20090507.081259.233680638.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "sakari.ailus@maxwell.research.nokia.com" <sakari.ailus@maxwell.research.nokia.com>, "tony@atomide.com" <tony@atomide.com>, "Pasam, Vijay" <vpasam@ti.com>

Hi,

> +static irqreturn_t iommu_fault_handler(int irq, void *data)
> +{
> +       u32 stat, da;
> +       u32 *iopgd, *iopte;
> +       int err = -EIO;
> +       struct iommu *obj = data;
> +
> +       if (!obj->refcount)
> +               return IRQ_NONE;
> +
> +       /* Dynamic loading TLB or PTE */
> +       if (obj->isr)
> +               err = obj->isr(obj);
> 		      ^^^^^^^^^^^^^^
> 
> If the above "isr" function sets a new "tlb" or "pte" entry, then
> further iommu fault won't happen anymore.
>

-- I think adding the new tlb entry or any other error recovery mechanism should be deferred to the registered callback function. 

Thank you,
Best regards,
Hari
