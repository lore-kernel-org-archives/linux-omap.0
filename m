From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 1/3] ARM: OMAP4: use CLK_SET_RATE_PARENT for dss_dss_clk
Date: Thu, 24 Oct 2013 16:23:13 +0300
Message-ID: <52691F41.1030900@ti.com>
References: <1381324359-28825-1-git-send-email-tomi.valkeinen@ti.com> <5268D44D.5010205@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33965 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754613Ab3JXNXk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Oct 2013 09:23:40 -0400
In-Reply-To: <5268D44D.5010205@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Archit Taneja <archit@ti.com>

On 10/24/2013 11:03 AM, Tomi Valkeinen wrote:
> Hi Tony, Tero,
>
> On 09/10/13 16:12, Tomi Valkeinen wrote:
>> Set CLK_SET_RATE_PARENT flag for dss_dss_clk so that the DSS's fclk can
>> be configured without the need to get the parent of the fclk.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> ---
>>   arch/arm/mach-omap2/cclock44xx_data.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-omap2/cclock44xx_data.c b/arch/arm/mach-omap2/cclock44xx_data.c
>> index b237950..ec0dc0b 100644
>> --- a/arch/arm/mach-omap2/cclock44xx_data.c
>> +++ b/arch/arm/mach-omap2/cclock44xx_data.c
>> @@ -830,7 +830,8 @@ DEFINE_CLK_GATE(dss_tv_clk, "extalt_clkin_ck", &extalt_clkin_ck, 0x0,
>>   		OMAP4430_CM_DSS_DSS_CLKCTRL,
>>   		OMAP4430_OPTFCLKEN_TV_CLK_SHIFT, 0x0, NULL);
>>
>> -DEFINE_CLK_GATE(dss_dss_clk, "dpll_per_m5x2_ck", &dpll_per_m5x2_ck, 0x0,
>> +DEFINE_CLK_GATE(dss_dss_clk, "dpll_per_m5x2_ck", &dpll_per_m5x2_ck,
>> +		CLK_SET_RATE_PARENT,
>>   		OMAP4430_CM_DSS_DSS_CLKCTRL, OMAP4430_OPTFCLKEN_DSSCLK_SHIFT,
>>   		0x0, NULL);
>
> I was discussing with Tero about these three patches, and he was ok with
> them being merged.
>
> Tony, it'd be great to have these for 3.13, so that I can start cleaning
> up the DSS driver's fclk management.

Yea, am ok with these, I can incorporate the changes to my DT clk series.

-Tero

