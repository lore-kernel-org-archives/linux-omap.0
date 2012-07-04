From: "Turquette, Mike" <mturquette@ti.com>
Subject: Re: [PATCH 02/29] clk: Add CLK_IS_BASIC flag to identify basic clocks
Date: Tue, 3 Jul 2012 23:18:42 -0700
Message-ID: <CAJOA=zMBb+sLT2BejmmkVyd8+Ti4wVh1pXrCm7JLHwZ7g8w3Jg@mail.gmail.com>
References: <1339678038-23082-1-git-send-email-rnayak@ti.com>
 <1339678038-23082-3-git-send-email-rnayak@ti.com> <4FF2E6BF.1060504@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:46177 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932926Ab2GDGTH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jul 2012 02:19:07 -0400
Received: by ghbz2 with SMTP id z2so6352806ghb.34
        for <linux-omap@vger.kernel.org>; Tue, 03 Jul 2012 23:19:04 -0700 (PDT)
In-Reply-To: <4FF2E6BF.1060504@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Jul 3, 2012 at 5:34 AM, Rajendra Nayak <rnayak@ti.com> wrote:
> Hi Mike,
>
>
> On Thursday 14 June 2012 06:16 PM, Rajendra Nayak wrote:
>>
>> Most platforms end up using a mix of basic clock types and
>> some which use clk_hw_foo struct for filling in custom platform
>> information when the clocks don't fit into basic types supported.
>>
>> In platform code, its useful to know if a clock is using a basic
>> type or clk_hw_foo, which helps platforms know if they can
>> safely use to_clk_hw_foo to derive the clk_hw_foo pointer from
>> clk_hw.
>>
>> Mark all basic clocks with a CLK_IS_BASIC flag.
>>
>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>
>
> While you have already pulled all of my other patches touching
> the Common Clk framework, which were part of this series, this is
> one patch where there hasn't been any discussion. Do you have any
> thoughts on this patch?
> See 'Patch 15/29:  ARM: omap: clk: list all clk_hw_omap clks to
> enable/disable autoidle' how I use this to create a clk_hw_omap
> specific list to handle clock autoidle in OMAP.
>

Hi Rajendra,

I don't have any outstanding review comments for this patch and I've
taken it into clk-next.  Pull the latest and you'll find it there.

Thanks,
Mike

> regards,
> Rajendra
>
>> ---
>>   drivers/clk/clk-divider.c      |    2 +-
>>   drivers/clk/clk-fixed-factor.c |    2 +-
>>   drivers/clk/clk-fixed-rate.c   |    2 +-
>>   drivers/clk/clk-gate.c         |    2 +-
>>   drivers/clk/clk-mux.c          |    2 +-
>>   include/linux/clk-private.h    |    2 +-
>>   include/linux/clk-provider.h   |    1 +
>>   7 files changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
>> index e4911ee..53f9dd7 100644
>> --- a/drivers/clk/clk-divider.c
>> +++ b/drivers/clk/clk-divider.c
>> @@ -266,7 +266,7 @@ struct clk *clk_register_divider(struct device *dev,
>> const char *name,
>>
>>         init.name = name;
>>         init.ops =&clk_divider_ops;
>> -       init.flags = flags;
>> +       init.flags = flags | CLK_IS_BASIC;
>>         init.parent_names = (parent_name ?&parent_name: NULL);
>>
>>         init.num_parents = (parent_name ? 1 : 0);
>>
>> diff --git a/drivers/clk/clk-fixed-factor.c
>> b/drivers/clk/clk-fixed-factor.c
>> index c8c003e..a489985 100644
>> --- a/drivers/clk/clk-fixed-factor.c
>> +++ b/drivers/clk/clk-fixed-factor.c
>> @@ -82,7 +82,7 @@ struct clk *clk_register_fixed_factor(struct device
>> *dev, const char *name,
>>
>>         init.name = name;
>>         init.ops =&clk_fixed_factor_ops;
>> -       init.flags = flags;
>> +       init.flags = flags | CLK_IS_BASIC;
>>         init.parent_names =&parent_name;
>>
>>         init.num_parents = 1;
>>
>> diff --git a/drivers/clk/clk-fixed-rate.c b/drivers/clk/clk-fixed-rate.c
>> index cbd2462..7e14645 100644
>> --- a/drivers/clk/clk-fixed-rate.c
>> +++ b/drivers/clk/clk-fixed-rate.c
>> @@ -63,7 +63,7 @@ struct clk *clk_register_fixed_rate(struct device *dev,
>> const char *name,
>>
>>         init.name = name;
>>         init.ops =&clk_fixed_rate_ops;
>> -       init.flags = flags;
>> +       init.flags = flags | CLK_IS_BASIC;
>>         init.parent_names = (parent_name ?&parent_name: NULL);
>>
>>         init.num_parents = (parent_name ? 1 : 0);
>>
>> diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
>> index 578465e..15114fe 100644
>> --- a/drivers/clk/clk-gate.c
>> +++ b/drivers/clk/clk-gate.c
>> @@ -130,7 +130,7 @@ struct clk *clk_register_gate(struct device *dev,
>> const char *name,
>>
>>         init.name = name;
>>         init.ops =&clk_gate_ops;
>> -       init.flags = flags;
>> +       init.flags = flags | CLK_IS_BASIC;
>>         init.parent_names = (parent_name ?&parent_name: NULL);
>>
>>         init.num_parents = (parent_name ? 1 : 0);
>>
>> diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
>> index fd36a8e..508c032 100644
>> --- a/drivers/clk/clk-mux.c
>> +++ b/drivers/clk/clk-mux.c
>> @@ -106,7 +106,7 @@ struct clk *clk_register_mux(struct device *dev, const
>> char *name,
>>
>>         init.name = name;
>>         init.ops =&clk_mux_ops;
>> -       init.flags = flags;
>> +       init.flags = flags | CLK_IS_BASIC;
>>         init.parent_names = parent_names;
>>         init.num_parents = num_parents;
>>
>> diff --git a/include/linux/clk-private.h b/include/linux/clk-private.h
>> index 2479239..0835bda 100644
>> --- a/include/linux/clk-private.h
>> +++ b/include/linux/clk-private.h
>> @@ -64,7 +64,7 @@ struct clk {
>>                 .parent_names = _parent_names,                  \
>>                 .num_parents = ARRAY_SIZE(_parent_names),       \
>>                 .parents = _parents,                            \
>> -               .flags = _flags,                                \
>> +               .flags = _flags | CLK_IS_BASIC,                 \
>>         }
>>
>>   #define DEFINE_CLK_FIXED_RATE(_name, _flags, _rate,           \
>> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
>> index aa63aca..4b94f59 100644
>> --- a/include/linux/clk-provider.h
>> +++ b/include/linux/clk-provider.h
>> @@ -25,6 +25,7 @@
>>   #define CLK_SET_RATE_PARENT   BIT(2) /* propagate rate change up one
>> level */
>>   #define CLK_IGNORE_UNUSED     BIT(3) /* do not gate even if unused */
>>   #define CLK_IS_ROOT           BIT(4) /* root clk, has no parent */
>> +#define CLK_IS_BASIC           BIT(5) /* Basic clk, can't do a
>> to_clk_foo() */
>>
>>   struct clk_hw;
>>
>
