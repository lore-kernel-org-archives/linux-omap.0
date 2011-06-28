From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v3 8/8] OMAP2+: hwmod: Follow the recommended PRCM module
 enable sequence
Date: Tue, 28 Jun 2011 23:33:46 +0200
Message-ID: <4E0A48BA.7080602@ti.com>
References: <1309191103-8817-1-git-send-email-b-cousson@ti.com>	<1309191103-8817-9-git-send-email-b-cousson@ti.com> <87wrg5yiz5.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41542 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751013Ab1F1Vdw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Jun 2011 17:33:52 -0400
In-Reply-To: <87wrg5yiz5.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "toddpoynor@google.com" <toddpoynor@google.com>

On 6/28/2011 7:16 PM, Hilman, Kevin wrote:
> Benoit Cousson<b-cousson@ti.com>  writes:
>
>> From: Rajendra Nayak<rnayak@ti.com>
>>
>> On OMAP4, the PRCM recommended sequence for enabling
>> a module after power-on-reset is:
>> -1- Force clkdm to SW_WKUP
>> -2- Enabling the clocks
>> -3- Configure desired module mode to "enable" or "auto"
>> -4- Wait for the desired module idle status to be FUNC
>> -5- Program clkdm in HW_AUTO(if supported)
>>
>> This sequence applies to all older OMAPs' as well,
>> however since they use autodeps, it makes sure that
>> no clkdm is in IDLE, and hence not requiring a force
>> SW_WKUP when a module is being enabled.
>
> OK, I found the problem that prevents booting on OMAP3...

Cool... thanks for that.

>> OMAP4 does not need to support autodeps, because
>> of the dyanamic dependency feature, wherein
>> the HW takes care of waking up a clockdomain from
>> idle and hence the module, whenever an interconnect
>> access happens to the given module.
>>
>> Implementing the sequence for OMAP4 requires
>> the clockdomain handling that is currently done in
>> clock framework to be done as part of hwmod framework
>> since the step -4- above to "Wait for the desired
>> module idle status to be FUNC" is done as part of
>> hwmod framework.
>>
>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>> [b-cousson@ti.com: Adapt it to the new clkdm hwmod attribute and API]
>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>> Cc: Paul Walmsley<paul@pwsan.com>
>> ---
>>   arch/arm/mach-omap2/clock.c      |   17 +----------------
>>   arch/arm/mach-omap2/omap_hwmod.c |   26 +++++++++++++++++++++++++-
>>   2 files changed, 26 insertions(+), 17 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
>> index 180299e..2828d29 100644
>> --- a/arch/arm/mach-omap2/clock.c
>> +++ b/arch/arm/mach-omap2/clock.c
>> @@ -268,9 +268,6 @@ void omap2_clk_disable(struct clk *clk)
>>   		clk->ops->disable(clk);
>>   	}
>>
>> -	if (clk->clkdm)
>> -		clkdm_clk_disable(clk->clkdm, clk);
>> -
>>   	if (clk->parent)
>>   		omap2_clk_disable(clk->parent);
>>   }
>> @@ -308,30 +305,18 @@ int omap2_clk_enable(struct clk *clk)
>>   		}
>>   	}
>>
>> -	if (clk->clkdm) {
>> -		ret = clkdm_clk_enable(clk->clkdm, clk);
>> -		if (ret) {
>> -			WARN(1, "clock: %s: could not enable clockdomain %s: "
>> -			     "%d\n", clk->name, clk->clkdm->name, ret);
>> -			goto oce_err2;
>> -		}
>> -	}
>> -
>>   	if (clk->ops&&  clk->ops->enable) {
>>   		trace_clock_enable(clk->name, 1, smp_processor_id());
>>   		ret = clk->ops->enable(clk);
>>   		if (ret) {
>>   			WARN(1, "clock: %s: could not enable: %d\n",
>>   			     clk->name, ret);
>> -			goto oce_err3;
>> +			goto oce_err2;
>>   		}
>>   	}
>
> The clkdm enable/disable in this part of the patch is still required on
> OMAP2/3, since the clkdm is still attached to the clock and not to the
> hwmod.

OK, but I guess that in case of OMAP4, we are probably incrementing 
twice the usage counter... but that should not hurt, because we will 
decrement twice as well.

Rajendra,
Does that seems OK to you?

Thanks,
Benoit
