From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: PM: Add the wakeup source driver, v3
Date: Thu, 30 Apr 2009 07:21:09 -0700
Message-ID: <87my9yte7e.fsf@deeprootsystems.com>
References: <4d34a0a70904030343h4f1562b5y3dbc9467aac9967@mail.gmail.com>
	<87tz4i981a.fsf@deeprootsystems.com>
	<4d34a0a70904300017p1ff38048oae675a4e93e68124@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:31749 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754368AbZD3OVM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Apr 2009 10:21:12 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1384834wfd.4
        for <linux-omap@vger.kernel.org>; Thu, 30 Apr 2009 07:21:12 -0700 (PDT)
In-Reply-To: <4d34a0a70904300017p1ff38048oae675a4e93e68124@mail.gmail.com> (Kim Kyuwon's message of "Thu\, 30 Apr 2009 16\:17\:38 +0900")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kim Kyuwon <chammoru@gmail.com>
Cc: OMAP <linux-omap@vger.kernel.org>, =?utf-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>, Paul Walmsley <paul@pwsan.com>

Kyuwon,

Kim Kyuwon <chammoru@gmail.com> writes:

> Hi Kevin,
> Thank you for showing steady interest in this driver.
>
> On Tue, Apr 21, 2009 at 9:15 AM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
>>
>> Hi Kyuwon,
>>
>> While I still like the concept of this driver, I'm still not quite
>> happy about how it is implemented for various reasons.  Most of which
>> have to do with the fact that this driver does many things that really
>> should be the job of other layers.  In particular, the list of
>> omap3_wake_events is a bit troubling.  It really should be handled by
>> the omapdev layer.  You'll see that you are duplicating the data that
>> is handled there.  Rather, we should just extend the omapdev data to
>> handle the wakeup events for that device.
>
> If you allow me to insert a new field whose name is "mask" in the
> omapdev struct, I think I can extend the omapdev to handle the wakeup
> events.

Extending omapdev would be fine.

>> Also, I still think the WKST register reading should be done in the
>> PRCM interrupt handler.  In your previous attempt, you were seeing a
>> bunch of non-device wakeup related interrupts.   Can you try again
>> with the attached patch (thanks to Paul Walmseley) which should help
>> us debug why you were seeing spurious PRCM interrupts.
>
> First of all, sorry for giving you the wrong information in the
> previous mail. I found that we actually have configured GPTIMER12 as
> the system timer.  And I tried with the attached patch, but I can't
> see any debug message.  However even now, PRCM interrupt handler is
> invoked quite often due to the system timer.

That's what I assumed was happening.

> As far as I know, after Peter's [OMAP3: PM: CPUidle: Add new
> lower-latency C1 state] patch is applied, the system is in 'wfi' state
> in every idle state. So whenever the system timer wake up the system
> from idle, I think PRCM interrupt occurs. Do you think still the WKST
> register should be read in the PRCM interrupt handler? ;)

Yes. The WKST registers are already being read in the handler so they
can be properly cleared.  All you are adding is the saving of them.

In addition, you should not enter idle between the time the system
wakes from resume and your resume handler runs so you should be able
to get the correct WKST values.

>> Also, I know we discussed this before, but I think the GPIO wakeup
>> source stuff really belongs in a separate patch, and if you think it
>> is still useful, and cannot be done by just enabling a GPIO IRQ from
>> the board file, I suggest you propose a patch to the generic GPIO
>> layer to add this interface.
>
> OK, I will remove this GPIO wakeup feature. But I want to know more
> detailed information about wakeup event . So, instead of using the
> GPIO wakeup, I'm planning using WAKEUPEVENT bit in CONTROL_PADCONF_x
> registers.

That sounds OK.  The current mux layer is lacking any knowledge of the
wake bits in the PADCONF regs, so I'd be interested in any ideas you
have of adding that support.

Kevin

