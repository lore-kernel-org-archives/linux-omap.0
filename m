From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH] OMAP: add pwm driver using dmtimers.
Date: Thu, 13 Dec 2012 11:42:18 -0600
Message-ID: <50CA137A.5010304@ti.com>
References: <20121212192430.50cea126@notabene.brown> <50C8ABFC.3080309@ti.com> <20121213140635.4eda5858@notabene.brown> <20121213153302.05120a6d@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121213153302.05120a6d@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Thierry Reding <thierry.reding@avionic-design.de>, Grant Erickson <marathon96@gmail.com>, linux-omap@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


On 12/12/2012 10:33 PM, NeilBrown wrote:
> On Thu, 13 Dec 2012 14:06:35 +1100 NeilBrown <neilb@suse.de> wrote:
> 
>>>> +	omap_dm_timer_enable(omap->dm_timer);
>>>
>>> Do you need to call omap_dm_timer_enable here? _set_load and _set_match
>>> will enable the timer. So this should not be necessary.
>>
>> True.  That is what you get for copying someone else's code and not
>> understanding it fully.
> 
> However .... omap_dm_timer_write_counter *doesn't* enable the timer, and
> explicitly checks that it is already runtime-enabled.
> 
> Does that mean I don't need to call omap_dm_timer_write_counter here?  Or
> does it mean that I do need the enable/disable pair?

Typically, omap_dm_timer_write_counter() is used to update the counter
value while the counter is running and hence is enabled.

Looking at the code, some more I now see what they are trying to do. It
seems that they are trying to force an overflow to occur as soon as they
enable the timer. This will cause the timer to load the count value from
the timer load register into the timer counter register. So that does
make sense to me. However, this should not be necessary as
omap_dm_timer_set_load should do this for you. Therefore, I think that
you could accomplish the same thing by doing ...

omap_pwm_config
	--> omap_dm_timer_set_load()
	--> omap_dm_timer_set_match()
	--> omap_dm_timer_set_pwm()

omap_pwm_enable
	--> omap_dm_timer_start()

If we call _set_load in config then we don't need to call _load_start in
the enable, we can just call _start.

Can you try this and see if this is working ok?

Cheers
Jon
