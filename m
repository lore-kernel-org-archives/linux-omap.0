From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 08/10] ARM: OMAP5: hwmod data: Create initial OMAP5 SOC
 hwmod data
Date: Mon, 21 Jan 2013 20:36:59 +0530
Message-ID: <50FD5993.5010008@ti.com>
References: <1358522856-12180-1-git-send-email-santosh.shilimkar@ti.com> <1358522856-12180-9-git-send-email-santosh.shilimkar@ti.com> <20130118171500.GC15361@atomide.com> <50FCF838.6000105@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40012 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752428Ab3AUPGD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Jan 2013 10:06:03 -0500
In-Reply-To: <50FCF838.6000105@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mturquette@linaro.org, rnayak@ti.com, b-cousson@ti.com, Paul Walmsley <paul@pwsan.com>

On Monday 21 January 2013 01:41 PM, Santosh Shilimkar wrote:
> On Friday 18 January 2013 10:45 PM, Tony Lindgren wrote:
>> Hi,
>>
>> * Santosh Shilimkar <santosh.shilimkar@ti.com> [130118 07:30]:
>>> From: Benoit Cousson <b-cousson@ti.com>
>>>
>>> Adding the hwmod data for OMAP54xx platforms.
>>> --- /dev/null
>>> +++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
>>> +/* bb2d */
>>> +static struct omap_hwmod_irq_info omap54xx_bb2d_irqs[] = {
>>> +    { .irq = 125 + OMAP54XX_IRQ_GIC_START },
>>> +    { .irq = -1 }
>>> +};
>> ...
>>
>>> +/* c2c */
>>> +static struct omap_hwmod_irq_info omap54xx_c2c_irqs[] = {
>>> +    { .irq = 88 + OMAP54XX_IRQ_GIC_START },
>>> +    { .irq = -1 }
>>> +};
>> ...
>>
>>
>>> +static struct omap_hwmod_dma_info omap54xx_c2c_sdma_reqs[] = {
>>> +    { .dma_req = 68 + OMAP54XX_DMA_REQ_START },
>>> +    { .dma_req = -1 }
>>> +};
>>
>>
>>
>>> +static struct omap_hwmod_addr_space omap54xx_elm_addrs[] = {
>>> +    {
>>> +        .pa_start    = 0x48078000,
>>> +        .pa_end        = 0x48078fff,
>>> +        .flags        = ADDR_TYPE_RT
>>> +    },
>>> +    { }
>>> +};
>> ...
>>
>>> +static struct omap_hwmod_addr_space omap54xx_emif1_addrs[] = {
>>> +    {
>>> +        .pa_start    = 0x4c000000,
>>> +        .pa_end        = 0x4c0003ff,
>>> +        .flags        = ADDR_TYPE_RT
>>> +    },
>>> +    { }
>>> +};
>>
>> As discussed earlier on this list, let's not duplicate the standard
>> resources here as they already are supposed to come from device tree.
>>
>> Whatever issues prevent us from dropping the duplicate data here need
>> to be fixed. I believe Benoit already had some scripts/patches for
>> that and was just waiting for the DMA binding to get merged?
>>
> Will have a loot at it. DMA binding pull request narrowly missed
> 3.8 but should get into 3.9.
>
So I looked at this one with help of Rajendra. We can get rid of the
IRQ and DMA data(needs DMA biding updates) easily. The address
space though is needed since hwmod code uses it to setup the
sysconfig registers.

Extracting that from DT code seems to be really expensive and
ugly [1]. I am yet to try out DMA lines removal but that seems
to be doable by pulling Vinod'd DMA engine branch and updating
DT file.

Whats your suggestion on address space part ?

Regards,
Santosh

[1] HACK address extraction with DT.

---
  arch/arm/mach-omap2/omap_hwmod.c |   31 +++++++++++++++++++++++++++----
  1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c 
b/arch/arm/mach-omap2/omap_hwmod.c
index 4653efb..f54b9d4 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -138,6 +138,7 @@
  #include <linux/spinlock.h>
  #include <linux/slab.h>
  #include <linux/bootmem.h>
+#include <linux/of.h>

  #include "clock.h"
  #include "omap_hwmod.h"
@@ -2335,7 +2336,12 @@ static int _shutdown(struct omap_hwmod *oh)
  static void __init _init_mpu_rt_base(struct omap_hwmod *oh, void *data)
  {
  	struct omap_hwmod_addr_space *mem;
-	void __iomem *va_start;
+	void __iomem *va_start = NULL;
+	struct device_node *np;
+	unsigned long start = 0, size = 0;
+	const void *reg_prop;
+	const char *p;
+

  	if (!oh)
  		return;
@@ -2349,15 +2355,32 @@ static void __init _init_mpu_rt_base(struct 
omap_hwmod *oh, void *data)
  	if (!mem) {
  		pr_debug("omap_hwmod: %s: no MPU register target found\n",
  			 oh->name);
-		return;
+		/*Check in Device Tree blob*/
+		for_each_child_of_node(of_find_node_by_name(NULL, "ocp"), np) {
+			printk("np-name=%s\n", np->name);
+			if(of_find_property(np, "ti,hwmods", NULL)) {
+				p = of_get_property(np, "ti,hwmods", NULL);
+				if (!strcmp(p, oh->name)) {
+				reg_prop = of_get_property(np, "reg", NULL);
+				start = of_read_number(reg_prop, 1);
+				size = of_read_number(reg_prop + 4, 1);
+				}
+			}
+		}
+	} else {
+		start = mem->pa_start;
+		size = mem->pa_end - mem->pa_start;
  	}

-	va_start = ioremap(mem->pa_start, mem->pa_end - mem->pa_start);
+	if (!start)
+		return;
+
+	va_start = ioremap(start, size);
  	if (!va_start) {
  		pr_err("omap_hwmod: %s: Could not ioremap\n", oh->name);
  		return;
  	}
-
+	
  	pr_debug("omap_hwmod: %s: MPU register target at va %p\n",
  		 oh->name, va_start);

-- 
1.7.9.5




