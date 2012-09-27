From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v7 08/11] ARM: OMAP2+: gpmc: generic timing calculation
Date: Thu, 27 Sep 2012 10:16:12 -0500
Message-ID: <50646DBC.5090809@ti.com>
References: <cover.1348058726.git.afzal@ti.com> <6b20c05230f22380802936f83377e94823488fa8.1348058726.git.afzal@ti.com> <5063C6E6.50109@ti.com> <C8443D0743D26F4388EA172BF4E2A7A93E9EA17D@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52750 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754331Ab2I0PQV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Sep 2012 11:16:21 -0400
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E9EA17D@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Afzal,

On 09/27/2012 05:07 AM, Mohammed, Afzal wrote:
> Hi Jon,
> 
> On Thu, Sep 27, 2012 at 08:54:22, Hunter, Jon wrote:
>> On 09/19/2012 08:23 AM, Afzal Mohammed wrote:
> 
>>> +Dependency of peripheral timings on gpmc timings:
>>> +
>>> +cs_on: t_ceasu
>>
>> Thanks for adding these details. Could be good to clarify that the
>> left-hand side parameters are the gpmc register fields and the
>> right-hand side are the timing parameters these are calculated using.
> 
> Ok
> 
>>
>> Also, given that this is in documentation for completeness it could be
>> good to somewhere state what "t_ceasu" means. For the gpmc register
>> field description may be we could give a reference to an OMAP document.
> 
> Yes, it has been mentioned, as quoted below, reason it has not been
> mentioned here is to avoid duplication. I will add TRM reference.
> 
> "
>>> +Note: Many of gpmc timings are dependent on other gpmc timings (a few
> 
>>> +mentioned above, refer timing routine for more details. To know what
>>> +these peripheral timings correspond to, please see explanations in
>>> +struct gpmc_device_timings definition.
> 
>>> +struct gpmc_device_timings {
>>> +	u32 t_ceasu;	/* address setup to CS valid */
> "
> 
>>> +adv_rd_off: t_avdp_r, t_avdh(s*)
>>> +oe_on: t_oeasu, t_aavdh(a**), t_ach(s), cyc_aavdh_oe(s)
>>
>> Would it be better to have ...
>>
>> oe_on (sync):	t_oeasu, t_ach(*), cyc_aavdh_oe
>> oe_on (async):	t_oeasu, t_aavdh(*)
> 
> Ok
> 
>> * - optional
>>
>> I assume that the hold times from the clock (t_ach and t_aavdh) are used
>> for fine tuning if the peripheral requires this, but a user adding a new
>> device would not be required to specify these, where as t_oeasu is
>> mandatory.
> 
> It depends on the peripheral, t_oeasu in not used for OneNAND, tusb sync,
> so I prefer not mentioning any timing as optional or mandatory.

Ok.

>> Or maybe should the timings be grouped as ...
>>
>> General
>> Read Async
>> Read Async Address/Data Multiplexed
>> Read Sync
>> Read Sync Address/Data Multiplexed
>> Write Async
>> Write Async Address/Data Multiplexed
>> Write Sync
>> Write Sync Address/Data Multiplexed
>>
>> There may be some duplication but it will be clear where things like ADV
>> timing applies.
> 
> I would prefer to keep it concise, but no strong opinion on it, if you
> prefer as above, I will change it.

I think that if these represent the main use-case configurations this
could add some value.

>>> +/* can the cycles be avoided ? */
>>
>> Nit should this be marked with a TODO?
> 
>>> +	/* mux check required ? */
>>
>> Nit should this be marked with a TODO?
> 
> Marking XXX should Ok, right ?, reason is that they are not
> kept as TODO, but rather as pointers to may be possible
> improvements

Sure, I don't have strong feelings about it but I would hope that at
some point this comment be removed.

>>> +	gpmc_t->adv_rd_off = gpmc_round_ps_to_ticks(temp);
> 
>> Any reason why we can't return ns in the above function? Or make this
>> function gpmc_round_ps_to_ns()? Then we could avoid having
>> gpmc_convert_ps_to_ns() below.
> 
> Calculation in ps is required to get more accurate results.
> 
> Calculating in ns was the reason for issue faced on N800 for Tony
> with previous version.
> 
> I will explain what would have happened with v6 on N800,
> i.e. using ns values,
> Based on logs from Tony, gpmc clk was 9ns, actually it would
> have been somewhere around 9115ps.
> 
> Take below timings of previous version in tusb async case
> 
>         gpmc_t->oe_on = gpmc_round_ps_to_ticks(temp) / 1000;
> 
>         /* access */
>         temp = max_t(u32, dev_t->t_iaa, /* remove t_iaa in async ? */
>                                 gpmc_t->oe_on * 1000 + dev_t->t_oe);
>         temp = max_t(u32, temp,
>                                 gpmc_t->cs_on * 1000 + dev_t->t_ce);
>         temp = max_t(u32, temp,
>                                 gpmc_t->adv_on * 1000 + dev_t->t_aa);
>         gpmc_t->access = gpmc_round_ps_to_ticks(temp) / 1000;
> 
> Upon calculating we get,
> 
> oe_on = 63805 / 1000 = 63
> 
> and for access (t_oe = 300, t_ce = t_aa = t_iaa = 0),
> 
> temp = 63 * 1000 + 300 = 63300
> access = 63300 / 1000 = 63
> 
> Here we get oe_on as well as access as 7 ticks, but access should
> have been 8 ticks, which is what we will get by using ps values,
> i.e. as in this version, as below,
> 
>         gpmc_t->oe_on = gpmc_round_ps_to_ticks(temp);
> 
>         /* access */
>         temp = max_t(u32, dev_t->t_iaa, /* remove t_iaa in async ? */
>                                 gpmc_t->oe_on + dev_t->t_oe);
>         temp = max_t(u32, temp,
>                                 gpmc_t->cs_on + dev_t->t_ce);
>         temp = max_t(u32, temp,
>                                 gpmc_t->adv_on + dev_t->t_aa);
>         gpmc_t->access = gpmc_round_ps_to_ticks(temp);
> 
> I believe it is always better to go with higher resolution.

Ok, thanks for clarifying.

>>> +	gpmc_convert_ps_to_ns(gpmc_t);
> 
>> I am wondering if we could avoid this above function and then ...
> 
> This will be removed once it is confirmed that all the peripherals
> using custom runtime calculation can work with this generic
> routine. Then all calculation would be purely in ps.

Ok, great. May be add a TODO here to make this clear that this is temporary.

> Right now converting ps to ns has been kept only to be compatible
> with custom routines and so that we can easily go back to custom
> routines in case of any issues, quoting relevant commit message below,
> 
> "
>     Timings are calculated in ps to prevent rounding errors and
>     converted to ns at final stage so that these values can be
>     directly fed to gpmc_cs_set_timings(). gpmc_cs_set_timings()
>     would be modified to take ps once all custom timing routines
>     are replaced by the generic routine, at the same time
>     generic timing routine would be modified to provide timings
>     in ps. struct gpmc_timings field types are upgraded from
>     u16 => u32 so that it can hold ps values.
> "

Ok.

>>> @@ -116,42 +116,103 @@ struct gpmc_timings {
> 
>>> -	u16 wr_access;		/* WRACCESSTIME */
>>> -	u16 wr_data_mux_bus;	/* WRDATAONADMUXBUS */
>>> +	u32 wr_access;		/* WRACCESSTIME */
>>> +	u32 wr_data_mux_bus;	/* WRDATAONADMUXBUS */
>>
>>  ... we could keep the above u16.
> 
> Due to the reasons mentioned above u32 is required.
> 
>>> +	u32 t_aavdh;	/* address hold time */
> 
>>> +	u32 t_iaa;	/* initial access time */
> 
>>> +	u32 t_oe;	/* access time from OE assertion */
> 
>>> +	u32 t_wpl;	/* write assertion time */
> 
>>> +	u8 cyc_aavdh_oe;
>>> +	u8 cyc_aavdh_we;
>>> +	u8 cyc_oe;
>>> +	u8 cyc_wpl;
>>> +	u32 cyc_iaa;
>>
>> May be I should look at an example, but it would be good to document
>> what these cyc_xxx parameters are/represent.
> 
> These are cycles counterpart of that of time, I will update it too.

Thanks!
Jon
