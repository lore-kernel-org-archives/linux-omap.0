From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH v2 2/3] ARM: OMAP2+: hwmod: AM335x/AM43x: add hwmod support
 for tscadc on am43x-evm
Date: Fri, 21 Nov 2014 10:30:04 +0530
Message-ID: <546EC6D4.7080906@ti.com>
References: <1415099728-10959-1-git-send-email-vigneshr@ti.com> <1415099728-10959-3-git-send-email-vigneshr@ti.com> <alpine.DEB.2.02.1411200706441.9204@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.02.1411200706441.9204@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


On 11/20/2014 12:39 PM, Paul Walmsley wrote:
> On Tue, 4 Nov 2014, Vignesh R wrote:
>
>> This patch adds hwmod support for tscadc to work on am43xx-evm. The am33xx
>> hwmod structures of tscadc has been moved to ipblock_data so that it can
>> be reused in am43xx. The clock domain names are separately set for am33xx
>> and am43xx. Thus tscadc dt entries can now be added to am43xx board
>> dt files.
>>
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ...
>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h
>> index 6e57b8ad0db5..b92a7c7825fa 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h
>> +++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h
> ...
>
>> +static void am33xx_hwmod_clockdomain(void)
>> +{
>> +	CLKDMNAME(am33xx_l4_hs_hwmod, "l4hs_clkdm");
>> +	CLKDMNAME(am33xx_adc_tsc_hwmod, "l4_wkup_clkdm");
>> +}
>> +
>> +static void am43xx_hwmod_clockdomain(void)
>> +{
>> +	CLKDMNAME(am33xx_l4_hs_hwmod, "l3_clkdm");
>> +	CLKDMNAME(am33xx_adc_tsc_hwmod, "l3s_tsc_clkdm");
>> +}
>> +
> ...
>
>> +	am33xx_hwmod_clockdomain();
> I looked at this patch and the one before it.  Is there some reason why we 
> need to share these two hwmods between AM33xx and AM43xx?  It seems 
> cleaner just to add the ADC data directly to the AM43xx hwmod data file, 
> not touch the AM33xx data, and not add another runtime data update for the 
> clockdomains.  Unless there's something that I'm missing?


I wanted to reuse hwmod structures. Except for clockdomain and offset,
rest of the hwmod data are same for AM33xx and AM43xx. Adding data to AM43xx
hwmod file just duplicates these structures. Do you still want me to move them
to AM43xx file?

Regards
Vignesh


> - Paul
