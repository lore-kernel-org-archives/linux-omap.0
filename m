From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] ARM: OMAP3+: DPLL: stop reparenting to same parent if
 already done
Date: Fri, 14 Feb 2014 15:13:44 +0200
Message-ID: <52FE1688.7080105@ti.com>
References: <1391591048-19433-1-git-send-email-nm@ti.com> <20140213231317.GN28216@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60489 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752395AbaBNNOO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Feb 2014 08:14:14 -0500
In-Reply-To: <20140213231317.GN28216@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

On 02/14/2014 01:13 AM, Tony Lindgren wrote:
> * Nishanth Menon <nm@ti.com> [140205 01:06]:
>> omap3_noncore_dpll_set_rate forces a reparent to the same clk_ref
>> for every call that takes place. This is an can be done only if a change
>> is detected.
>>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>
> Would like to see acks on this too before applying.

Looks good to me, ack.

-Tero

>
> Tony
>
>> ---
>>   arch/arm/mach-omap2/dpll3xxx.c |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
>> index 3185ced..d9bcbf7 100644
>> --- a/arch/arm/mach-omap2/dpll3xxx.c
>> +++ b/arch/arm/mach-omap2/dpll3xxx.c
>> @@ -525,7 +525,7 @@ int omap3_noncore_dpll_set_rate(struct clk_hw *hw, unsigned long rate,
>>   	* stuff is inherited for free
>>   	*/
>>
>> -	if (!ret)
>> +	if (!ret && clk_get_parent(hw->clk) != new_parent)
>>   		__clk_reparent(hw->clk, new_parent);
>>
>>   	return 0;
>> --
>> 1.7.9.5
>>

