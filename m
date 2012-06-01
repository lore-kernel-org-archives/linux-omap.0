From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH V2 4/4] ARM: OMAP3+: PM: VP: ensure VP is idle before disable
Date: Fri, 1 Jun 2012 17:57:59 -0500
Message-ID: <CAOMWX4fyJNtjm+kGgY=5yWaMeSAEYMTxuzyyrQibcH3=3wfMoA@mail.gmail.com>
References: <1338514899-3560-1-git-send-email-nm@ti.com> <1338514899-3560-5-git-send-email-nm@ti.com>
 <87sjeesq11.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog135.obsmtp.com ([74.125.149.84]:33185 "EHLO
	na3sys009aog135.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965935Ab2FAW6W convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jun 2012 18:58:22 -0400
Received: by wibhm14 with SMTP id hm14so810034wib.12
        for <linux-omap@vger.kernel.org>; Fri, 01 Jun 2012 15:58:19 -0700 (PDT)
In-Reply-To: <87sjeesq11.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Wenbiao Wang <wwang@ti.com>, Tony Lindgren <tony@atomide.com>

Regards,
Nishanth Menon


On Fri, Jun 1, 2012 at 4:03 PM, Kevin Hilman <khilman@ti.com> wrote:
> Nishanth Menon <nm@ti.com> writes:
>
>> From: Wenbiao Wang <wwang@ti.com>
>>
>> Voltage Processor state machine transition to disable need to
>> occur from IDLE state. When we transition OPP in a functioning
>> system, the call sequence for an OPP transition is as follows:
>> omap_sr_disable
>> =A0 =A0 =A0 -> sr class 3 disable
>> =A0 =A0 =A0 =A0 =A0 =A0-> vp disable
>> =A0 =A0 =A0 =A0 =A0 =A0-> sr disable
>> forceupdate to voltage/frequency scale depending on which OPP
>> we are transitioning to.
>>
>> If we hit a critical timing window where SR had commanded VP
>> for a voltage transition and VP is in the middle of operating
>> on that command, it needs to go through a few states before
>> going to update state(where it actually sends the command to
>> VC). Initial view of h/w owners is that the state disable of VP
>> is expected to be sampled for the next transition.
>>
>> Instead, to be on a safer side, we ensure that the valid states
>> of the VP state machine is diligently followed by software. This
>> can be done by waiting for VP to be in idle =A0prior to disabling
>> VP. Existing prints have been updated to ensure context is
>> available on error messages.
>>
>> As part of this change, increase timeout for VP idle check to
>> improbable 500uSec to be certain that system is indeed unable
>> to continue before crashing out with error(worst case expectancy
>> remains the same 3-100uSec depending on when we caught VP).
>>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Kevin Hilman <khilman@ti.com>
>>
>> [nm@ti.com: port from android]
>
> and you also convert to use new _vp_wait_for_idle()
>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> Signed-off-by: Wenbiao Wang <wwang@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/vp.c | =A0 =A04 ++++
>> =A0arch/arm/mach-omap2/vp.h | =A0 =A05 +++--
>> =A02 files changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
>> index 2a8a085..9a72deb 100644
>> --- a/arch/arm/mach-omap2/vp.c
>> +++ b/arch/arm/mach-omap2/vp.c
>> @@ -308,6 +308,10 @@ void omap_vp_disable(struct voltagedomain *volt=
dm)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> =A0 =A0 =A0 }
>>
>> + =A0 =A0 if (_vp_wait_for_idle(voltdm, vp)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_warn_ratelimited("%s: vdd_%s timedout!I=
gnore and try\n",
>
> s/timedout/timed out/
> no space after '!',
Kinda wanted to stay under 80 character and not split string out to
two lines and make sparse angry, yet did not want to loose information
which was being presented out.

> also I don't get the "Ignore and try" part

if we fail, just try the disable anyways.. (at least till we have
voltage processor recovery mechanism(cold reset) introduced upstream -
the intent of the patch was not to introduce a recovery mechanism, but
to ensure proper checkpoint is in place)..

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __=
func__, voltdm->name);
>> + =A0 =A0 }
>> =A0 =A0 =A0 /* Disable VP */
>> =A0 =A0 =A0 vpconfig =3D voltdm->read(vp->vpconfig);
>> =A0 =A0 =A0 vpconfig &=3D ~vp->common->vpconfig_vpenable;
>> diff --git a/arch/arm/mach-omap2/vp.h b/arch/arm/mach-omap2/vp.h
>> index 4655b39..4b4eeb6 100644
>> --- a/arch/arm/mach-omap2/vp.h
>> +++ b/arch/arm/mach-omap2/vp.h
>> @@ -33,9 +33,10 @@ struct voltagedomain;
>> =A0/*
>> =A0 * Time out for Voltage processor in micro seconds. Typical laten=
cy is < 2uS,
>> =A0 * but worst case latencies could be around 3-200uS depending on =
where we
>> - * interrupted VP's operation.
>> + * interrupted VP's operation. Use an improbable timeout value to b=
e
>> + * sure that timeout events are beyond doubt.
>> =A0 */
>> -#define VP_IDLE_TIMEOUT =A0 =A0 =A0 =A0 =A0 =A0 =A0200
>> +#define VP_IDLE_TIMEOUT =A0 =A0 =A0 =A0 =A0 =A0 =A0500
>> =A0#define VP_TRANXDONE_TIMEOUT 300
>>
>> =A0/**
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
