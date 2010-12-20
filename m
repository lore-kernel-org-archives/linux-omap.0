From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH] OMAP: Fix configuration of J-Type DPLLs to work for OMAP3
 and OMAP4
Date: Mon, 20 Dec 2010 09:05:00 -0600
Message-ID: <4D0F709C.3010904@ti.com>
References: <1292617875-15662-1-git-send-email-jon-hunter@ti.com> <alpine.DEB.2.00.1012180304080.16875@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43536 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757740Ab0LTPFF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Dec 2010 10:05:05 -0500
In-Reply-To: <alpine.DEB.2.00.1012180304080.16875@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>

On 12/18/2010 4:08 AM, Paul Walmsley wrote:
> Hello Jon
>
> On Fri, 17 Dec 2010, Jon Hunter wrote:
>
>> From: Jon Hunter<jon-hunter@ti.com>
>>
>> J-Type DPLLs have additional configuration parameters that need to
>> be programmed when setting the multipler and divider for the DPLL.
>> These parameters being the sigma delta divider (SD_DIV) for the DPLL
>> and the digital controlled oscillator (DCO) to be used by the DPLL.
>>
>> The current code is implemented specifically to configure the
>> OMAP3630 PER J-Type DPLL. The OMAP4430 USB DPLL is also a J-Type DPLL
>> and so this code needs to be updated to work for both OMAP3 and OMAP4
>> devices and any other future devices that have J-TYPE DPLLs.
>>
>> For the OMAP3630 PER DPLL both the SD_DIV and DCO paramenters are
>> used but for the OMAP4430 USB DPLL only the SD_DIV field is used.
>> The current implementation will only program the SD_DIV and DCO
>> fields if the DPLL has both and hence this does not work for
>> OMAP4430.
>>
>> In order to make the code more generic add two new fields to the
>> dpll_data structure for the SD_DIV field and DCO field bit-masks
>> and only program these fields if the masks are defined for a specific
>> DPLL. This simplifies the code and allows us to remove the flag
>> DPLL_NO_DCO_SEL.
>
> Has this patch been tested on both OMAP36xx and OMAP4 ?

Yes, I performed a quick validation on both OMAP36xx Zoom3 and OMAP4 
Blaze to make sure the values are calculated correctly and I see the 
expected result in the register.

>> Signed-off-by: Jon Hunter<jon-hunter@ti.com>
>> ---
>>   arch/arm/mach-omap2/clock.h             |    1 -
>>   arch/arm/mach-omap2/clock3xxx_data.c    |    2 +
>>   arch/arm/mach-omap2/clock44xx_data.c    |    3 +-
>>   arch/arm/mach-omap2/dpll3xxx.c          |   53 +++++++++++++++++++-----------
>>   arch/arm/plat-omap/include/plat/clock.h |    5 ++-
>>   5 files changed, 40 insertions(+), 24 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
>> index a535c7a..896584e 100644
>> --- a/arch/arm/mach-omap2/clock.h
>> +++ b/arch/arm/mach-omap2/clock.h
>> @@ -49,7 +49,6 @@
>>
>>   /* DPLL Type and DCO Selection Flags */
>>   #define DPLL_J_TYPE		0x1
>> -#define DPLL_NO_DCO_SEL		0x2
>>
>>   int omap2_clk_enable(struct clk *clk);
>>   void omap2_clk_disable(struct clk *clk);
>> diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
>> index 0579604..461b1ca 100644
> Any reason why you're removing this comment?
>> --- a/arch/arm/mach-omap2/clock3xxx_data.c
>> +++ b/arch/arm/mach-omap2/clock3xxx_data.c
>> @@ -602,6 +602,8 @@ static struct dpll_data dpll4_dd_3630 __initdata = {
>>   	.autoidle_mask	= OMAP3430_AUTO_PERIPH_DPLL_MASK,
>>   	.idlest_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
>>   	.idlest_mask	= OMAP3430_ST_PERIPH_CLK_MASK,
>> +	.dco_mask	= OMAP3630_PERIPH_DPLL_DCO_SEL_MASK,
>> +	.sddiv_mask	= OMAP3630_PERIPH_DPLL_SD_DIV_MASK,
>>   	.max_multiplier = OMAP3630_MAX_JTYPE_DPLL_MULT,
>>   	.min_divider	= 1,
>>   	.max_divider	= OMAP3_MAX_DPLL_DIV,
>> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
>> index bfcd19f..cef179e 100644
>> --- a/arch/arm/mach-omap2/clock44xx_data.c
>> +++ b/arch/arm/mach-omap2/clock44xx_data.c
>> @@ -913,7 +913,7 @@ static struct clk usb_hs_clk_div_ck = {
>>   static struct dpll_data dpll_usb_dd = {
>>   	.mult_div1_reg	= OMAP4430_CM_CLKSEL_DPLL_USB,
>>   	.clk_bypass	=&usb_hs_clk_div_ck,
>> -	.flags		= DPLL_J_TYPE | DPLL_NO_DCO_SEL,
>> +	.flags		= DPLL_J_TYPE,
>>   	.clk_ref	=&sys_clkin_ck,
>>   	.control_reg	= OMAP4430_CM_CLKMODE_DPLL_USB,
>>   	.modes		= (1<<  DPLL_LOW_POWER_BYPASS) | (1<<  DPLL_LOCKED),
>> @@ -924,6 +924,7 @@ static struct dpll_data dpll_usb_dd = {
>>   	.enable_mask	= OMAP4430_DPLL_EN_MASK,
>>   	.autoidle_mask	= OMAP4430_AUTO_DPLL_MODE_MASK,
>>   	.idlest_mask	= OMAP4430_ST_DPLL_CLK_MASK,
>> +	.sddiv_mask	= OMAP4430_DPLL_SD_DIV_MASK,
>>   	.max_multiplier	= OMAP4430_MAX_DPLL_MULT,
>>   	.max_divider	= OMAP4430_MAX_DPLL_DIV,
>>   	.min_divider	= 1,
>> diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
>> index ed8d330..48df8e4 100644
>> --- a/arch/arm/mach-omap2/dpll3xxx.c
>> +++ b/arch/arm/mach-omap2/dpll3xxx.c
>> @@ -225,23 +225,18 @@ static int _omap3_noncore_dpll_stop(struct clk *clk)
>>   }
>>
>>   /**
>> - * lookup_dco_sddiv -  Set j-type DPLL4 compensation variables
>> + * lookup_dco - Lookup DCO used by j-type DPLL
>>    * @clk: pointer to a DPLL struct clk
>>    * @dco: digital control oscillator selector
>> - * @sd_div: target sigma-delta divider
>>    * @m: DPLL multiplier to set
>>    * @n: DPLL divider to set
>>    *
>>    * See 36xx TRM section 3.5.3.3.3.2 "Type B DPLL (Low-Jitter)"
>>    *
>> - * XXX This code is not needed for 3430/AM35xx; can it be optimized
>> - * out in non-multi-OMAP builds for those chips?
>
> Any reason why you're removing this comment?

My thought here was that with this change the code will only be called 
for DPLLs that have the sddiv_offset and dco_offset members set and so 
this will take care of all OMAP3 devices. In other words, it will not be 
called for OMAP34xx/AM35xx devices because these devices *should* not 
set these fields.

However, now I see that the point of this comment was to remove these 
functions from the build altogether for OMAP34xx based devices so it is 
not built into the kernel image. I am not sure how this could be 
achieved for a multi-omap2 build if you need to support both omap34xx, 
omap36xx and omap4 devices in the same build.

We don't need to remove the comments if you prefer, I was attempting a 
general clean-up of the code.

>>    */
>> -static void lookup_dco_sddiv(struct clk *clk, u8 *dco, u8 *sd_div, u16 m,
>> -			     u8 n)
>> +static inline void lookup_dco(struct clk *clk, u8 *dco, u16 m, u8 n)
>>   {
>> -	unsigned long fint, clkinp, sd; /* watch out for overflow */
>> -	int mod1, mod2;
>> +	unsigned long fint, clkinp; /* watch out for overflow */
>>
>>   	clkinp = clk->parent->rate;
>>   	fint = (clkinp / n) * m;
>> @@ -250,6 +245,25 @@ static void lookup_dco_sddiv(struct clk *clk, u8 *dco, u8 *sd_div, u16 m,
>>   		*dco = 2;
>>   	else
>>   		*dco = 4;
>> +}
>> +
>> +/**
>> + * lookup_sddiv - Calculate sigma delta divider for j-type DPLL
>> + * @clk: pointer to a DPLL struct clk
>> + * @sd_div: target sigma-delta divider
>> + * @m: DPLL multiplier to set
>> + * @n: DPLL divider to set
>> + *
>> + * See 36xx TRM section 3.5.3.3.3.2 "Type B DPLL (Low-Jitter)"
>> + *
>> + */
>> +static inline void lookup_sddiv(struct clk *clk, u8 *sd_div, u16 m, u8 n)
>> +{
>> +	unsigned long clkinp, sd; /* watch out for overflow */
>> +	int mod1, mod2;
>> +
>> +	clkinp = clk->parent->rate;
>> +
>>   	/*
>>   	 * target sigma-delta to near 250MHz
>>   	 * sd = ceil[(m/(n+1)) * (clkinp_MHz / 250)]
>> @@ -278,6 +292,7 @@ static void lookup_dco_sddiv(struct clk *clk, u8 *dco, u8 *sd_div, u16 m,
>>   static int omap3_noncore_dpll_program(struct clk *clk, u16 m, u8 n, u16 freqsel)
>>   {
>>   	struct dpll_data *dd = clk->dpll_data;
>> +	u8 dco, sd_div;
>>   	u32 v;
>>
>>   	/* 3430 ES2 TRM: 4.7.6.9 DPLL Programming Sequence */
>> @@ -300,18 +315,16 @@ static int omap3_noncore_dpll_program(struct clk *clk, u16 m, u8 n, u16 freqsel)
>>   	v |= m<<  __ffs(dd->mult_mask);
>>   	v |= (n - 1)<<  __ffs(dd->div1_mask);
>>
>> -	/*
>> -	 * XXX This code is not needed for 3430/AM35XX; can it be optimized
>> -	 * out in non-multi-OMAP builds for those chips?
>> -	 */
>> -	if ((dd->flags&  DPLL_J_TYPE)&&  !(dd->flags&  DPLL_NO_DCO_SEL)) {
>> -		u8 dco, sd_div;
>> -		lookup_dco_sddiv(clk,&dco,&sd_div, m, n);
>> -		/* XXX This probably will need revision for OMAP4 */
>> -		v&= ~(OMAP3630_PERIPH_DPLL_DCO_SEL_MASK
>> -			| OMAP3630_PERIPH_DPLL_SD_DIV_MASK);
>> -		v |= dco<<  __ffs(OMAP3630_PERIPH_DPLL_DCO_SEL_MASK);
>> -		v |= sd_div<<  __ffs(OMAP3630_PERIPH_DPLL_SD_DIV_MASK);
>> +	/* Configure dco and sd_div for dplls that have these fields */
>> +	if (dd->dco_mask) {
>> +		lookup_dco(clk,&dco, m, n);
>> +		v&= ~(dd->dco_mask);
>> +		v |= dco<<  __ffs(dd->dco_mask);
>> +	}
>> +	if (dd->sddiv_mask) {
>> +		lookup_sddiv(clk,&sd_div, m, n);
>> +		v&= ~(dd->sddiv_mask);
>> +		v |= sd_div<<  __ffs(dd->sddiv_mask);
>>   	}
>>
>>   	__raw_writel(v, dd->mult_div1_reg);
>> diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
>> index fef4696..51badf9 100644
>> --- a/arch/arm/plat-omap/include/plat/clock.h
>> +++ b/arch/arm/plat-omap/include/plat/clock.h
>> @@ -119,8 +119,7 @@ struct clksel {
>>    *
>>    * Possible values for @flags:
>>    * DPLL_J_TYPE: "J-type DPLL" (only some 36xx, 4xxx DPLLs)
>> - * NO_DCO_SEL: don't program DCO (only for some J-type DPLLs)
>> -
>> + *
>>    * @freqsel_mask is only used on the OMAP34xx family and AM35xx.
>>    *
>>    * XXX Some DPLLs have multiple bypass inputs, so it's not technically
>> @@ -156,6 +155,8 @@ struct dpll_data {
>>   	u32			autoidle_mask;
>>   	u32			freqsel_mask;
>>   	u32			idlest_mask;
>> +	u32			dco_mask;
>> +	u32			sddiv_mask;
>>   	u8			auto_recal_bit;
>>   	u8			recal_en_bit;
>>   	u8			recal_st_bit;
>> --
>> 1.7.1
>
> The rest looks fine to me; I will probably prefix the function names with
> underscores, also I will plan drop the 'inline' and let the compiler deal
> with that.  Any objections to that?

Nope, sounds great. Thanks for the feedback.

Cheers
Jon
