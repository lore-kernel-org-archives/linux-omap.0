From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v2 3/3] ARM: OMAP4+: Remove static iotable mappings for
 SRAM
Date: Fri, 30 Aug 2013 10:41:16 -0400
Message-ID: <5220AF0C.2000007@ti.com>
References: <1377775391-13103-1-git-send-email-rnayak@ti.com> <1377775391-13103-4-git-send-email-rnayak@ti.com> <871u5c2z3a.fsf@linaro.org> <5220658A.2030806@ti.com> <87hae7s0nv.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50339 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755667Ab3H3Olr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Aug 2013 10:41:47 -0400
In-Reply-To: <87hae7s0nv.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Rajendra Nayak <rnayak@ti.com>, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcousson@baylibre.com, nsekhar@ti.com, paul@pwsan.com

On Friday 30 August 2013 10:39 AM, Kevin Hilman wrote:
> Rajendra Nayak <rnayak@ti.com> writes:
> 
>> On Thursday 29 August 2013 10:50 PM, Kevin Hilman wrote:
>>> Rajendra Nayak <rnayak@ti.com> writes:
>>>
>>>> In order to handle errata I688, a page of sram was reserved by doing a
>>>> static iotable map. Now that we use gen_pool to manage sram, we can
>>>> completely remove all of these static mappings and use gen_pool_alloc()
>>>> to get the one page of sram space needed to implement errata I688.
>>>>
>>>> Suggested-by: Sekhar Nori <nsekhar@ti.com>
>>>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>>>
>>> [...]
>>>
>>>> @@ -71,6 +72,21 @@ void omap_bus_sync(void)
>>>>  }
>>>>  EXPORT_SYMBOL(omap_bus_sync);
>>>>  
>>>> +static int __init omap4_sram_init(void)
>>>> +{
>>>> +	struct device_node *np;
>>>> +	struct gen_pool *sram_pool;
>>>> +
>>>> +	np = of_find_compatible_node(NULL, NULL, "ti,omap4-mpu");
>>>> +	if (!np)
>>>> +		pr_warn("%s:Unable to allocate sram needed to handle errata I688\n",
>>>> +			 __func__);
>>>> +	sram_pool = of_get_named_gen_pool(np, "sram", 0);
>>>
>>> I haven't actually tested this, but if there is no 'sram' property defined...
>>>   
>>>> +	sram_sync = (void *)gen_pool_alloc(sram_pool, PAGE_SIZE);
>>>
>>> ... does this still behave properly?
>>
>> I guess not :(
>> of_get_named_gen_pool() ends up returning NULL, but passing NULL to gen_pool_alloc()
>> crashes. Will fix with the additional check for non-NULL sram_pool, thanks.
> 
> OK, that's what I suspected.  Thanks for checking/testing.
> 
I miss-understood your comment initially. Now re-reading it, its clear now.

Regards,
Santosh

