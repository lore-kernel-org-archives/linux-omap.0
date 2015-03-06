From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH 2/4] ARM: OMAP2+: AM43xx hwmod: Add RTC hwmod for AM43xx
Date: Fri, 6 Mar 2015 11:30:03 -0600
Message-ID: <54F9E41B.5010805@ti.com>
References: <1425561211-31003-1-git-send-email-d-gerlach@ti.com> <1425561211-31003-3-git-send-email-d-gerlach@ti.com> <alpine.DEB.2.02.1503060425590.5613@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45077 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754499AbbCFRaj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Mar 2015 12:30:39 -0500
In-Reply-To: <alpine.DEB.2.02.1503060425590.5613@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, KEERTHY <j-keerthy@ti.com>

Paul,
On 03/05/2015 10:26 PM, Paul Walmsley wrote:
> On Thu, 5 Mar 2015, Dave Gerlach wrote:
> 
>> RTC hwmod is needed for proper operation of PM features like
>> rtcwake and rtc-only mode so reuse the am33xx rtc hwmod.
>>
>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>> ---
>>  arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
>> index 8eb8592..9070535 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
>> @@ -889,6 +889,7 @@ static struct omap_hwmod_ocp_if *am43xx_hwmod_ocp_ifs[] __initdata = {
>>  	&am43xx_l4_ls__dss,
>>  	&am43xx_l4_ls__dss_dispc,
>>  	&am43xx_l4_ls__dss_rfbi,
>> +	&am33xx_l4_wkup__rtc,
>>  	NULL,
>>  };
> 
> Thanks, queued for v4.1.

Thanks, but please note as I just commented in Patch 1 of this series, without
the ti,no-init flag in place that is introduced there this patch will cause the
am43x-epos-evm to fail to boot.

Regards,
Dave

> 
> 
> - Paul
> 

