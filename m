From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 02/11] ARM: OMAP3: clock: add API to enable/disable autoidle
 for a single clock
Date: Mon, 21 Oct 2013 18:24:26 +0530
Message-ID: <52652402.70906@ti.com>
References: <1381508141-15244-1-git-send-email-t-kristo@ti.com> <1381508141-15244-3-git-send-email-t-kristo@ti.com> <alpine.DEB.2.02.1310191712450.11676@utopia.booyaka.com> <20131021122610.11944.71616@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35791 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753331Ab3JUMy6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Oct 2013 08:54:58 -0400
In-Reply-To: <20131021122610.11944.71616@quantum>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@linaro.org

On Monday 21 October 2013 05:56 PM, Mike Turquette wrote:
> Quoting Paul Walmsley (2013-10-19 10:16:50)
>> On Fri, 11 Oct 2013, Tero Kristo wrote:
>>
>>> Some drivers require direct access to the autoidle functionality of the
>>> interface clocks. Added clock APIs for these, so that the drivers do not
>>> need to access CM registers directly.
>>>
>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>
>> Thanks, queued.  Please coordinate with Mike to get 
>> allow_idle/deny_idle-type interfaces into the Common Clock Framework, so 
>> these can be replaced with standard CCF-type allow_idle() & deny_idle() 
>> functions.  That interface should include use-counting so multiple callers 
>> can use allow_idle() and deny_idle() without stomping on each other.
> 
> Where and when are these functions called? IIRC these are only accessed
> at boot/init time, though I may be wrong. If they are a boot-time thing
> then the .init callback provided in struct clk may be sufficient.

deny_idle() gets called early during clock init to disable all hardware
level idling (during boot) and allow_idle() is called during late init
(after PM init) to allow hardware idling.

> 
> Regards,
> Mike
> 
>>
>>
>> - Paul
>>
>>> ---
>>>  arch/arm/mach-omap2/clock.c |   38 ++++++++++++++++++++++++++++++++++++++
>>>  arch/arm/mach-omap2/clock.h |    2 ++
>>>  2 files changed, 40 insertions(+)
>>>
>>> diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
>>> index 0c38ca9..c7c5d31 100644
>>> --- a/arch/arm/mach-omap2/clock.c
>>> +++ b/arch/arm/mach-omap2/clock.c
>>> @@ -543,6 +543,44 @@ int omap2_clk_disable_autoidle_all(void)
>>>  }
>>>  
>>>  /**
>>> + * omap2_clk_deny_idle - disable autoidle on an OMAP clock
>>> + * @clk: struct clk * to disable autoidle for
>>> + *
>>> + * Disable autoidle on an OMAP clock.
>>> + */
>>> +int omap2_clk_deny_idle(struct clk *clk)
>>> +{
>>> +     struct clk_hw_omap *c;
>>> +
>>> +     if (__clk_get_flags(clk) & CLK_IS_BASIC)
>>> +             return -EINVAL;
>>> +
>>> +     c = to_clk_hw_omap(__clk_get_hw(clk));
>>> +     if (c->ops && c->ops->deny_idle)
>>> +             c->ops->deny_idle(c);
>>> +     return 0;
>>> +}
>>> +
>>> +/**
>>> + * omap2_clk_allow_idle - enable autoidle on an OMAP clock
>>> + * @clk: struct clk * to enable autoidle for
>>> + *
>>> + * Enable autoidle on an OMAP clock.
>>> + */
>>> +int omap2_clk_allow_idle(struct clk *clk)
>>> +{
>>> +     struct clk_hw_omap *c;
>>> +
>>> +     if (__clk_get_flags(clk) & CLK_IS_BASIC)
>>> +             return -EINVAL;
>>> +
>>> +     c = to_clk_hw_omap(__clk_get_hw(clk));
>>> +     if (c->ops && c->ops->allow_idle)
>>> +             c->ops->allow_idle(c);
>>> +     return 0;
>>> +}
>>> +
>>> +/**
>>>   * omap2_clk_enable_init_clocks - prepare & enable a list of clocks
>>>   * @clk_names: ptr to an array of strings of clock names to enable
>>>   * @num_clocks: number of clock names in @clk_names
>>> diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
>>> index 7aa32cd..82916cc 100644
>>> --- a/arch/arm/mach-omap2/clock.h
>>> +++ b/arch/arm/mach-omap2/clock.h
>>> @@ -411,6 +411,8 @@ void omap2_clk_dflt_find_idlest(struct clk_hw_omap *clk,
>>>  void omap2_init_clk_hw_omap_clocks(struct clk *clk);
>>>  int omap2_clk_enable_autoidle_all(void);
>>>  int omap2_clk_disable_autoidle_all(void);
>>> +int omap2_clk_allow_idle(struct clk *clk);
>>> +int omap2_clk_deny_idle(struct clk *clk);
>>>  void omap2_clk_enable_init_clocks(const char **clk_names, u8 num_clocks);
>>>  int omap2_clk_switch_mpurate_at_boot(const char *mpurate_ck_name);
>>>  void omap2_clk_print_new_rates(const char *hfclkin_ck_name,
>>> -- 
>>> 1.7.9.5
>>>
>>
>>
>> - Paul
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

