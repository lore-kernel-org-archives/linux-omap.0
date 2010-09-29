From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH v2 04/11] OMAP4: Extend clock data.
Date: Wed, 29 Sep 2010 20:11:01 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB035E1739F3@dbde02.ent.ti.com>
References: <1285419086-13047-1-git-send-email-thara@ti.com>
	<1285419086-13047-5-git-send-email-thara@ti.com>
 <874od9bh4a.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41247 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750962Ab0I2OlJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Sep 2010 10:41:09 -0400
In-Reply-To: <874od9bh4a.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>



>>-----Original Message-----
>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>Sent: Wednesday, September 29, 2010 4:39 AM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org; paul@pwsan.com; Cousson, Benoit; Sripathy,
>>Vishwanath; Sawant, Anand
>>Subject: Re: [PATCH v2 04/11] OMAP4: Extend clock data.
>>
>>Thara Gopinath <thara@ti.com> writes:
>>
>>> This patch extends the OMAP4 clock data to include
>>> various x2 clockc nodes as the clock framework
>>> skips a *2 whie calculating the dpll locked frequency.
>>>
>>> Signed-off-by: Thara Gopinath <thara@ti.com>
>>
>>Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
>>
>>Please post this as a separate patch, and Paul can queue for 2.6.37.

Ok I will post this as a separate patch. 

Regards
Thara
>>
>>Thanks,
>>
>>Kevin
>>
>>> ---
>>>  arch/arm/mach-omap2/clock44xx_data.c |   40 +++++++++++++++++++++++++++---
>>---
>>>  1 files changed, 32 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-
>>omap2/clock44xx_data.c
>>> index edf2c28..3652fda 100644
>>> --- a/arch/arm/mach-omap2/clock44xx_data.c
>>> +++ b/arch/arm/mach-omap2/clock44xx_data.c
>>> @@ -481,14 +481,21 @@ static struct clk dpll_core_m5_ck = {
>>>  	.set_rate	= &omap2_clksel_set_rate,
>>>  };
>>>
>>> +static struct clk dpll_core_m5x2_ck = {
>>> +	.name		= "dpll_core_m5x2_ck",
>>> +	.parent		= &dpll_core_m5_ck,
>>> +	.ops		= &clkops_null,
>>> +	.recalc		= &omap3_clkoutx2_recalc,
>>> +};
>>> +
>>>  static const struct clksel div_core_div[] = {
>>> -	{ .parent = &dpll_core_m5_ck, .rates = div2_1to2_rates },
>>> +	{ .parent = &dpll_core_m5x2_ck, .rates = div2_1to2_rates },
>>>  	{ .parent = NULL },
>>>  };
>>>
>>>  static struct clk div_core_ck = {
>>>  	.name		= "div_core_ck",
>>> -	.parent		= &dpll_core_m5_ck,
>>> +	.parent		= &dpll_core_m5x2_ck,
>>>  	.clksel		= div_core_div,
>>>  	.clksel_reg	= OMAP4430_CM_CLKSEL_CORE,
>>>  	.clksel_mask	= OMAP4430_CLKSEL_CORE_MASK,
>>> @@ -507,13 +514,13 @@ static const struct clksel_rate div4_1to8_rates[] = {
>>>  };
>>>
>>>  static const struct clksel div_iva_hs_clk_div[] = {
>>> -	{ .parent = &dpll_core_m5_ck, .rates = div4_1to8_rates },
>>> +	{ .parent = &dpll_core_m5x2_ck, .rates = div4_1to8_rates },
>>>  	{ .parent = NULL },
>>>  };
>>>
>>>  static struct clk div_iva_hs_clk = {
>>>  	.name		= "div_iva_hs_clk",
>>> -	.parent		= &dpll_core_m5_ck,
>>> +	.parent		= &dpll_core_m5x2_ck,
>>>  	.clksel		= div_iva_hs_clk_div,
>>>  	.clksel_reg	= OMAP4430_CM_BYPCLK_DPLL_IVA,
>>>  	.clksel_mask	= OMAP4430_CLKSEL_0_1_MASK,
>>> @@ -525,7 +532,7 @@ static struct clk div_iva_hs_clk = {
>>>
>>>  static struct clk div_mpu_hs_clk = {
>>>  	.name		= "div_mpu_hs_clk",
>>> -	.parent		= &dpll_core_m5_ck,
>>> +	.parent		= &dpll_core_m5x2_ck,
>>>  	.clksel		= div_iva_hs_clk_div,
>>>  	.clksel_reg	= OMAP4430_CM_BYPCLK_DPLL_MPU,
>>>  	.clksel_mask	= OMAP4430_CLKSEL_0_1_MASK,
>>> @@ -651,6 +658,13 @@ static struct clk dpll_iva_m4_ck = {
>>>  	.set_rate	= &omap2_clksel_set_rate,
>>>  };
>>>
>>> +static struct clk dpll_iva_m4x2_ck = {
>>> +	.name		= "dpll_iva_m4x2_ck",
>>> +	.parent		= &dpll_iva_m4_ck,
>>> +	.ops		= &clkops_null,
>>> +	.recalc		= &omap3_clkoutx2_recalc,
>>> +};
>>> +
>>>  static struct clk dpll_iva_m5_ck = {
>>>  	.name		= "dpll_iva_m5_ck",
>>>  	.parent		= &dpll_iva_ck,
>>> @@ -663,6 +677,13 @@ static struct clk dpll_iva_m5_ck = {
>>>  	.set_rate	= &omap2_clksel_set_rate,
>>>  };
>>>
>>> +static struct clk dpll_iva_m5x2_ck = {
>>> +	.name		= "dpll_iva_m5x2_ck",
>>> +	.parent		= &dpll_iva_m5_ck,
>>> +	.ops		= &clkops_null,
>>> +	.recalc		= &omap3_clkoutx2_recalc,
>>> +};
>>> +
>>>  /* DPLL_MPU */
>>>  static struct dpll_data dpll_mpu_dd = {
>>>  	.mult_div1_reg	= OMAP4430_CM_CLKSEL_DPLL_MPU,
>>> @@ -1350,7 +1371,7 @@ static struct clk dsp_fck = {
>>>  	.enable_reg	= OMAP4430_CM_TESLA_TESLA_CLKCTRL,
>>>  	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
>>>  	.clkdm_name	= "tesla_clkdm",
>>> -	.parent		= &dpll_iva_m4_ck,
>>> +	.parent		= &dpll_iva_m4x2_ck,
>>>  	.recalc		= &followparent_recalc,
>>>  };
>>>
>>> @@ -1725,7 +1746,7 @@ static struct clk iva_fck = {
>>>  	.enable_reg	= OMAP4430_CM_IVAHD_IVAHD_CLKCTRL,
>>>  	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
>>>  	.clkdm_name	= "ivahd_clkdm",
>>> -	.parent		= &dpll_iva_m5_ck,
>>> +	.parent		= &dpll_iva_m5x2_ck,
>>>  	.recalc		= &followparent_recalc,
>>>  };
>>>
>>> @@ -2089,7 +2110,7 @@ static struct clk sl2if_ick = {
>>>  	.enable_reg	= OMAP4430_CM_IVAHD_SL2_CLKCTRL,
>>>  	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
>>>  	.clkdm_name	= "ivahd_clkdm",
>>> -	.parent		= &dpll_iva_m5_ck,
>>> +	.parent		= &dpll_iva_m5x2_ck,
>>>  	.recalc		= &followparent_recalc,
>>>  };
>>>
>>> @@ -2782,6 +2803,7 @@ static struct omap_clk omap44xx_clks[] = {
>>>  	CLK(NULL,	"dpll_core_m2_ck",		&dpll_core_m2_ck,	CK_443X),
>>>  	CLK(NULL,	"ddrphy_ck",			&ddrphy_ck,	CK_443X),
>>>  	CLK(NULL,	"dpll_core_m5_ck",		&dpll_core_m5_ck,	CK_443X),
>>> +	CLK(NULL,	"dpll_core_m5x2_ck",		&dpll_core_m5x2_ck,
>>	CK_443X),
>>>  	CLK(NULL,	"div_core_ck",			&div_core_ck,	CK_443X),
>>>  	CLK(NULL,	"div_iva_hs_clk",		&div_iva_hs_clk,	CK_443X),
>>>  	CLK(NULL,	"div_mpu_hs_clk",		&div_mpu_hs_clk,	CK_443X),
>>> @@ -2793,7 +2815,9 @@ static struct omap_clk omap44xx_clks[] = {
>>>  	CLK(NULL,	"iva_hsd_byp_clk_mux_ck",	&iva_hsd_byp_clk_mux_ck,
>>	CK_443X),
>>>  	CLK(NULL,	"dpll_iva_ck",			&dpll_iva_ck,	CK_443X),
>>>  	CLK(NULL,	"dpll_iva_m4_ck",		&dpll_iva_m4_ck,	CK_443X),
>>> +	CLK(NULL,	"dpll_iva_m4x2_ck",		&dpll_iva_m4x2_ck,
>>	CK_443X),
>>>  	CLK(NULL,	"dpll_iva_m5_ck",		&dpll_iva_m5_ck,	CK_443X),
>>> +	CLK(NULL,	"dpll_iva_m5x2_ck",		&dpll_iva_m5x2_ck,
>>	CK_443X),
>>>  	CLK(NULL,	"dpll_mpu_ck",			&dpll_mpu_ck,	CK_443X),
>>>  	CLK(NULL,	"dpll_mpu_m2_ck",		&dpll_mpu_m2_ck,	CK_443X),
>>>  	CLK(NULL,	"per_hs_clk_div_ck",		&per_hs_clk_div_ck,
>>	CK_443X),
