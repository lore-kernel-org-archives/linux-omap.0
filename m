From: Kim Kyuwon <chammoru@gmail.com>
Subject: Re: [PATCH] OMAP3: PM: Add the wakeup source driver, v3
Date: Tue, 5 May 2009 18:08:50 +0900
Message-ID: <4d34a0a70905050208u5f64957drda5298cae027e550@mail.gmail.com>
References: <4d34a0a70904030343h4f1562b5y3dbc9467aac9967@mail.gmail.com>
	<87tz4i981a.fsf@deeprootsystems.com> <4d34a0a70904300017p1ff38048oae675a4e93e68124@mail.gmail.com>
	<87my9yte7e.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f133.google.com ([209.85.221.133]:59575 "EHLO
	mail-qy0-f133.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050AbZEEJOI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 May 2009 05:14:08 -0400
Received: by qyk39 with SMTP id 39so1101693qyk.33
        for <linux-omap@vger.kernel.org>; Tue, 05 May 2009 02:14:08 -0700 (PDT)
In-Reply-To: <87my9yte7e.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: OMAP <linux-omap@vger.kernel.org>, =?EUC-KR?B?udqw5rnO?= <kyungmin.park@samsung.com>, Paul Walmsley <paul@pwsan.com>

On Thu, Apr 30, 2009 at 11:21 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
>>> Also, I still think the WKST register reading should be done in the
>>> PRCM interrupt handler.  In your previous attempt, you were seeing =
a
>>> bunch of non-device wakeup related interrupts.   Can you try again
>>> with the attached patch (thanks to Paul Walmseley) which should hel=
p
>>> us debug why you were seeing spurious PRCM interrupts.
>>
>> First of all, sorry for giving you the wrong information in the
>> previous mail. I found that we actually have configured GPTIMER12 as
>> the system timer.  And I tried with the attached patch, but I can't
>> see any debug message.  However even now, PRCM interrupt handler is
>> invoked quite often due to the system timer.
>
> That's what I assumed was happening.
>
>> As far as I know, after Peter's [OMAP3: PM: CPUidle: Add new
>> lower-latency C1 state] patch is applied, the system is in 'wfi' sta=
te
>> in every idle state. So whenever the system timer wake up the system
>> from idle, I think PRCM interrupt occurs. Do you think still the WKS=
T
>> register should be read in the PRCM interrupt handler? ;)
>
> Yes. The WKST registers are already being read in the handler so they
> can be properly cleared.  All you are adding is the saving of them.
>
> In addition, you should not enter idle between the time the system
> wakes from resume and your resume handler runs so you should be able
> to get the correct WKST values.

OK, Your idea is more reasonable.
I modified as you said. thanks.

>>> Also, I know we discussed this before, but I think the GPIO wakeup
>>> source stuff really belongs in a separate patch, and if you think i=
t
>>> is still useful, and cannot be done by just enabling a GPIO IRQ fro=
m
>>> the board file, I suggest you propose a patch to the generic GPIO
>>> layer to add this interface.
>>
>> OK, I will remove this GPIO wakeup feature. But I want to know more
>> detailed information about wakeup event . So, instead of using the
>> GPIO wakeup, I'm planning using WAKEUPEVENT bit in CONTROL_PADCONF_x
>> registers.
>
> That sounds OK.  The current mux layer is lacking any knowledge of th=
e
> wake bits in the PADCONF regs, so I'd be interested in any ideas you
> have of adding that support.

I added my ideas about CONTROL_PADCONF_x into the new version of wake
source driver.
I will send it soon.
Please review this new version again and feel free to give your opinion=
=2E

Regards,
Kyuwon (=B1=D4=BF=F8)
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
