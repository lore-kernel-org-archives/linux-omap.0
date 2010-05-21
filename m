From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH 07/22] OMAP: hwmod: Replace WARN by pr_warning if clock
 lookup	failed
Date: Fri, 21 May 2010 12:16:26 +0200
Message-ID: <4BF65D7A.7070605@ti.com>
References: <20100519021800.19716.8938.stgit@localhost.localdomain> <20100519021845.19716.65638.stgit@localhost.localdomain> <4BF659CB.6010605@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37581 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752601Ab0EUKQc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 May 2010 06:16:32 -0400
In-Reply-To: <4BF659CB.6010605@ru.mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 5/21/2010 12:00 PM, Sergei Shtylyov wrote:
> Hello.
>
> Paul Walmsley wrote:
>> From: Benoit Cousson<b-cousson@ti.com>
>
>> The WARN is a little bit too verbose and is not providing
>> usefull information in that case.
>
>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>> Signed-off-by: Paul Walmsley<paul@pwsan.com>
>
> [...]
>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
>> index a62920b..5d3a3ea 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>> @@ -411,9 +411,9 @@ static int _init_main_clk(struct omap_hwmod *oh)
>>   		return 0;
>>
>>   	c = omap_clk_get_by_name(oh->main_clk);
>> -	WARN(!c, "omap_hwmod: %s: cannot clk_get main_clk %s\n",
>> -	     oh->name, oh->main_clk);
>>   	if (!c)
>> +		pr_warning("omap_hwmod: %s: cannot clk_get main_clk %s\n",
>> +			   oh->name, oh->main_clk);
>>   		ret = -EINVAL;
>
>      Don't you need {} around the statements here?

You don't like the Python style for managing block? :-)
In that case, it is indeed better to have that.
I'll fix that one and the following ones.

Thanks,
Benoit
