From: "Hilman, Kevin" <khilman@ti.com>
Subject: Re: pm_runtime_suspended() can be false if RPM_SUSPENDED
Date: Mon, 11 Jul 2011 13:34:05 -0700
Message-ID: <CALyTGOANs9ZUKmWH43s7H1Aod-y=jAueo045yzao66ze7Wko5g@mail.gmail.com>
References: <871uy0733n.fsf@ti.com>
	<201107112202.48280.rjw@sisk.pl>
	<874o2sy3p9.fsf@ti.com>
	<201107112222.18917.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:44426 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751931Ab1GKUeI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jul 2011 16:34:08 -0400
Received: by mail-bw0-f42.google.com with SMTP id 19so1194739bwa.29
        for <linux-omap@vger.kernel.org>; Mon, 11 Jul 2011 13:34:06 -0700 (PDT)
In-Reply-To: <201107112222.18917.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Linux OMAP <linux-omap@vger.kernel.org>

On Mon, Jul 11, 2011 at 1:22 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Monday, July 11, 2011, Kevin Hilman wrote:
>> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
>>
>> [...]
>>
>> >>
>> >> However, based on the pm_runtime_set_active() problem you mention=
ed
>> >> above, I'm not sure this will help either, since what the PM doma=
in's
>> >> noirq callback will want to do will be based on the actual device
>> >> hardware state, not on the PM core's view of the device state.
>> >
>> > Yes. =A0For devices whose runtime PM is never enabled, this is qui=
te clear
>> > (we must assume they are operational). =A0For devices whose runtim=
e PM is
>> > temporarily disabled and the reenabled, it's not that clear, but a=
t
>> > least for the system suspend case we may require drivers not to us=
e
>> > pm_runtime_set_active/suspended() in their callbacks, so that we m=
ay
>> > assume that the status hasn't changed between .suspend() and .resu=
me().
>> >
>> > So, I think your approach (to check power.runtime_status) is corre=
ct in this
>> > respect.
>>
>> OK, I'll just directly check power.runtime_status in the noirq metho=
ds,
>> since at that point I always know that disable_depth > 0.
>
> That's what I wanted to say. :-) =A0The only problem with that is if
> CONFIG_PM_RUNTIME is unset, power.runtime_status is not present, so I=
 think
> we'll need a static inline to work around that.
>

OK, I can prepare a patch for a static inline for
pm_runtime_status_suspended(), unless you have one already in
progress.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
