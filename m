From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv11 01/49] clk: add support for registering clocks from
 description
Date: Fri, 20 Dec 2013 15:14:35 +0200
Message-ID: <52B442BB.6060701@ti.com>
References: <1387452260-23276-1-git-send-email-t-kristo@ti.com> <1387452260-23276-2-git-send-email-t-kristo@ti.com> <alpine.DEB.2.02.1312201046510.20802@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41251 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932321Ab3LTNPE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Dec 2013 08:15:04 -0500
In-Reply-To: <alpine.DEB.2.02.1312201046510.20802@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Mike Turquette <mturquetter@linaro.org>

On 12/20/2013 12:53 PM, Paul Walmsley wrote:
> On Thu, 19 Dec 2013, Tero Kristo wrote:
>
>> From: Mike Turquette <mturquetter@linaro.org>
>
> Is this E-mail address correct?  It's one byte off of the Signed-off-by:
> address.

No it is not, just my typo there. :P Will fix that for next rev.

>
>> clk_register_desc is the primary interface for populating the clock tree
>> with new clock nodes. In time, this will replace the various hardware-specific
>> registration functions (e.g. clk_register_gate).
>>
>> Signed-off-by: Mike Turquette <mturquette@linaro.org>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> ---
>
> ...
>
>>
>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
>> index 2cf2ea6..29281f6 100644
>> --- a/drivers/clk/clk.c
>> +++ b/drivers/clk/clk.c
>> @@ -1905,6 +1905,77 @@ fail_out:
>> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
>> index 7e59253..7fddcb3 100644
>> --- a/include/linux/clk-provider.h
>> +++ b/include/linux/clk-provider.h
>> @@ -161,6 +161,28 @@ struct clk_init_data {
>>   };
>>
>>   /**
>> + * struct clk_desc - clock init descriptor for providing init time parameters
>> + * for a clock.
>> + *
>> + * @name: clock name
>
> As mentioned in
>
> http://patchwork.ozlabs.org/patch/294253/
>
> please remove the blank line between the summary line and the arguments.
> Documentation/kernel-doc-nano.txt says:

Yeah, will do similar changes to other patches also.

-Tero

>
> "The @argument descriptions must begin on the very next line following
> this opening short function description line, with no intervening
> empty comment lines."
>
>
> - Paul
>

