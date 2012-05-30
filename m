From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv2 04/19] ARM: OMAP4: PM: save/restore all DPLL settings in OFF mode
Date: Wed, 30 May 2012 15:09:49 -0700
Message-ID: <87mx4p5niq.fsf@ti.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
	<1336990730-26892-5-git-send-email-t-kristo@ti.com>
	<87d363928g.fsf@ti.com>
	<CAMQu2gw5myvyvM8x225KnN59vEYBYLBiEsvML8RAoE0t+RrbYA@mail.gmail.com>
	<CAMQu2gywor2o+g8Fn80ogbTtEZPSXM74M65GsO2zH44tg-W7gQ@mail.gmail.com>
	<CAOMWX4ctJcfGNxXK4hT+QH-m7zUfP1N3H56oVDVzPFmhVTFOMw@mail.gmail.com>
	<87wr3t8s81.fsf@ti.com>
	<CAOMWX4ewVauzYW9pJq07=moLcgkBLyvx68o7T8975cGvshfK3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:35555 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754812Ab2E3WJw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 May 2012 18:09:52 -0400
Received: by dacx6 with SMTP id x6so464111dac.17
        for <linux-omap@vger.kernel.org>; Wed, 30 May 2012 15:09:51 -0700 (PDT)
In-Reply-To: <CAOMWX4ewVauzYW9pJq07=moLcgkBLyvx68o7T8975cGvshfK3Q@mail.gmail.com>
	(Nishanth Menon's message of "Wed, 30 May 2012 13:24:17 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, paul@pwsan.com, Rajendra Nayak <rnayak@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

"Menon, Nishanth" <nm@ti.com> writes:

> On Wed, May 30, 2012 at 12:59 PM, Kevin Hilman <khilman@ti.com> wrote=
:
>> "Menon, Nishanth" <nm@ti.com> writes:
>>
>>> On Thu, May 17, 2012 at 3:52 AM, Shilimkar, Santosh
>>> <santosh.shilimkar@ti.com> wrote:
>>>> On Thu, May 17, 2012 at 12:34 PM, Shilimkar, Santosh
>>>> <santosh.shilimkar@ti.com> wrote:
>>>>> On Thu, May 17, 2012 at 4:12 AM, Kevin Hilman <khilman@ti.com> wr=
ote:
>>>>>> Tero Kristo <t-kristo@ti.com> writes:
>>>>>>
>>> [...]
>>>>>> - Rather than hooking into omap4_enter_lowpower(), should use
>>>>>> =C2=A0the cluster PM enter/exit notifier chain.
>>>>>>
>>>>> This is again specific to device OFF only and not related to CPU
>>>>> cluster state as such. So I don't think notifiers should be used =
here.
>>>>>
>>>>> O.w even when we attempt just MPU OSWR C-state, all these functio=
ns will
>>>>> get called in notifier chain.
>>>>>
>>>> Just a thought, we can have a separate notifier chain for device O=
=46F. It can
>>>> allow use to get rid of 'enable_off_mode" kind of flags and can be
>>>> used by many drivers too.
>>>
>>> Like the overall idea, but one minor dumb concern might be sequenci=
ng
>>> of notifiers
>>> =C2=A0- OFF entry and restore needs things to be executed in a spec=
ific sequence.
>>> How do we plan to ensure the sequence is maintained in a notifier c=
all
>>> chain? one
>>> possible option might be a "priority" based scheme?
>>
>> Or just combine the events that need a specific sequence into single
>> notifier callback function.
> There is other issues in case of failure cases -> abort of OFF
> sequence due to pending interrupt
> detected as part of a notifier - error handling needs to be sane in
> proper sequence.
> I understand and appreciate the intent of replacing the single mega
> enter_sleep with a chain of notifiers
> but any such option will need to be scalable enough to handle weird
> erratum handling (HSI CAWAKE as an example)
> which potentially break the logic flow and be either be equal or
> better than what we have today interms of
> error handling. since these notifiers will be triggered for
> CPUIDLE(performance sensitive) and suspend, the intricacies
> might be better understood by seeing how this proposed notifiers look=
 like.

Makes sense.  Thanks for clarifying.

What $SUBJECT series proposed was indeed a "mega function", but one tha=
t
was just a list of function calls with no error checking or recovery,
and no documentation/description about dependencies/sequencing etc. etc=
=2E
Based on the patches at hadn (which is all reviewers have to go on),
notifiers seemed to be a good fit.

If there are good reasons that all of the device-off events need to be
coordinated/synchronized/sequenced (and it sounds like there are, thank=
s
for pointing them out), I am not opposed to that approach.  It simply
needs to be well described in the changlog.

Thanks,

Kevin





--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
