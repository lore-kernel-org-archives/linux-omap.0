From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 2/2] omap: iommu-add functionality to get TLB miss
 interrupt
Date: Tue, 18 May 2010 09:11:30 +0300 (EEST)
Message-ID: <20100518.091130.260105572.Hiroshi.DOYU@nokia.com>
References: <1274137950-18759-1-git-send-email-h-kanigeri2@ti.com>
	<1274137950-18759-3-git-send-email-h-kanigeri2@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:20204 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754579Ab0ERGL6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 02:11:58 -0400
In-Reply-To: <1274137950-18759-3-git-send-email-h-kanigeri2@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: h-kanigeri2@ti.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com, grgupta@ti.com

Hi Hari,

From: ext Hari Kanigeri <h-kanigeri2@ti.com>
Subject: [PATCH 2/2] omap: iommu-add functionality to get TLB miss interrupt
Date: Tue, 18 May 2010 01:12:30 +0200

> In order to enable TLB miss interrupt, the TWL should be
> disabled. This patch provides the functionality to get the
> MMU fault interrupt for a TLB miss in the cases where the
> users are working with the locked TLB entries and with TWL
> disabled.

I want to keep leave the functionality to allow the locked TLB and
TWL enabled at the same time too. Is it still feasible with this?

> New interface is added to disable twl and enable TLB miss
> interrupt.
> 
> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> Signed-off-by: Ramesh Gupta <grgupta@ti.com>
> ---
>  arch/arm/mach-omap2/iommu2.c            |   13 +++++++++++++
>  arch/arm/plat-omap/include/plat/iommu.h |    2 ++
>  arch/arm/plat-omap/iommu.c              |   12 ++++++++++++
>  3 files changed, 27 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
> index fcf4f4a..2e78cea 100644
> --- a/arch/arm/mach-omap2/iommu2.c
> +++ b/arch/arm/mach-omap2/iommu2.c
> @@ -124,6 +124,18 @@ static void omap2_iommu_disable(struct iommu *obj)
>  	dev_dbg(obj->dev, "%s is shutting down\n", obj->name);
>  }
>  
> +static void omap2_iommu_disable_twl(struct iommu *obj)
> +{
> +       u32 l = iommu_read_reg(obj, MMU_CNTL);
> +
> +       l &= ~MMU_CNTL_MASK;
> +       l |= (MMU_CNTL_MMU_EN);
> +       iommu_write_reg(obj, l, MMU_CNTL);
> +
> +       /* Enable TLB miss interrupt */
> +       iommu_write_reg(obj, MMU_IRQ_TLB_MISS_MASK, MMU_IRQENABLE);
> +}
> +
>  static u32 omap2_iommu_fault_isr(struct iommu *obj, u32 *ra)
>  {
>  	int i;
> @@ -306,6 +318,7 @@ static const struct iommu_functions omap2_iommu_ops = {
>  
>  	.enable		= omap2_iommu_enable,
>  	.disable	= omap2_iommu_disable,
> +	.disable_twl    = omap2_iommu_disable_twl,
>  	.fault_isr	= omap2_iommu_fault_isr,
>  
>  	.tlb_read_cr	= omap2_tlb_read_cr,
> diff --git a/arch/arm/plat-omap/include/plat/iommu.h b/arch/arm/plat-omap/include/plat/iommu.h
> index 0752af9..52a3852 100644
> --- a/arch/arm/plat-omap/include/plat/iommu.h
> +++ b/arch/arm/plat-omap/include/plat/iommu.h
> @@ -80,6 +80,7 @@ struct iommu_functions {
>  
>  	int (*enable)(struct iommu *obj);
>  	void (*disable)(struct iommu *obj);
> +	void (*disable_twl)(struct iommu *obj);
>  	u32 (*fault_isr)(struct iommu *obj, u32 *ra);
>  
>  	void (*tlb_read_cr)(struct iommu *obj, struct cr_regs *cr);
> @@ -143,6 +144,7 @@ extern void iotlb_cr_to_e(struct cr_regs *cr, struct iotlb_entry *e);
>  extern u32 iotlb_cr_to_virt(struct cr_regs *cr);
>  
>  extern int load_iotlb_entry(struct iommu *obj, struct iotlb_entry *e);
> +extern void iommu_disable_twl(struct iommu *obj);
>  extern void flush_iotlb_page(struct iommu *obj, u32 da);
>  extern void flush_iotlb_range(struct iommu *obj, u32 start, u32 end);
>  extern void flush_iotlb_all(struct iommu *obj);
> diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
> index b2b3937..d64a4d8 100644
> --- a/arch/arm/plat-omap/iommu.c
> +++ b/arch/arm/plat-omap/iommu.c
> @@ -370,6 +370,18 @@ void flush_iotlb_all(struct iommu *obj)
>  }
>  EXPORT_SYMBOL_GPL(flush_iotlb_all);
>  
> +/**
> + * Call this function if working with locked TLB entries and
> + * TWL disabled
> + */

nitpick: It may be better to follow this for global func.

>From linux/Documentation/kernel-doc-nano-HOWTO.txt:
...
Example kernel-doc function comment:

/**
 * foobar() - short function description of foobar
 * @arg1:	Describe the first argument to foobar.
 * @arg2:	Describe the second argument to foobar.
 *		One can provide multiple line descriptions
 *		for arguments.
 *
 * A longer description, with more discussion of the function foobar()
 * that might be useful to those using or modifying it.  Begins with
 * empty comment line, and may include additional embedded empty
 * comment lines.
 *
 * The longer description can have multiple paragraphs.
 */


> +extern void iommu_disable_twl(struct iommu *obj)
 
extern?

> +{
> +	clk_enable(obj->clk);
> +	arch_iommu->disable_twl(obj);
> +	clk_disable(obj->clk);
> +}
> +EXPORT_SYMBOL_GPL(iommu_disable_twl);
> +
>  #if defined(CONFIG_OMAP_IOMMU_DEBUG_MODULE)
>  
>  ssize_t iommu_dump_ctx(struct iommu *obj, char *buf, ssize_t bytes)
> -- 
> 1.7.0
> 
