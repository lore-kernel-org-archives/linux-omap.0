From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH V2 4/4] ARM: OMAP3+: PM: VP: ensure VP is idle before disable
Date: Mon, 04 Jun 2012 09:49:52 -0700
Message-ID: <87vcj7f2dr.fsf@ti.com>
References: <1338514899-3560-1-git-send-email-nm@ti.com>
	<1338514899-3560-5-git-send-email-nm@ti.com> <87sjeesq11.fsf@ti.com>
	<CAOMWX4fyJNtjm+kGgY=5yWaMeSAEYMTxuzyyrQibcH3=3wfMoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:53319 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751414Ab2FDQtz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Jun 2012 12:49:55 -0400
Received: by dajz8 with SMTP id z8so9447077daj.16
        for <linux-omap@vger.kernel.org>; Mon, 04 Jun 2012 09:49:54 -0700 (PDT)
In-Reply-To: <CAOMWX4fyJNtjm+kGgY=5yWaMeSAEYMTxuzyyrQibcH3=3wfMoA@mail.gmail.com>
	(Nishanth Menon's message of "Fri, 1 Jun 2012 17:57:59 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Wenbiao Wang <wwang@ti.com>, Tony Lindgren <tony@atomide.com>

"Menon, Nishanth" <nm@ti.com> writes:

> Regards,
> Nishanth Menon
>
>
> On Fri, Jun 1, 2012 at 4:03 PM, Kevin Hilman <khilman@ti.com> wrote:
>> Nishanth Menon <nm@ti.com> writes:
>>
>>> From: Wenbiao Wang <wwang@ti.com>
>>>
>>> Voltage Processor state machine transition to disable need to
>>> occur from IDLE state. When we transition OPP in a functioning
>>> system, the call sequence for an OPP transition is as follows:
>>> omap_sr_disable
>>> =C2=A0 =C2=A0 =C2=A0 -> sr class 3 disable
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-> vp disable
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-> sr disable
>>> forceupdate to voltage/frequency scale depending on which OPP
>>> we are transitioning to.
>>>
>>> If we hit a critical timing window where SR had commanded VP
>>> for a voltage transition and VP is in the middle of operating
>>> on that command, it needs to go through a few states before
>>> going to update state(where it actually sends the command to
>>> VC). Initial view of h/w owners is that the state disable of VP
>>> is expected to be sampled for the next transition.
>>>
>>> Instead, to be on a safer side, we ensure that the valid states
>>> of the VP state machine is diligently followed by software. This
>>> can be done by waiting for VP to be in idle =C2=A0prior to disablin=
g
>>> VP. Existing prints have been updated to ensure context is
>>> available on error messages.
>>>
>>> As part of this change, increase timeout for VP idle check to
>>> improbable 500uSec to be certain that system is indeed unable
>>> to continue before crashing out with error(worst case expectancy
>>> remains the same 3-100uSec depending on when we caught VP).
>>>
>>> Cc: Tony Lindgren <tony@atomide.com>
>>> Cc: Kevin Hilman <khilman@ti.com>
>>>
>>> [nm@ti.com: port from android]
>>
>> and you also convert to use new _vp_wait_for_idle()
>>
>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>> Signed-off-by: Wenbiao Wang <wwang@ti.com>
>>> ---
>>> =C2=A0arch/arm/mach-omap2/vp.c | =C2=A0 =C2=A04 ++++
>>> =C2=A0arch/arm/mach-omap2/vp.h | =C2=A0 =C2=A05 +++--
>>> =C2=A02 files changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
>>> index 2a8a085..9a72deb 100644
>>> --- a/arch/arm/mach-omap2/vp.c
>>> +++ b/arch/arm/mach-omap2/vp.c
>>> @@ -308,6 +308,10 @@ void omap_vp_disable(struct voltagedomain *vol=
tdm)
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>>> =C2=A0 =C2=A0 =C2=A0 }
>>>
>>> + =C2=A0 =C2=A0 if (_vp_wait_for_idle(voltdm, vp)) {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_warn_ratelimited("%s=
: vdd_%s timedout!Ignore and try\n",
>>
>> s/timedout/timed out/
>> no space after '!',
> Kinda wanted to stay under 80 character and not split string out to
> two lines and make sparse angry, yet did not want to loose informatio=
n
> which was being presented out.

Readable error messages are more important.

>> also I don't get the "Ignore and try" part
>
> if we fail, just try the disable anyways..=20
> (at least till we have
> voltage processor recovery mechanism(cold reset) introduced upstream =
-
> the intent of the patch was not to introduce a recovery mechanism, bu=
t
> to ensure proper checkpoint is in place)..

I understand.  My complaint is only about the readability of the error
messages.  Seeing this go by:

        omap_vp_disable: vdd_mpu timedout!Ignore and try

in the kernel logs will still make me ask "try what?"  IMO, it should s=
ay

        omap_vp_disable: WARNING: vdd_mpu timed out, ignoring.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
