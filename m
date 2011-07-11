From: "Hilman, Kevin" <khilman@ti.com>
Subject: Re: pm_runtime_suspended() can be false if RPM_SUSPENDED
Date: Mon, 11 Jul 2011 15:50:50 -0700
Message-ID: <CALyTGOCdYb8eMGh9UFdmQkOvJhZUd3638tMb2DQXOF6_W6zovQ@mail.gmail.com>
References: <871uy0733n.fsf@ti.com>
	<201107112222.18917.rjw@sisk.pl>
	<CALyTGOANs9ZUKmWH43s7H1Aod-y=jAueo045yzao66ze7Wko5g@mail.gmail.com>
	<201107120036.49823.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:50587 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758150Ab1GKWuw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jul 2011 18:50:52 -0400
Received: by mail-bw0-f44.google.com with SMTP id 17so3623826bwb.3
        for <linux-omap@vger.kernel.org>; Mon, 11 Jul 2011 15:50:50 -0700 (PDT)
In-Reply-To: <201107120036.49823.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Linux OMAP <linux-omap@vger.kernel.org>

On Mon, Jul 11, 2011 at 3:36 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Monday, July 11, 2011, Hilman, Kevin wrote:
>> On Mon, Jul 11, 2011 at 1:22 PM, Rafael J. Wysocki <rjw@sisk.pl> wro=
te:
>> > On Monday, July 11, 2011, Kevin Hilman wrote:
>> >> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
>> >>
>> >> [...]
>> >>
>> >> >>
>> >> >> However, based on the pm_runtime_set_active() problem you ment=
ioned
>> >> >> above, I'm not sure this will help either, since what the PM d=
omain's
>> >> >> noirq callback will want to do will be based on the actual dev=
ice
>> >> >> hardware state, not on the PM core's view of the device state.
>> >> >
>> >> > Yes. =A0For devices whose runtime PM is never enabled, this is =
quite clear
>> >> > (we must assume they are operational). =A0For devices whose run=
time PM is
>> >> > temporarily disabled and the reenabled, it's not that clear, bu=
t at
>> >> > least for the system suspend case we may require drivers not to=
 use
>> >> > pm_runtime_set_active/suspended() in their callbacks, so that w=
e may
>> >> > assume that the status hasn't changed between .suspend() and .r=
esume().
>> >> >
>> >> > So, I think your approach (to check power.runtime_status) is co=
rrect in this
>> >> > respect.
>> >>
>> >> OK, I'll just directly check power.runtime_status in the noirq me=
thods,
>> >> since at that point I always know that disable_depth > 0.
>> >
>> > That's what I wanted to say. :-) =A0The only problem with that is =
if
>> > CONFIG_PM_RUNTIME is unset, power.runtime_status is not present, s=
o I think
>> > we'll need a static inline to work around that.
>> >
>>
>> OK, I can prepare a patch for a static inline for
>> pm_runtime_status_suspended(), unless you have one already in
>> progress.
>
> No, I don't, please send me one if you can. :-)
>

OK, coming right up...
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
