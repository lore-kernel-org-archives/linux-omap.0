From: "Pedanekar, Hemant" <hemantp@ti.com>
Subject: RE: [PATCH v4 1/4] TI816X: Update common omap platform files
Date: Sat, 22 Jan 2011 07:40:23 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B036A8DB4B3@dbde02.ent.ti.com>
References: <1294677465-18658-1-git-send-email-hemantp@ti.com>
 <87oc79evo2.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40552 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754634Ab1AVCKg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Jan 2011 21:10:36 -0500
In-Reply-To: <87oc79evo2.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

Hi Kevin,

Hilman, Kevin wrote on Saturday, January 22, 2011 4:01 AM:

> Hi Hemant,
> 
> Hemant Pedanekar <hemantp@ti.com> writes:
> 
>> This patch updates the common platform files with TI816X support. Also
>> adds new files for TI816X module base addresses and irq definitions.
> [...]
> 
>> diff --git a/arch/arm/plat-omap/include/plat/irqs-ti816x.h
> b/arch/arm/plat-omap/include/plat/irqs-ti816x.h
>> new file mode 100644
>> index 0000000..3ec5d1b
[...]
>> +#define TI816X_IRQ_SECPUBINT	116
>> +#define TI816X_IRQ_SECSECINT	117
>> +#define TI816X_IRQ_SECPUBSWINT	118
>> +#define TI816X_IRQ_SECSECSWINT	119
>> +#define TI816X_IRQ_SMRFLX0	120
>> +#define TI816X_IRQ_SMRFLX1	121
>> +#define TI816X_IRQ_SYS_MMU	122
>> +#define TI816X_IRQ_MC_MMU	123
>> +#define TI816X_IRQ_DMM		124
>> +
>> +
>> +#endif
> 
> For new platforms, We don't need to have a list of all the
> IRQ numbers.
> 
> Driver code should always be getting IRQ numbers (and base addresses
> etc.) from struct resource/platform_data, which is populated
> from omap_hwmod.
>

Are you suggesting to get rid of this file altogether or the IRQs which 
may never be used from kernel be removed from this file (and added later
If needed)?
  
Or shall I add this file only in hwmod patch which will be submitted later?

[...]
>> diff --git a/arch/arm/plat-omap/include/plat/serial.h
> b/arch/arm/plat-omap/include/plat/serial.h
>> index cec5d56..3c3c319 100644
>> --- a/arch/arm/plat-omap/include/plat/serial.h
>> +++ b/arch/arm/plat-omap/include/plat/serial.h
>> @@ -51,6 +51,11 @@
>>  #define OMAP4_UART3_BASE	0x48020000
>>  #define OMAP4_UART4_BASE	0x4806e000
>> 
>> +/* TI816X serial ports */
>> +#define TI816X_UART1_BASE	0x48020000
>> +#define TI816X_UART2_BASE	0x48022000
>> +#define TI816X_UART3_BASE	0x48024000
> 
>>  /* External port on Zoom2/3 */
>>  #define ZOOM_UART_BASE		0x10000000
>>  #define ZOOM_UART_VIRT		0xfa400000
>> diff --git a/arch/arm/plat-omap/include/plat/ti816x.h
> b/arch/arm/plat-omap/include/plat/ti816x.h
>> new file mode 100644
>> index 0000000..f1729f7
>> --- /dev/null
>> +++ b/arch/arm/plat-omap/include/plat/ti816x.h
>> @@ -0,0 +1,31 @@
[...]
>> +
>> +#define L3_TI816X_BASE		0x44000000
>> +#define L4_FAST_TI816X_BASE	0x4a000000
>> +#define L4_SLOW_TI816X_BASE	0x48000000
>> +
>> +#define TI816X_SCM_BASE		0x48140000
>> +#define TI816X_CTRL_BASE	TI816X_SCM_BASE
>> +#define TI816X_PRCM_BASE	0x48180000
>> +
>> +#define TI816X_ARM_INTC_BASE	0x48200000
>> +
>> +#define TI816X_GPMC_BASE	0x50000000
>> +
>> +#endif /* __ASM_ARCH_TI816X_H */
> 
> All of these fall into the "not used in this patch" category.
> 
> It is best to add these defines in the patches where they are used so
> reviewers can see the usage and/or the need.
> 
> With all of these defines, the subject for this patch should probably
> just be about adding the SoC detection infrastructure.
>
> Thanks,
> 
> Kevin

Okay, I will remove some of the unused defs (like GPMC_BASE) and reorganize
The patches to have files in correct groups.

Thanks.
   Hemant
 

