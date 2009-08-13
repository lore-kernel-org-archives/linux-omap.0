From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: [PATCH v2 1/6] ARM: OMAP4: PM: Fix the PRM and CM base addresses
Date: Thu, 13 Aug 2009 13:48:44 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0306050809@dbde02.ent.ti.com>
References: <A24693684029E5489D1D202277BE89444A6ED4DB@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51730 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752732AbZHMITK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Aug 2009 04:19:10 -0400
In-Reply-To: <A24693684029E5489D1D202277BE89444A6ED4DB@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

 

>-----Original Message-----
>From: Aguirre Rodriguez, Sergio Alberto 
>Sent: Wednesday, August 12, 2009 9:15 PM
>To: Nayak, Rajendra; linux-arm-kernel@lists.arm.linux.org.uk
>Cc: linux-omap@vger.kernel.org; Nayak, Rajendra
>Subject: RE: [PATCH v2 1/6] ARM: OMAP4: PM: Fix the PRM and CM 
>base addresses
>
>Rajendra,
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Rajendra Nayak
>> Sent: Wednesday, August 12, 2009 9:27 AM
>> To: linux-arm-kernel@lists.arm.linux.org.uk
>> Cc: linux-omap@vger.kernel.org; Nayak, Rajendra
>> Subject: [PATCH v2 1/6] ARM: OMAP4: PM: Fix the PRM and CM 
>base addresses
>> 
>> This patch fixes the PRM and CM base addresses and adds
>> a new CM2 base address for OMAP4
>> 
>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>> ---
>>  arch/arm/mach-omap2/prcm.c                 |    2 ++
>>  arch/arm/plat-omap/common.c                |    2 ++
>>  arch/arm/plat-omap/include/mach/common.h   |    1 +
>>  arch/arm/plat-omap/include/mach/omap44xx.h |    6 ++++--
>>  4 files changed, 9 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
>> index f945156..de307fa 100644
>> --- a/arch/arm/mach-omap2/prcm.c
>> +++ b/arch/arm/mach-omap2/prcm.c
>> @@ -27,6 +27,7 @@
>> 
>>  static void __iomem *prm_base;
>>  static void __iomem *cm_base;
>> +static void __iomem *cm2_base;
>> 
>>  u32 omap_prcm_get_reset_sources(void)
>>  {
>> @@ -124,4 +125,5 @@ void __init 
>omap2_set_globals_prcm(struct omap_globals
>> *omap2_globals)
>>  {
>>  	prm_base = omap2_globals->prm;
>>  	cm_base = omap2_globals->cm;
>> +	cm2_base = omap2_globals->cm2;
>>  }
>> diff --git a/arch/arm/plat-omap/common.c 
>b/arch/arm/plat-omap/common.c
>> index ebcf006..e848a12 100644
>> --- a/arch/arm/plat-omap/common.c
>> +++ b/arch/arm/plat-omap/common.c
>> @@ -372,12 +372,14 @@ static struct omap_globals omap4_globals = {
>>  	.ctrl	= OMAP2_IO_ADDRESS(OMAP443X_CTRL_BASE),
>>  	.prm	= OMAP2_IO_ADDRESS(OMAP4430_PRM_BASE),
>>  	.cm	= OMAP2_IO_ADDRESS(OMAP4430_CM_BASE),
>> +	.cm2	= OMAP2_IO_ADDRESS(OMAP4430_CM2_BASE),
>>  };
>> 
>>  void __init omap2_set_globals_443x(void)
>>  {
>>  	omap2_set_globals_tap(&omap4_globals);
>>  	omap2_set_globals_control(&omap4_globals);
>> +	omap2_set_globals_prcm(&omap4_globals);
>>  }
>>  #endif
>> 
>> diff --git a/arch/arm/plat-omap/include/mach/common.h 
>b/arch/arm/plat-
>> omap/include/mach/common.h
>> index fdeab42..878c4f9 100644
>> --- a/arch/arm/plat-omap/include/mach/common.h
>> +++ b/arch/arm/plat-omap/include/mach/common.h
>> @@ -55,6 +55,7 @@ struct omap_globals {
>>  	void __iomem	*ctrl;		/* System Control Module */
>>  	void __iomem	*prm;		/* Power and Reset Management */
>>  	void __iomem	*cm;		/* Clock Management */
>> +	void __iomem	*cm2;
>>  };
>> 
>>  void omap2_set_globals_242x(void);
>> diff --git a/arch/arm/plat-omap/include/mach/omap44xx.h 
>b/arch/arm/plat-
>> omap/include/mach/omap44xx.h
>> index 15dec7f..b46b154 100644
>> --- a/arch/arm/plat-omap/include/mach/omap44xx.h
>> +++ b/arch/arm/plat-omap/include/mach/omap44xx.h
>> @@ -23,8 +23,10 @@
>>  #define L4_EMU_44XX_BASE		0x54000000
>>  #define L3_44XX_BASE			0x44000000
>>  #define OMAP4430_32KSYNCT_BASE		0x4a304000
>> -#define OMAP4430_CM_BASE		0x4a004000
>> -#define OMAP4430_PRM_BASE		0x48306000
>
>> +#define OMAP4430_CM1_BASE		0x4a004000
>> +#define OMAP4430_CM_BASE		OMAP4430_CM1_BASE
>
>Why do you need 2 defines for the same value?

Hi Sergio,
PRCM had just one CM module in OMAP2/3 and OMAP4 has
2 of them , CM1 and CM2. The older CM defines are now mapped to CM1
for OMAP4 and new ones created for CM2.

regards,
Rajendra
>
>Regards,
>Sergio
>
>> +#define OMAP4430_CM2_BASE		0x4a008000
>> +#define OMAP4430_PRM_BASE		0x4a306000
>>  #define OMAP44XX_GPMC_BASE		0x50000000
>>  #define OMAP443X_SCM_BASE		0x4a002000
>>  #define OMAP443X_CTRL_BASE		OMAP443X_SCM_BASE
>> --
>> 1.5.4.7
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe 
>linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>