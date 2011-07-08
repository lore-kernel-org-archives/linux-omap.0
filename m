From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v2 3/6] OMAP4: PRCM: OMAP4460 specific PRM and CM register
 bitshifts
Date: Fri, 08 Jul 2011 00:01:16 -0700
Message-ID: <4E16AB3C.7020007@ti.com>
References: <1309573826-10615-1-git-send-email-rnayak@ti.com> <1309573826-10615-2-git-send-email-rnayak@ti.com> <1309573826-10615-3-git-send-email-rnayak@ti.com> <1309573826-10615-4-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1107080029550.24181@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:34530 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752258Ab1GHHBV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 03:01:21 -0400
Received: by mail-pz0-f54.google.com with SMTP id 27so1648173pzk.41
        for <linux-omap@vger.kernel.org>; Fri, 08 Jul 2011 00:01:20 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1107080029550.24181@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>

Hi Paul,

On 7/7/2011 11:30 PM, Paul Walmsley wrote:
> Hi Rajendra
>
> On Sat, 2 Jul 2011, Rajendra Nayak wrote:
>
>> This patch adds additional register bitshifts for
>> registers added in OMAP4460 platform.
>>
>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>> Signed-off-by: Nishanth Menon<nm@ti.com>
>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>> Reviewed-by: Kevin Hilman<khilman@ti.com>
>
> Does this data come from the autogenerator scripts?

Yes, it does. But the patch is created by manually
diffing the 4430 and 4460 autogen script outputs.
That's because the autogen scripts cannot generate
data for multiple SoC's at once.

regards,
Rajendra
>
>
> - Paul
>
>> ---
>>   arch/arm/mach-omap2/cm-regbits-44xx.h  |   36 ++++++++++++++++++++++++++++++++
>>   arch/arm/mach-omap2/prm-regbits-44xx.h |    8 +++++++
>>   2 files changed, 44 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/cm-regbits-44xx.h b/arch/arm/mach-omap2/cm-regbits-44xx.h
>> index 5e96e7b..43a7c0f 100644
>> --- a/arch/arm/mach-omap2/cm-regbits-44xx.h
>> +++ b/arch/arm/mach-omap2/cm-regbits-44xx.h
>> @@ -101,6 +101,10 @@
>>   #define OMAP4430_CLKACTIVITY_CORE_DPLL_EMU_CLK_SHIFT		9
>>   #define OMAP4430_CLKACTIVITY_CORE_DPLL_EMU_CLK_MASK		(1<<  9)
>>
>> +/* Used by CM_L4CFG_CLKSTCTRL */
>> +#define OMAP4460_CLKACTIVITY_CORE_TS_GFCLK_SHIFT		9
>> +#define OMAP4460_CLKACTIVITY_CORE_TS_GFCLK_MASK			(1<<  9)
>> +
>>   /* Used by CM_CEFUSE_CLKSTCTRL */
>>   #define OMAP4430_CLKACTIVITY_CUST_EFUSE_SYS_CLK_SHIFT		9
>>   #define OMAP4430_CLKACTIVITY_CUST_EFUSE_SYS_CLK_MASK		(1<<  9)
>> @@ -401,6 +405,10 @@
>>   #define OMAP4430_CLKACTIVITY_WKUP_32K_GFCLK_SHIFT		11
>>   #define OMAP4430_CLKACTIVITY_WKUP_32K_GFCLK_MASK		(1<<  11)
>>
>> +/* Used by CM_WKUP_CLKSTCTRL */
>> +#define OMAP4460_CLKACTIVITY_WKUP_TS_GFCLK_SHIFT		13
>> +#define OMAP4460_CLKACTIVITY_WKUP_TS_GFCLK_MASK			(1<<  13)
>> +
>>   /*
>>    * Used by CM1_ABE_TIMER5_CLKCTRL, CM1_ABE_TIMER6_CLKCTRL,
>>    * CM1_ABE_TIMER7_CLKCTRL, CM1_ABE_TIMER8_CLKCTRL, CM_L3INIT_MMC1_CLKCTRL,
>> @@ -431,6 +439,10 @@
>>   #define OMAP4430_CLKSEL_60M_SHIFT				24
>>   #define OMAP4430_CLKSEL_60M_MASK				(1<<  24)
>>
>> +/* Used by CM_MPU_MPU_CLKCTRL */
>> +#define OMAP4460_CLKSEL_ABE_DIV_MODE_SHIFT			25
>> +#define OMAP4460_CLKSEL_ABE_DIV_MODE_MASK			(1<<  25)
>> +
>>   /* Used by CM1_ABE_AESS_CLKCTRL */
>>   #define OMAP4430_CLKSEL_AESS_FCLK_SHIFT				24
>>   #define OMAP4430_CLKSEL_AESS_FCLK_MASK				(1<<  24)
>> @@ -447,6 +459,10 @@
>>   #define OMAP4430_CLKSEL_DIV_SHIFT				24
>>   #define OMAP4430_CLKSEL_DIV_MASK				(1<<  24)
>>
>> +/* Used by CM_MPU_MPU_CLKCTRL */
>> +#define OMAP4460_CLKSEL_EMIF_DIV_MODE_SHIFT			24
>> +#define OMAP4460_CLKSEL_EMIF_DIV_MODE_MASK			(1<<  24)
>> +
>>   /* Used by CM_CAM_FDIF_CLKCTRL */
>>   #define OMAP4430_CLKSEL_FCLK_SHIFT				24
>>   #define OMAP4430_CLKSEL_FCLK_MASK				(0x3<<  24)
>> @@ -542,6 +558,14 @@
>>   #define OMAP4430_D2D_STATDEP_SHIFT				18
>>   #define OMAP4430_D2D_STATDEP_MASK				(1<<  18)
>>
>> +/* Used by CM_CLKSEL_DPLL_MPU */
>> +#define OMAP4460_DCC_COUNT_MAX_SHIFT				24
>> +#define OMAP4460_DCC_COUNT_MAX_MASK				(0xff<<  24)
>> +
>> +/* Used by CM_CLKSEL_DPLL_MPU */
>> +#define OMAP4460_DCC_EN_SHIFT					22
>> +#define OMAP4460_DCC_EN_MASK					(1<<  22)
>> +
>>   /*
>>    * Used by CM_SSC_DELTAMSTEP_DPLL_ABE, CM_SSC_DELTAMSTEP_DPLL_CORE,
>>    * CM_SSC_DELTAMSTEP_DPLL_DDRPHY, CM_SSC_DELTAMSTEP_DPLL_IVA,
>> @@ -551,6 +575,10 @@
>>   #define OMAP4430_DELTAMSTEP_SHIFT				0
>>   #define OMAP4430_DELTAMSTEP_MASK				(0xfffff<<  0)
>>
>> +/* Renamed from DELTAMSTEP Used by CM_SSC_DELTAMSTEP_DPLL_USB */
>> +#define OMAP4460_DELTAMSTEP_0_20_SHIFT				0
>> +#define OMAP4460_DELTAMSTEP_0_20_MASK				(0x1fffff<<  0)
>> +
>>   /* Used by CM_DLL_CTRL */
>>   #define OMAP4430_DLL_OVERRIDE_SHIFT				0
>>   #define OMAP4430_DLL_OVERRIDE_MASK				(1<<  0)
>> @@ -1079,6 +1107,10 @@
>>   #define OMAP4430_MODULEMODE_SHIFT				0
>>   #define OMAP4430_MODULEMODE_MASK				(0x3<<  0)
>>
>> +/* Used by CM_L4CFG_DYNAMICDEP */
>> +#define OMAP4460_MPU_DYNDEP_SHIFT				19
>> +#define OMAP4460_MPU_DYNDEP_MASK				(1<<  19)
>> +
>>   /* Used by CM_DSS_DSS_CLKCTRL */
>>   #define OMAP4430_OPTFCLKEN_48MHZ_CLK_SHIFT			9
>>   #define OMAP4430_OPTFCLKEN_48MHZ_CLK_MASK			(1<<  9)
>> @@ -1171,6 +1203,10 @@
>>   #define OMAP4430_OPTFCLKEN_SYS_CLK_SHIFT			10
>>   #define OMAP4430_OPTFCLKEN_SYS_CLK_MASK				(1<<  10)
>>
>> +/* Used by CM_WKUP_BANDGAP_CLKCTRL */
>> +#define OMAP4460_OPTFCLKEN_TS_FCLK_SHIFT			8
>> +#define OMAP4460_OPTFCLKEN_TS_FCLK_MASK				(1<<  8)
>> +
>>   /* Used by CM_DSS_DSS_CLKCTRL */
>>   #define OMAP4430_OPTFCLKEN_TV_CLK_SHIFT				11
>>   #define OMAP4430_OPTFCLKEN_TV_CLK_MASK				(1<<  11)
>> diff --git a/arch/arm/mach-omap2/prm-regbits-44xx.h b/arch/arm/mach-omap2/prm-regbits-44xx.h
>> index 9fd91d6..0b750cf 100644
>> --- a/arch/arm/mach-omap2/prm-regbits-44xx.h
>> +++ b/arch/arm/mach-omap2/prm-regbits-44xx.h
>> @@ -282,6 +282,14 @@
>>   #define OMAP4430_DUCATI_UNICACHE_STATEST_SHIFT				10
>>   #define OMAP4430_DUCATI_UNICACHE_STATEST_MASK				(0x3<<  10)
>>
>> +/* Used by PRM_DEVICE_OFF_CTRL */
>> +#define OMAP4460_EMIF1_OFFWKUP_DISABLE_SHIFT				8
>> +#define OMAP4460_EMIF1_OFFWKUP_DISABLE_MASK				(1<<  8)
>> +
>> +/* Used by PRM_DEVICE_OFF_CTRL */
>> +#define OMAP4460_EMIF2_OFFWKUP_DISABLE_SHIFT				9
>> +#define OMAP4460_EMIF2_OFFWKUP_DISABLE_MASK				(1<<  9)
>> +
>>   /* Used by RM_MPU_RSTST */
>>   #define OMAP4430_EMULATION_RST_SHIFT					0
>>   #define OMAP4430_EMULATION_RST_MASK					(1<<  0)
>> --
>> 1.7.4.1
>>
>
>
> - Paul

