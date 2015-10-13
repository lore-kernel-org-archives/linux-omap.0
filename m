From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 12/17] ARM: OMAP2+: remove misuse of IRQF_NO_SUSPEND flag
Date: Tue, 13 Oct 2015 11:42:31 +0100
Message-ID: <561CE017.7030704@arm.com>
References: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
 <1442850433-5903-13-git-send-email-sudeep.holla@arm.com>
 <20151012202047.GR23801@atomide.com> <20151012202847.GS23801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151012202847.GS23801@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On 12/10/15 21:28, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [151012 13:27]:
>> * Sudeep Holla <sudeep.holla@arm.com> [150921 08:52]:
>>> The IRQF_NO_SUSPEND flag is used to identify the interrupts that should
>>> be left enabled so as to allow them to work as expected during the
>>> suspend-resume cycle, but doesn't guarantee that it will wake the system
>>> from a suspended state, enable_irq_wake is recommended to be used for
>>> the wakeup.
>>>
>>> This patch removes the use of IRQF_NO_SUSPEND flags replacing it with
>>> enable_irq_wake instead.
>>
>> Applying into omap-for-v4.4/cleanup thanks.
>
> Actually I don't think this does the right thing. The interrupts
> in the $subject patch are in the always on powerdomain, and we really

Agreed

> want them to be excluded from the suspend.
>

OK but what's wrong with this patch. At-least the name suggest it's a
wakeup interrupt. And using IRQF_NO_SUSPEND for the wakeup interrupt is
simply wrong.

> So not applying without further explanations.
>

But I don't understand the real need for IRQF_NO_SUSPEND over wakeup APIs ?

-- 
Regards,
Sudeep
