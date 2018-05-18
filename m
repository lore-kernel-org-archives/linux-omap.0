From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH 1/3] ARM: dra762: hwmod: Add MCAN support
Date: Fri, 18 May 2018 17:24:24 +0530
Message-ID: <96794128-c107-9b04-aed5-5dd9caa7a605@ti.com>
References: <1523181542-3770-1-git-send-email-faiz_abbas@ti.com>
 <1523181542-3770-2-git-send-email-faiz_abbas@ti.com>
 <20180517210931.GQ98604@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180517210931.GQ98604@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com, paul@pwsan.com, lokeshvutla@ti.com, linux@armlinux.org.uk
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Friday 18 May 2018 02:39 AM, Tony Lindgren wrote:
> * Faiz Abbas <faiz_abbas@ti.com> [180408 09:59]:
>> From: Lokesh Vutla <lokeshvutla@ti.com>
>>
>> Add MCAN hwmod data and register it for dra762 silicons.
>>
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>> ---
>>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 32 +++++++++++++++++++++++++++++++
>>  1 file changed, 32 insertions(+)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
>> index 62352d1..a2cd7f8 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
>> @@ -1356,6 +1356,29 @@ static struct omap_hwmod dra7xx_mailbox13_hwmod = {
>>  };
>>  
>>  /*
>> + * 'mcan' class
>> + *
>> + */
>> +static struct omap_hwmod_class dra76x_mcan_hwmod_class = {
>> +	.name	= "mcan",
>> +};
>> +
>> +/* mcan */
>> +static struct omap_hwmod dra76x_mcan_hwmod = {
>> +	.name		= "mcan",
>> +	.class		= &dra76x_mcan_hwmod_class,
>> +	.clkdm_name	= "wkupaon_clkdm",
>> +	.main_clk	= "mcan_clk",
>> +	.prcm = {
>> +		.omap4 = {
>> +			.clkctrl_offs = DRA7XX_CM_WKUPAON_ADC_CLKCTRL_OFFSET,
>> +			.context_offs = DRA7XX_RM_WKUPAON_ADC_CONTEXT_OFFSET,
>> +			.modulemode   = MODULEMODE_SWCTRL,
>> +		},
>> +	},
>> +};
> 
> So based on the ti-sysc related dts comments, this patch should
> work except you should be able to just leave out the clocks here
> with the dts changes.
> 
>> +/*
>>   * 'mcspi' class
>>   *
>>   */
>> @@ -3818,6 +3841,14 @@ static struct omap_hwmod_ocp_if dra7xx_l4_per2__epwmss2 = {
>>  	.user		= OCP_USER_MPU,
>>  };
>>  
>> +/* l3_main_1 -> mcan */
>> +static struct omap_hwmod_ocp_if dra76x_l3_main_1__mcan = {
>> +	.master		= &dra7xx_l3_main_1_hwmod,
>> +	.slave		= &dra76x_mcan_hwmod,
>> +	.clk		= "l3_iclk_div",
>> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>> +};
>> +
>>  static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
>>  	&dra7xx_l3_main_1__dmm,
>>  	&dra7xx_l3_main_2__l3_instr,
>> @@ -3958,6 +3989,7 @@ static struct omap_hwmod_ocp_if *dra7xx_gp_hwmod_ocp_ifs[] __initdata = {
>>  /* SoC variant specific hwmod links */
>>  static struct omap_hwmod_ocp_if *dra76x_hwmod_ocp_ifs[] __initdata = {
>>  	&dra7xx_l4_per3__usb_otg_ss4,
>> +	&dra76x_l3_main_1__mcan,
>>  	NULL,
>>  };
> 
> So the omap_hwmod_class, omap_hwmod_ocp_if and entry on the
> dra76x_hwmod_ocp_ifs list are still needed with ti-sysc for a
> while. Eventually that data will just come from the dts interconnect
> hierarchy. For struct omap_hwmod_class_sysconfig, ti-sysc will
> allocate and it based on the dts data.
> 

Thanks for the detailed pointers. I will figure out the ti-sysc node
that needs to be added and post a v2.

Thanks,
Faiz
