From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 2/2] omap: iommu-add functionality to get TLB miss
 interrupt
Date: Fri, 21 May 2010 08:45:14 +0300 (EEST)
Message-ID: <20100521.084514.48503626.Hiroshi.DOYU@nokia.com>
References: <1274389823-4051-1-git-send-email-h-kanigeri2@ti.com>
	<1274389823-4051-3-git-send-email-h-kanigeri2@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:31504 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754476Ab0EUFpe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 May 2010 01:45:34 -0400
In-Reply-To: <1274389823-4051-3-git-send-email-h-kanigeri2@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: h-kanigeri2@ti.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com, grgupta@ti.com

Hi Hari,

From: ext Hari Kanigeri <h-kanigeri2@ti.com>
Subject: [PATCH 2/2] omap: iommu-add functionality to get TLB miss interrupt
Date: Thu, 20 May 2010 23:10:23 +0200

> In order to enable TLB miss interrupt, the TWL should be
> disabled. This patch provides the functionality to get the
> MMU fault interrupt for a TLB miss in the cases where the
> users are working with the locked TLB entries and with TWL
> disabled.
> New interface is added to select twl and to enable TLB miss
> interrupt.
> 
> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> Signed-off-by: Ramesh Gupta <grgupta@ti.com>
> Signed-off-by: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>
> ---
>  arch/arm/mach-omap2/iommu2.c            |   26 +++++++++++++++++++++-----
>  arch/arm/plat-omap/include/plat/iommu.h |    2 ++
>  arch/arm/plat-omap/iommu.c              |   17 +++++++++++++++++
>  3 files changed, 40 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
> index ebbdae2..3cfe1c4 100644
> --- a/arch/arm/mach-omap2/iommu2.c
> +++ b/arch/arm/mach-omap2/iommu2.c
> @@ -65,6 +65,25 @@
>  	 ((pgsz) == MMU_CAM_PGSZ_64K) ? 0xffff0000 :	\
>  	 ((pgsz) == MMU_CAM_PGSZ_4K)  ? 0xfffff000 : 0)
>  
> +
> +static void omap2_iommu_set_twl(struct iommu *obj, bool on)
> +{
> +	u32 l = iommu_read_reg(obj, MMU_CNTL);
> +
> +	if (on)
> +		iommu_write_reg(obj, MMU_IRQ_TWL_MASK, MMU_IRQENABLE);
> +	else
> +		iommu_write_reg(obj, MMU_IRQ_TLB_MISS_MASK, MMU_IRQENABLE);
> +
> +	l &= ~MMU_CNTL_MASK;
> +	if (on)
> +		l |= (MMU_CNTL_MMU_EN | MMU_CNTL_TWL_EN);
> +	else
> +		l |= (MMU_CNTL_MMU_EN);
> +
> +	iommu_write_reg(obj, l, MMU_CNTL);
> +}
> +
>  static int omap2_iommu_enable(struct iommu *obj)
>  {
>  	u32 l, pa;
> @@ -100,13 +119,9 @@ static int omap2_iommu_enable(struct iommu *obj)
>  	l |= (MMU_SYS_IDLE_SMART | MMU_SYS_AUTOIDLE);
>  	iommu_write_reg(obj, l, MMU_SYSCONFIG);
>  
> -	iommu_write_reg(obj, MMU_IRQ_TWL_MASK, MMU_IRQENABLE);
>  	iommu_write_reg(obj, pa, MMU_TTB);
>  
> -	l = iommu_read_reg(obj, MMU_CNTL);
> -	l &= ~MMU_CNTL_MASK;
> -	l |= (MMU_CNTL_MMU_EN | MMU_CNTL_TWL_EN);
> -	iommu_write_reg(obj, l, MMU_CNTL);
> +	omap2_iommu_set_twl(obj, true);
>  
>  	return 0;
>  }

nitpick: The function prefix "omap2_iommu_" are used to indicate that
this prefixed function belongs to "omap2_iommu_ops" to provide iommu
basic functionalities for the above layer. It's better to avoid to use
the prefixed function in the same prefixed ones, IOW, nested like
above, where "omap2_iommu_enable()" calls "omap2_iommu_set_twl()"
internally. It's can be considered as a violation of layer? Same to
"omap2_iommu_disable()".

> @@ -304,6 +319,7 @@ static const struct iommu_functions omap2_iommu_ops = {
>  
>  	.enable		= omap2_iommu_enable,
>  	.disable	= omap2_iommu_disable,
> +	.set_twl	= omap2_iommu_set_twl,
>  	.fault_isr	= omap2_iommu_fault_isr,
>  
>  	.tlb_read_cr	= omap2_tlb_read_cr,
> diff --git a/arch/arm/plat-omap/include/plat/iommu.h b/arch/arm/plat-omap/include/plat/iommu.h
> index 0752af9..33c7d41 100644
> --- a/arch/arm/plat-omap/include/plat/iommu.h
> +++ b/arch/arm/plat-omap/include/plat/iommu.h
> @@ -80,6 +80,7 @@ struct iommu_functions {
>  
>  	int (*enable)(struct iommu *obj);
>  	void (*disable)(struct iommu *obj);
> +	void (*set_twl)(struct iommu *obj, bool on);
>  	u32 (*fault_isr)(struct iommu *obj, u32 *ra);

This could be like the following, which also keeps the order of the
above "struct iommu_functions".

	Modified arch/arm/mach-omap2/iommu2.c
diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
index 3cfe1c4..c87f662 100644
--- a/arch/arm/mach-omap2/iommu2.c
+++ b/arch/arm/mach-omap2/iommu2.c
@@ -66,7 +66,7 @@
 	 ((pgsz) == MMU_CAM_PGSZ_4K)  ? 0xfffff000 : 0)
 
 
-static void omap2_iommu_set_twl(struct iommu *obj, bool on)
+static void __iommu_set_twl(struct iommu *obj, bool on)
 {
 	u32 l = iommu_read_reg(obj, MMU_CNTL);
 
@@ -121,7 +121,7 @@ static int omap2_iommu_enable(struct iommu *obj)
 
 	iommu_write_reg(obj, pa, MMU_TTB);
 
-	omap2_iommu_set_twl(obj, true);
+	__iommu_set_twl(obj, true);
 
 	return 0;
 }
@@ -137,6 +137,11 @@ static void omap2_iommu_disable(struct iommu *obj)
 	dev_dbg(obj->dev, "%s is shutting down\n", obj->name);
 }
 
+static void omap2_iommu_set_twl(struct iommu *obj, bool on)
+{
+	__iommu_set_twl(obj, on);
+}
+
 static u32 omap2_iommu_fault_isr(struct iommu *obj, u32 *ra)
 {
 	int i;
