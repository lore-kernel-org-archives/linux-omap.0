From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 05/24] omap4: Add needed IRQ line into irqs.h
Date: Wed, 17 Feb 2010 10:31:03 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C3CF826A@dbde02.ent.ti.com>
References: <1266335895-32741-1-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-2-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-3-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-4-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-5-git-send-email-santosh.shilimkar@ti.com>
 <alpine.DEB.2.00.1002161506030.10478@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53589 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750702Ab0BQFB0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Feb 2010 00:01:26 -0500
In-Reply-To: <alpine.DEB.2.00.1002161506030.10478@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "ben@fluff.org.uk" <ben@fluff.org.uk>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "Cousson, Benoit" <b-cousson@ti.com>

Paul,
> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Wednesday, February 17, 2010 3:39 AM
> To: Shilimkar, Santosh
> Cc: tony@atomide.com; linux-omap@vger.kernel.org; ben@fluff.org.uk; sameo@linux.intel.com;
> lrg@slimlogic.co.uk
> Subject: Re: [PATCH 05/24] omap4: Add needed IRQ line into irqs.h
> 
> Hello Santosh,
> 
> On Tue, 16 Feb 2010, Santosh Shilimkar wrote:
> 
> > This patch adds DSS, keyboard and ducati irq
> > entries in irqs.h
> >
> > Ones omap4 hwmod is pushed on mainlie, all the
> > irqs lines data would be availabe.
> 
> Instead of this patch, why not just replace the current file with the one
> from the OMAP4 autogeneration scripts?  I don't see why the IRQ macros
> should depend on hwmod availability, and it would be better to have the
> correct IRQ data appear in one patch, rather than having to review and
> approve several smaller incremental patches over time.
We plan to do this but today the autogenrated file names and one in the 
kernel code is different. Autogenrated headers are kept in alignment
with TRM naming as you know.
e.g
--- autogenaretd
#define OMAP44XX_IRQ_MCBSP2   (22 + OMAP44XX_IRQ_GIC_START) 

--existing kernel
#define INT_44XX_MCBSP2_IRQ	(22 + IRQ_GIC_START)


So instead of touching every driver file and changing it only for name changes ,
what we are doing
1. Created local 44xx_dma.h and 44xx_irq.h mach-omap2 directory
2. All the drivers getting converted in hwmods would use defines from above headers
3. At one point of time all the drivers would use defines from above headers and then 
   from omap4 point of view there won't be dependency on the irqs.h and dma.h

While this is ongoing, we would like the mainline kernel to have most of the 
drivers supported. And Hence such a patch.
 
> The same reasoning should apply the DMA data also, I'd think.
DMA file will get replaced soon with auto generated since naming
is aligned there.


Regards,
Santosh
