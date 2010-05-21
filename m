From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH 10/22] OMAP: hwmod: Replace WARN by pr_warning for clockdomain
 check
Date: Fri, 21 May 2010 12:41:24 +0200
Message-ID: <4BF66354.4060400@ti.com>
References: <20100519021800.19716.8938.stgit@localhost.localdomain> <20100519021848.19716.50002.stgit@localhost.localdomain> <4BF65A27.9030603@ru.mvista.com> <4BF65F39.4090909@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53077 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754594Ab0EUKlb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 May 2010 06:41:31 -0400
In-Reply-To: <4BF65F39.4090909@ru.mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 5/21/2010 12:23 PM, Sergei Shtylyov wrote:
> Hello.
>
> I wrote:
>
>>> From: Benoit Cousson<b-cousson@ti.com>
>
>>> Most of the clock nodes belong to a clock domain, but it is perfectly
>>> valid
>>> to have clock without clock domain.
>>> Root clocks for example does not belong to any clock domain.
>>> Keep the warning but reduce the verbosity.
>
>>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>>> Signed-off-by: Paul Walmsley<paul@pwsan.com>
>> [...]
>>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c
>>> b/arch/arm/mach-omap2/omap_hwmod.c
>>> index b6031e4..2fff39f 100644
>>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>>> @@ -404,21 +404,20 @@ static int _del_initiator_dep(struct omap_hwmod
>>> *oh, struct omap_hwmod *init_oh)
>>>    */
>>>   static int _init_main_clk(struct omap_hwmod *oh)
>>>   {
>>> -    struct clk *c;
>>>       int ret = 0;
>>>
>>>       if (!oh->main_clk)
>>>           return 0;
>>>
>>> -    c = omap_clk_get_by_name(oh->main_clk);
>>> -    if (!c)
>>> +    oh->_clk = omap_clk_get_by_name(oh->main_clk);
>>> +    if (!oh->_clk)
>>>           pr_warning("omap_hwmod: %s: cannot clk_get main_clk %s\n",
>>>                  oh->name, oh->main_clk);
>>> -        ret = -EINVAL;
>>> -    oh->_clk = c;
>>> +        return -EINVAL;
>
>>     Don't you need {} here again?
>
>      Looks like the original file misses them too, so it needs fixing in
> a  separate patch perhaps...

You're right, the original-original was fine, I messed up this one 
during the replacement of WARM ([PATCH 07/22] OMAP: hwmod: Replace WARN 
by pr_warning if clock lookup failed) you commented previously.

Thanks,
Benoit
