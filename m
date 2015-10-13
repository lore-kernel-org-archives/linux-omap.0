From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 12/17] ARM: OMAP2+: remove misuse of IRQF_NO_SUSPEND flag
Date: Tue, 13 Oct 2015 16:20:15 +0100
Message-ID: <561D212F.3050603@arm.com>
References: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
 <1442850433-5903-13-git-send-email-sudeep.holla@arm.com>
 <20151012202047.GR23801@atomide.com> <20151012202847.GS23801@atomide.com>
 <561CE017.7030704@arm.com> <20151013145359.GV23801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151013145359.GV23801@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-pm@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On 13/10/15 15:53, Tony Lindgren wrote:
> * Sudeep Holla <sudeep.holla@arm.com> [151013 03:46]:
>>
>>
>> On 12/10/15 21:28, Tony Lindgren wrote:
>>> * Tony Lindgren <tony@atomide.com> [151012 13:27]:
>>>> * Sudeep Holla <sudeep.holla@arm.com> [150921 08:52]:
>>>>> The IRQF_NO_SUSPEND flag is used to identify the interrupts that should
>>>>> be left enabled so as to allow them to work as expected during the
>>>>> suspend-resume cycle, but doesn't guarantee that it will wake the system
>>>> >from a suspended state, enable_irq_wake is recommended to be used for
>>>>> the wakeup.
>>>>>
>>>>> This patch removes the use of IRQF_NO_SUSPEND flags replacing it with
>>>>> enable_irq_wake instead.
>>>>
>>>> Applying into omap-for-v4.4/cleanup thanks.
>>>
>>> Actually I don't think this does the right thing. The interrupts
>>> in the $subject patch are in the always on powerdomain, and we really
>>
>> Agreed
>>
>>> want them to be excluded from the suspend.
>>>
>>
>> OK but what's wrong with this patch. At-least the name suggest it's a
>> wakeup interrupt. And using IRQF_NO_SUSPEND for the wakeup interrupt is
>> simply wrong.
>
> Hmm so if we have a separate always on irq controller for the wake-up events
> and we want to keep it always on and exclude it from any suspend related
> things.. Why would we not use IRQF_NO_SUSPEND on it?
>
> Above you say "The IRQF_NO_SUSPEND flag is used to identify the interrupts
> that should be left enabled so as to allow them to work as expected during
> the suspend-resume cycle..." and that's exactly what we want to do here :)
>

OK if these interrupts meet that criteria to use IRQF_NO_SUSPEND, then
it should be fine, my earlier argument was based on the assumption that
it's just another wakeup interrupt.

> For the dedicated wake-up interrupts, we have separate registers to enable
> and disable them. The $subject irq is the shared interrupt that allows
> making use of the pin specific wake-up interrupts, and for those yes we
> are using enable_irq_wake().
>

If it's already take care, then fine. I am just hunting all the misuse
of IRQF_NO_SUSPEND flag especially as wakeup source and fixing them

>>> So not applying without further explanations.
>>>
>>
>> But I don't understand the real need for IRQF_NO_SUSPEND over wakeup APIs ?
>
> Because in the $subject case we just want to always keep it on and
> never suspend it. It's unrelated to the wakeup APIs at least for the
> omap related SoCs.
>

OK, understood now. Thanks

--
Regards,
Sudeep
