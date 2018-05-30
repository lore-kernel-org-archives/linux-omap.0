From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH v2 1/6] ARM: dra762: hwmod: Add MCAN support
Date: Wed, 30 May 2018 18:15:42 +0300
Message-ID: <cfa9c9df-57a2-69f6-9509-440dc18292e7@ti.com>
References: <20180530141133.3711-1-faiz_abbas@ti.com>
 <20180530141133.3711-2-faiz_abbas@ti.com> <20180530145047.GC5705@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180530145047.GC5705@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Faiz Abbas <faiz_abbas@ti.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, robh+dt@kernel.org, bcousson@baylibre.com, paul@pwsan.com
List-Id: linux-omap@vger.kernel.org

On 30/05/18 17:50, Tony Lindgren wrote:
> * Faiz Abbas <faiz_abbas@ti.com> [180530 14:12]:
>> From: Lokesh Vutla <lokeshvutla@ti.com>
>>
>> Add MCAN hwmod data and register it for dra762 silicons.
>>
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>> ---
>>   arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 32 +++++++++++++++++++++++
>>   1 file changed, 32 insertions(+)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
>> index 62352d1e6361..a2cd7f865a60 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
>> @@ -1355,6 +1355,29 @@ static struct omap_hwmod dra7xx_mailbox13_hwmod = {
>>   	},
>>   };
>>   
>> +/*
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
> You should be now able to leave out at least the clkctrl_offs and modulemode
> here. Please also check if leaving out clkdm_name and main_clk now works :)
> 
>> @@ -3818,6 +3841,14 @@ static struct omap_hwmod_ocp_if dra7xx_l4_per2__epwmss2 = {
>>   	.user		= OCP_USER_MPU,
>>   };
>>   
>> +/* l3_main_1 -> mcan */
>> +static struct omap_hwmod_ocp_if dra76x_l3_main_1__mcan = {
>> +	.master		= &dra7xx_l3_main_1_hwmod,
>> +	.slave		= &dra76x_mcan_hwmod,
>> +	.clk		= "l3_iclk_div",
>> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>> +};
> 
> I think this we still need though for the clk. Tero, do you have any comments
> on what all clocks can now be left out?

For the OCP if part, I think that is still needed until we switch over 
to full sysc driver. clkctrl_offs you probably also need because that is 
used for mapping the omap_hwmod against a specific clkctrl clock. Those 
can be only removed once we are done with hwmod (or figure out some 
other way to assign the clkctrl clock to a hwmod.)

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
