From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCHv2 04/19] ARM: OMAP4: PM: save/restore all DPLL settings in
 OFF mode
Date: Wed, 30 May 2012 13:24:17 -0500
Message-ID: <CAOMWX4ewVauzYW9pJq07=moLcgkBLyvx68o7T8975cGvshfK3Q@mail.gmail.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
 <1336990730-26892-5-git-send-email-t-kristo@ti.com> <87d363928g.fsf@ti.com>
 <CAMQu2gw5myvyvM8x225KnN59vEYBYLBiEsvML8RAoE0t+RrbYA@mail.gmail.com>
 <CAMQu2gywor2o+g8Fn80ogbTtEZPSXM74M65GsO2zH44tg-W7gQ@mail.gmail.com>
 <CAOMWX4ctJcfGNxXK4hT+QH-m7zUfP1N3H56oVDVzPFmhVTFOMw@mail.gmail.com> <87wr3t8s81.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:43967 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751179Ab2E3SYk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 May 2012 14:24:40 -0400
Received: by wgbfg15 with SMTP id fg15so98381wgb.35
        for <linux-omap@vger.kernel.org>; Wed, 30 May 2012 11:24:38 -0700 (PDT)
In-Reply-To: <87wr3t8s81.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, paul@pwsan.com, Rajendra Nayak <rnayak@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, May 30, 2012 at 12:59 PM, Kevin Hilman <khilman@ti.com> wrote:
> "Menon, Nishanth" <nm@ti.com> writes:
>
>> On Thu, May 17, 2012 at 3:52 AM, Shilimkar, Santosh
>> <santosh.shilimkar@ti.com> wrote:
>>> On Thu, May 17, 2012 at 12:34 PM, Shilimkar, Santosh
>>> <santosh.shilimkar@ti.com> wrote:
>>>> On Thu, May 17, 2012 at 4:12 AM, Kevin Hilman <khilman@ti.com> wro=
te:
>>>>> Tero Kristo <t-kristo@ti.com> writes:
>>>>>
>> [...]
>>>>> - Rather than hooking into omap4_enter_lowpower(), should use
>>>>> =A0the cluster PM enter/exit notifier chain.
>>>>>
>>>> This is again specific to device OFF only and not related to CPU
>>>> cluster state as such. So I don't think notifiers should be used h=
ere.
>>>>
>>>> O.w even when we attempt just MPU OSWR C-state, all these function=
s will
>>>> get called in notifier chain.
>>>>
>>> Just a thought, we can have a separate notifier chain for device OF=
=46. It can
>>> allow use to get rid of 'enable_off_mode" kind of flags and can be
>>> used by many drivers too.
>>
>> Like the overall idea, but one minor dumb concern might be sequencin=
g
>> of notifiers
>> =A0- OFF entry and restore needs things to be executed in a specific=
 sequence.
>> How do we plan to ensure the sequence is maintained in a notifier ca=
ll
>> chain? one
>> possible option might be a "priority" based scheme?
>
> Or just combine the events that need a specific sequence into single
> notifier callback function.
There is other issues in case of failure cases -> abort of OFF
sequence due to pending interrupt
detected as part of a notifier - error handling needs to be sane in
proper sequence.
I understand and appreciate the intent of replacing the single mega
enter_sleep with a chain of notifiers
but any such option will need to be scalable enough to handle weird
erratum handling (HSI CAWAKE as an example)
which potentially break the logic flow and be either be equal or
better than what we have today interms of
error handling. since these notifiers will be triggered for
CPUIDLE(performance sensitive) and suspend, the intricacies
might be better understood by seeing how this proposed notifiers look l=
ike.

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
