From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 1/6 V4] OMAP4: Clock: Associate clocks for OMAP temperature
 sensor
Date: Fri, 02 Sep 2011 12:42:40 +0530
Message-ID: <4E6081E8.3090509@ti.com>
References: <1314811510-15595-1-git-send-email-j-keerthy@ti.com> <1314811510-15595-2-git-send-email-j-keerthy@ti.com> <alpine.DEB.2.00.1108311757260.26173@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:32837 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752536Ab1IBHMr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Sep 2011 03:12:47 -0400
Received: by mail-yi0-f48.google.com with SMTP id 17so2650995yib.35
        for <linux-omap@vger.kernel.org>; Fri, 02 Sep 2011 00:12:46 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1108311757260.26173@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, "Cousson, Benoit" <b-cousson@ti.com>

Hi Paul,

On Thursday 01 September 2011 05:30 AM, Paul Walmsley wrote:
> Hi,
>
> a comment:
>
> On Wed, 31 Aug 2011, Keerthy wrote:
>
>> div_ts_ck feeds only the temperature sensor functional clock
>> and also has a clksel associated (for divider selection). Mapping this
>> as the functional clock for the temperature sensor in clkdev table,
>> so a clk_set_rate() in the driver would have the effect of changing the
>> temperature sensor clock rate indirectly.
>>
>> Signed-off-by: Keerthy<j-keerthy@ti.com>
>> Reviewed-by: Rajendra Nayak<rnayak@ti.com>
>> Cc: tony@atomide.com
>> Cc: rnayak@ti.com
>> ---
>>   arch/arm/mach-omap2/clock44xx_data.c |    2 +-
>>   1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
>> index 2af0e3f..4a788f4 100644
>> --- a/arch/arm/mach-omap2/clock44xx_data.c
>> +++ b/arch/arm/mach-omap2/clock44xx_data.c
>> @@ -3187,7 +3187,7 @@ static struct omap_clk omap44xx_clks[] = {
>>   	CLK(NULL,	"bandgap_fclk",			&bandgap_fclk,	CK_443X),
>>   	CLK(NULL,	"bandgap_ts_fclk",		&bandgap_ts_fclk,	CK_446X),
>>   	CLK(NULL,	"des3des_fck",			&des3des_fck,	CK_443X),
>> -	CLK(NULL,	"div_ts_ck",			&div_ts_ck,	CK_446X),
>> +	CLK("omap_temp_sensor.0",	"fck",			&div_ts_ck,	CK_446X),
>
> It shouldn't be necessary to add the device name/ID here.  We're trying
> to get rid of these.  The omap_device code should take care of adding the
> appropriate alias.

The problem seems to be that we have 2 clock nodes modeled,
bandgap_ts_fclk with enable/disable ops, (which also happens
to be the main_clk for the bandgap hwmod) and div_ts_ck (as
parent of bandgap_ts_fclk) with clksel for divider selection.
Like you said, the clkdev entries are added by omap_device code
for bandgap_ts_fclk, however doing a clk_set_rate on it from
the driver has no effect as the clksel information is missing
and is modeled in the parent (div_ts_ck) node.
 From looking at it, it makes sense to merge these 2 nodes and fix
the autogen scripts which currently generate 2 separate nodes.
what do you think?

regards,
Rajendra


>
>
>>   	CLK(NULL,	"dmic_sync_mux_ck",		&dmic_sync_mux_ck,	CK_443X),
>>   	CLK(NULL,	"dmic_fck",			&dmic_fck,	CK_443X),
>>   	CLK(NULL,	"dsp_fck",			&dsp_fck,	CK_443X),
>> --
>> 1.7.0.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>
> - Paul

