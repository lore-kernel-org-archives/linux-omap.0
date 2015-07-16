From: "R, Vignesh" <vigneshr@ti.com>
Subject: Re: [PATCH v2 2/5] ARM: OMAP2+: DRA7: Add hwmod entries for PWMSS
Date: Thu, 16 Jul 2015 21:01:37 +0530
Message-ID: <55A7CE59.6010600@ti.com>
References: <1433332284-10766-1-git-send-email-vigneshr@ti.com> <1433332284-10766-3-git-send-email-vigneshr@ti.com> <alpine.DEB.2.02.1507152029460.32764@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.02.1507152029460.32764@utopia.booyaka.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On 07/16/2015 03:24 AM, Paul Walmsley wrote:
> Hi,
> 
> some comments.
> 
> On Wed, 3 Jun 2015, Vignesh R wrote:
> 
>> Add hwmod entries for the PWMSS on DRA7.
>>
>> Set l4_root_clk_div as the main_clk of PWMSS. It is fixed-factored clock
>> equal to L4PER2_L3_GICLK/2(l3_iclk_div/2).
>> As per AM57x TRM SPRUHZ6[1], October 2014, Section 29.1.3 Table 29-4,
>> clock source to PWMSS is L4PER2_L3_GICLK. But it is actually
>> L4PER2_L3_GICLK/2. The TRM does not show the division by 2.
> 
> Is the divide-by-two coming from PWMSS_EPWM.EPWM_TBCTL[HSPCLKDIV]?  Or is 
> HSPCLKDIV a separate divider after the divide-by-2 you mention above?

No, it not related to HSPCLKDIV. The TRM wrongly states L4PER2_L3_GICLK
as clock input for PWMSS. But actually  L4PER2_L4_GICLK(=L3_GICLK/2) is
the clock input for PWMSS. This will be updated in TRM soon.

> 
>> [1] www.ti.com/lit/ug/spruhz6/spruhz6.pdf
>>
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>> ---
>>
>> v2:
>>  * add TRM references.
>>
>>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 239 ++++++++++++++++++++++++++++++
>>  1 file changed, 239 insertions(+)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
>> index 0e64c2fac0b5..86a7ac9a3138 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
>> @@ -362,6 +362,149 @@ static struct omap_hwmod dra7xx_dcan2_hwmod = {
>>  	},
>>  };
>>  
>> +/* pwmss  */
>> +static struct omap_hwmod_class_sysconfig dra7xx_epwmss_sysc = {
>> +	.rev_offs	= 0x0,
>> +	.sysc_offs	= 0x4,
>> +	.sysc_flags	= SYSC_HAS_SIDLEMODE | SYSC_HAS_RESET_STATUS,
> 
> This doesn't match SPRUHZ6 Table 29-13 "PWMSS_SYSCONFIG".  There's no 
> RESETSTATUS bit.  There is a SOFTRESET bit. 
> 
> Could you please confirm whether this is intentional?

sorry my bad... I will change this in v3.

> 
>> +	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
>> +	.sysc_fields	= &omap_hwmod_sysc_type2,
>> +};
>> +
>> +struct omap_hwmod_class dra7xx_epwmss_hwmod_class = {
>> +	.name		= "epwmss",
>> +	.sysc		= &dra7xx_epwmss_sysc,
>> +};
>> +
>> +static struct omap_hwmod_class dra7xx_ecap_hwmod_class = {
>> +	.name		= "ecap",
>> +};
>> +
>> +static struct omap_hwmod_class dra7xx_eqep_hwmod_class = {
>> +	.name		= "eqep",
>> +};
>> +
>> +struct omap_hwmod_class dra7xx_ehrpwm_hwmod_class = {
>> +	.name		= "ehrpwm",
>> +};
>> +
>> +/* epwmss0 */
>> +struct omap_hwmod dra7xx_epwmss0_hwmod = {
>> +	.name		= "epwmss0",
>> +	.class		= &dra7xx_epwmss_hwmod_class,
>> +	.clkdm_name	= "l4per2_clkdm",
>> +	.main_clk	= "l4_root_clk_div",
>> +	.prcm		= {
>> +		.omap4	= {
>> +			.modulemode	= MODULEMODE_SWCTRL,
>> +			.clkctrl_offs	= DRA7XX_CM_L4PER2_PWMSS1_CLKCTRL_OFFSET,
>> +			.context_offs	= DRA7XX_RM_L4PER2_PWMSS1_CONTEXT_OFFSET,
>> +		},
>> +	},
> 
> Per my comment on the previous patch, sounds like it might be better to 
> mark this as HWMOD_SWSUP_SIDLE?  Then again, see the next comment below 
> re: main_clk.
> 
>> +};
>> +
>> +/* ecap0 */
>> +struct omap_hwmod dra7xx_ecap0_hwmod = {
>> +	.name		= "ecap0",
>> +	.class		= &dra7xx_ecap_hwmod_class,
>> +	.clkdm_name	= "l4per2_clkdm",
>> +	.main_clk	= "l4_root_clk_div",
> 
> Looking at SPRUHZ6 Section 29.1.4.2 "PWMSS Modules Local Clock Gating", 
> there appears to be a local "mini-PRCM" for the PWMSS which implements 
> clock gating and reports back on the status of what I'd guess is the local 
> clock gating FSM.
> 
> So from that point of view, you should probably create a clock driver that 
> manages both the clock gate request bit and the FSM status bit.  It should 
> be something that can be reused for the other PWMSS IP blocks.  Then 
> you'd create per-IP block clock nodes and set the main_clk to point to 
> that node.
> 

Since, this register is within the config space of PWMSS, the individual
gating and reporting for the modules within PWMSS
(PWMSS_CLKCONFIG) is currently being taken care by pwm-tipwmss.c(almost
the sole function this driver is doing). It has been the same since
am335x. Adding new clock nodes will result in driver changes and also
changes to am335x, am437x (and other platforms) hwmod files. It also
involves adding new nodes to clocks.dtsi and it will be difficult to
maintain backward compatibility for older platforms. Is it not better to
keep this as is, in order to maintain consistency (with am335x, am437x
etc) and also that these clock bits are within IP's config space?



-- 
Regards
Vignesh
