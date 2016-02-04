From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 3/3] ARM: OMAP2+: remove misuse of IRQF_NO_SUSPEND flag
Date: Thu, 4 Feb 2016 13:34:28 +0000
Message-ID: <56B35364.8090104@arm.com>
References: <1454351299-27440-1-git-send-email-sudeep.holla@arm.com>
 <1454351299-27440-4-git-send-email-sudeep.holla@arm.com>
 <56B34EB7.4080005@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <56B34EB7.4080005@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, Sudeep Holla <sudeep.holla@arm.com>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-omap@vger.kernel.org



On 04/02/16 13:14, Grygorii Strashko wrote:
> Hi Sudeep,
>
> On 02/01/2016 08:28 PM, Sudeep Holla wrote:
>> The IRQF_NO_SUSPEND flag is used to identify the interrupts that should
>> be left enabled so as to allow them to work as expected during the
>> suspend-resume cycle, but doesn't guarantee that it will wake the system
>> from a suspended state, enable_irq_wake is recommended to be used for
>> the wakeup.
>>
>> This patch removes the use of IRQF_NO_SUSPEND flags replacing it with
>> enable_irq_wake instead.
>
> And sorry for delayed reply - I've spent some time investigating it, but
> It was during Christmas holidays and finally I lost track of it :)
>

That's fine, usually that's the case in general will all of us :)

[..]
>
> Another option is to convert omap_prcm_irq_handler to the generic handler
> (now chained) and, probably, make it threaded and all cascaded IRQs as
> nested threaded (this is just a theory).
>

Since I don't have any knowledge of OMAP, I will completely depend on
your for anything OMAP specific.

> I'll be on business trip next two weeks and will not be able to help more with it
> Sorry.
>

No problem, let me know once you get a chance to try out things at your end.

-- 
Regards,
Sudeep
