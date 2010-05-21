From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 10/22] OMAP: hwmod: Replace WARN by pr_warning for clockdomain
 check
Date: Fri, 21 May 2010 14:23:53 +0400
Message-ID: <4BF65F39.4090909@ru.mvista.com>
References: <20100519021800.19716.8938.stgit@localhost.localdomain> <20100519021848.19716.50002.stgit@localhost.localdomain> <4BF65A27.9030603@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56155 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753535Ab0EUKYm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 May 2010 06:24:42 -0400
Received: by wyg36 with SMTP id 36so543532wyg.19
        for <linux-omap@vger.kernel.org>; Fri, 21 May 2010 03:24:41 -0700 (PDT)
In-Reply-To: <4BF65A27.9030603@ru.mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

Hello.

I wrote:

>> From: Benoit Cousson <b-cousson@ti.com>

>> Most of the clock nodes belong to a clock domain, but it is perfectly 
>> valid
>> to have clock without clock domain.
>> Root clocks for example does not belong to any clock domain.
>> Keep the warning but reduce the verbosity.

>> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
>> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> [...]
>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c 
>> b/arch/arm/mach-omap2/omap_hwmod.c
>> index b6031e4..2fff39f 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>> @@ -404,21 +404,20 @@ static int _del_initiator_dep(struct omap_hwmod 
>> *oh, struct omap_hwmod *init_oh)
>>   */
>>  static int _init_main_clk(struct omap_hwmod *oh)
>>  {
>> -    struct clk *c;
>>      int ret = 0;
>>  
>>      if (!oh->main_clk)
>>          return 0;
>>  
>> -    c = omap_clk_get_by_name(oh->main_clk);
>> -    if (!c)
>> +    oh->_clk = omap_clk_get_by_name(oh->main_clk);
>> +    if (!oh->_clk)
>>          pr_warning("omap_hwmod: %s: cannot clk_get main_clk %s\n",
>>                 oh->name, oh->main_clk);
>> -        ret = -EINVAL;
>> -    oh->_clk = c;
>> +        return -EINVAL;

>    Don't you need {} here again?

    Looks like the original file misses them too, so it needs fixing in 
a  separate patch perhaps...

WBR, Sergei

