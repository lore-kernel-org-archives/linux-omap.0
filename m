From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH 2/2] ARM: AM43XX: HWMOD: Add rtc hwmod
Date: Thu, 18 Feb 2016 13:15:25 +0530
Message-ID: <56C57695.3010300@ti.com>
References: <1455773381-11839-1-git-send-email-j-keerthy@ti.com>
 <1455773381-11839-3-git-send-email-j-keerthy@ti.com>
 <alpine.DEB.2.02.1602180634120.4792@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.02.1602180634120.4792@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Keerthy <j-keerthy@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Paul,

On Thursday 18 February 2016 12:12 PM, Paul Walmsley wrote:
> Hi Keerthy
>
> On Thu, 18 Feb 2016, Keerthy wrote:
>
>> The patch adds rtc hwmod. RTC module The RTC module is physically
>> present on the AM438x SoC used on AM43X-EPOS-EVM, but it is permanently
>> disabled. A secure RTC is used instead on these devices, where needed.
>> . Hence adding it selectively using a seprate list to get RTC Module
>> functional on the other am43x SoCs used on am437x-gp-evm and
>> am437x-sk-evm.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>
>> No Public TRM is available for AM438x SoC as of now.
>>
>>   arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 14 +++++++++++++-
>>   1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
>> index e97a894..fcffaf8 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
>> @@ -1020,9 +1020,21 @@ static struct omap_hwmod_ocp_if *am43xx_hwmod_ocp_ifs[] __initdata = {
>>   	NULL,
>>   };
>>
>> +static struct omap_hwmod_ocp_if *am43xx_rtc_hwmod_ocp_ifs[] __initdata = {
>> +	&am33xx_l4_wkup__rtc,
>> +	NULL,
>> +};
>> +
>>   int __init am43xx_hwmod_init(void)
>>   {
>> +	int ret;
>> +
>>   	omap_hwmod_am43xx_reg();
>>   	omap_hwmod_init();
>> -	return omap_hwmod_register_links(am43xx_hwmod_ocp_ifs);
>> +	ret = omap_hwmod_register_links(am43xx_hwmod_ocp_ifs);
>> +
>> +	if (!(of_machine_is_compatible("ti,am438x")))
>> +		ret = omap_hwmod_register_links(am43xx_rtc_hwmod_ocp_ifs);
>> +
>> +	return ret;
>>   }
>
> Could you please invert the test of this case such that the RTC hwmod is
> only registered on AM43xx SoCs where it is specifically known to be
> enabled?
>
> That way, if another AM43xx SoC comes out that doesn't have the RTC
> module, it won't inadvertently be registered.  This seems like a safer
> approach.

I get your point but currently only am438x SoC has RTC disabled forever.
So i checked negating am438x. I can add a check with am4372 here and 
register for only those SoCs.

I will resend a v2 in a while.

Thanks for the quick response.

Best Regards,
Keerthy

>
> - Paul
>
