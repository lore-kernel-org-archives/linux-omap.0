From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 2/2] omap: iommu-add functionality to get TLB miss
 interrupt
Date: Fri, 21 May 2010 12:21:18 +0300 (EEST)
Message-ID: <20100521.122118.179931081.Hiroshi.DOYU@nokia.com>
References: <1274389823-4051-1-git-send-email-h-kanigeri2@ti.com>
	<1274389823-4051-3-git-send-email-h-kanigeri2@ti.com>
	<20100521.084514.48503626.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Fri_May_21_12_21_18_2010_599)--"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:53147 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280Ab0EUJWF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 May 2010 05:22:05 -0400
In-Reply-To: <20100521.084514.48503626.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: h-kanigeri2@ti.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com, grgupta@ti.com

----Next_Part(Fri_May_21_12_21_18_2010_599)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 2/2] omap: iommu-add functionality to get TLB miss interrupt
Date: Fri, 21 May 2010 08:45:14 +0300 (EEST)

> Hi Hari,
> 
> From: ext Hari Kanigeri <h-kanigeri2@ti.com>
> Subject: [PATCH 2/2] omap: iommu-add functionality to get TLB miss interrupt
> Date: Thu, 20 May 2010 23:10:23 +0200
> 
>> In order to enable TLB miss interrupt, the TWL should be
>> disabled. This patch provides the functionality to get the
>> MMU fault interrupt for a TLB miss in the cases where the
>> users are working with the locked TLB entries and with TWL
>> disabled.
>> New interface is added to select twl and to enable TLB miss
>> interrupt.
>> 
>> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
>> Signed-off-by: Ramesh Gupta <grgupta@ti.com>
>> Signed-off-by: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>
>> ---
>>  arch/arm/mach-omap2/iommu2.c            |   26 +++++++++++++++++++++-----
>>  arch/arm/plat-omap/include/plat/iommu.h |    2 ++
>>  arch/arm/plat-omap/iommu.c              |   17 +++++++++++++++++
>>  3 files changed, 40 insertions(+), 5 deletions(-)
>> 
>> diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
>> index ebbdae2..3cfe1c4 100644
>> --- a/arch/arm/mach-omap2/iommu2.c
>> +++ b/arch/arm/mach-omap2/iommu2.c
>> @@ -65,6 +65,25 @@
>>  	 ((pgsz) == MMU_CAM_PGSZ_64K) ? 0xffff0000 :	\
>>  	 ((pgsz) == MMU_CAM_PGSZ_4K)  ? 0xfffff000 : 0)
>>  
>> +
>> +static void omap2_iommu_set_twl(struct iommu *obj, bool on)
>> +{
>> +	u32 l = iommu_read_reg(obj, MMU_CNTL);
>> +
>> +	if (on)
>> +		iommu_write_reg(obj, MMU_IRQ_TWL_MASK, MMU_IRQENABLE);
>> +	else
>> +		iommu_write_reg(obj, MMU_IRQ_TLB_MISS_MASK, MMU_IRQENABLE);
>> +
>> +	l &= ~MMU_CNTL_MASK;
>> +	if (on)
>> +		l |= (MMU_CNTL_MMU_EN | MMU_CNTL_TWL_EN);
>> +	else
>> +		l |= (MMU_CNTL_MMU_EN);
>> +
>> +	iommu_write_reg(obj, l, MMU_CNTL);
>> +}
>> +
>>  static int omap2_iommu_enable(struct iommu *obj)
>>  {
>>  	u32 l, pa;
>> @@ -100,13 +119,9 @@ static int omap2_iommu_enable(struct iommu *obj)
>>  	l |= (MMU_SYS_IDLE_SMART | MMU_SYS_AUTOIDLE);
>>  	iommu_write_reg(obj, l, MMU_SYSCONFIG);
>>  
>> -	iommu_write_reg(obj, MMU_IRQ_TWL_MASK, MMU_IRQENABLE);
>>  	iommu_write_reg(obj, pa, MMU_TTB);
>>  
>> -	l = iommu_read_reg(obj, MMU_CNTL);
>> -	l &= ~MMU_CNTL_MASK;
>> -	l |= (MMU_CNTL_MMU_EN | MMU_CNTL_TWL_EN);
>> -	iommu_write_reg(obj, l, MMU_CNTL);
>> +	omap2_iommu_set_twl(obj, true);
>>  
>>  	return 0;
>>  }
> 
> nitpick: The function prefix "omap2_iommu_" are used to indicate that
> this prefixed function belongs to "omap2_iommu_ops" to provide iommu
> basic functionalities for the above layer. It's better to avoid to use
> the prefixed function in the same prefixed ones, IOW, nested like
> above, where "omap2_iommu_enable()" calls "omap2_iommu_set_twl()"
> internally. It's can be considered as a violation of layer? Same to
> "omap2_iommu_disable()".

For the case of "omap2_iommu_disable()", I attached the fix.

----Next_Part(Fri_May_21_12_21_18_2010_599)--
Content-Type: Text/X-Patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-omap-iommu-move-iommu_disable-at-fault-to-the-above-.patch"

>From 47994f0cb3ea3b3846f3b92bc9ab16f82d112d0b Mon Sep 17 00:00:00 2001
From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Date: Fri, 21 May 2010 12:17:32 +0300
Subject: [PATCH 1/1] omap iommu: move iommu_disable at fault to the above layer

The function prefix "omap2_iommu_" indicates that the prefixed
function belongs to "omap2_iommu_ops" to provide iommu basic
functionalities for the above layers. It's better to avoid the
prefixed function called in the same prefixed ones internally, like
nested here. Now "iommu_disable" is called just after fault_isr() in
the above layer. This is a little bit more sensible to keep the
consistency of module layers.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/mach-omap2/iommu2.c |    2 +-
 arch/arm/plat-omap/iommu.c   |    2 ++
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
index ebbdae2..bcd816e 100644
--- a/arch/arm/mach-omap2/iommu2.c
+++ b/arch/arm/mach-omap2/iommu2.c
@@ -151,7 +151,7 @@ static u32 omap2_iommu_fault_isr(struct iommu *obj, u32 *ra)
 	printk("\n");
 
 	iommu_write_reg(obj, stat, MMU_IRQSTATUS);
-	omap2_iommu_disable(obj);
+
 	return stat;
 }
 
diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
index 3381070..7245de4 100644
--- a/arch/arm/plat-omap/iommu.c
+++ b/arch/arm/plat-omap/iommu.c
@@ -783,6 +783,8 @@ static irqreturn_t iommu_fault_handler(int irq, void *data)
 	if (!stat)
 		return IRQ_HANDLED;
 
+	iommu_disable(obj);
+
 	iopgd = iopgd_offset(obj, da);
 
 	if (!iopgd_is_table(*iopgd)) {
-- 
1.7.1.rc1


----Next_Part(Fri_May_21_12_21_18_2010_599)----
