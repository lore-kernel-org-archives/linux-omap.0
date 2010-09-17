From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 12/13 v5] OMAP: GPIO: Use dev_pm_ops instead of sys_dev_class
Date: Fri, 17 Sep 2010 07:25:43 -0700
Message-ID: <87d3sc4fbs.fsf@deeprootsystems.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301F6E9D122@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:62562 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753964Ab0IQOZu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Sep 2010 10:25:50 -0400
Received: by pxi10 with SMTP id 10so603427pxi.19
        for <linux-omap@vger.kernel.org>; Fri, 17 Sep 2010 07:25:49 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301F6E9D122@dbde02.ent.ti.com>
	(Partha Basak's message of "Fri, 17 Sep 2010 13:47:05 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Basak, Partha" <p-basak2@ti.com>
Cc: "Varadarajan, Charulatha" <charu@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Nayak, Rajendra" <IMCEAEX-_O=TI_OU=EXCHANGE+20ADMINISTRATIVE+20GROUP+20+28FYDIBOHF23SPDLT+29_CN=RECIPIENTS_CN=X0016154@dlee86.itg.ti.com>

"Basak, Partha" <p-basak2@ti.com> writes:

[...]

>> >  /* TODO: Analyze removing gpio_bank_count usage from driver code */
>> > @@ -1045,6 +1044,9 @@ static int omap_gpio_request(struct 
>> gpio_chip *chip, unsigned offset)
>> >  	struct gpio_bank *bank = container_of(chip, struct 
>> gpio_bank, chip);
>> >  	unsigned long flags;
>> >  
>> > +	if (!bank->mod_usage)
>> > +		pm_runtime_get_sync(bank->dev);
>> > +
>> 
>> Would be fine to skip the 'if' here and let runtime PM continue the
>> usecounting.  Since we'll have trace tools that instrument runtime PM,
>> it will be nice to be able to trace all the users instead of just the
>> first one to request a GPIO in a given bank.
>> 
> We are continuing to use mod_usage checks for the following reasons:
>
> 1. In the absence of mod_usage,
> pm_runtime_getsync() would be called in the omap_gpio_request()once per
> pin for each bank. However, a matching pm_runtime_putsync() would be
> called in the CPU_Idle path only once for a given bank. This would lead to 
> atomic_dec_and_test(&dev->power.usage_count) to return false and
> the put_sync will not be effective.

OK, per-bank is most important.

> 2. Consider a case that a bank is not requested at all but in the CPU_Idle path we
>  go-ahead and call pm_runtime_putsync() for that bank. Since usage_count is
> already zero, this call makes it negative. Now, a subsequent call to
> get_sync() will increment it to 0 and enable the clocks. 
> This leads to an error-scenario where clocks are enabled with usage_cnt = 0.

OK

> 3. Ideally we should not be even attempting to fiddle with the
> un-requested GPIO banks in the CPU_Idle path.

Agreed.

Sounds like the right path.

Kevin
