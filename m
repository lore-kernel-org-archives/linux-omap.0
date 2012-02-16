From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCHv2 8/8] arm: omap3: prevent per_clkdm from attempting
 manual domain transitions
Date: Thu, 16 Feb 2012 21:15:31 +0530
Message-ID: <CAMQu2gwMboftdRo9dE38ECp+5o2nTPgxeZ60JrbV0xd8HLNfUg@mail.gmail.com>
References: <1329320274-481-1-git-send-email-t-kristo@ti.com>
 <1329320274-481-9-git-send-email-t-kristo@ti.com> <87pqdf99c2.fsf@ti.com>
 <1329382652.4102.386.camel@sokoban> <CAMQu2gx5JdKfTTUhi28N_=EZ3tDo7nTRA00ErrMpuGMkOh9rgw@mail.gmail.com>
 <1329398159.4102.391.camel@sokoban> <1329405804.4102.400.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:37750 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751301Ab2BPPpw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Feb 2012 10:45:52 -0500
Received: by mail-yw0-f46.google.com with SMTP id o21so1630598yho.5
        for <linux-omap@vger.kernel.org>; Thu, 16 Feb 2012 07:45:51 -0800 (PST)
In-Reply-To: <1329405804.4102.400.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Thu, Feb 16, 2012 at 8:53 PM, Tero Kristo <t-kristo@ti.com> wrote:
> On Thu, 2012-02-16 at 15:15 +0200, Tero Kristo wrote:
>> On Thu, 2012-02-16 at 15:27 +0530, Shilimkar, Santosh wrote:
>> > On Thu, Feb 16, 2012 at 2:27 PM, Tero Kristo <t-kristo@ti.com> wro=
te:
>> > > On Wed, 2012-02-15 at 11:37 -0800, Kevin Hilman wrote:
>> > >> Tero Kristo <t-kristo@ti.com> writes:
>> > >>
>> > >> > Attempting this will cause problems especially with off-mode =
enabled.
>> > >>
>> > >> Please be more verbose about the problems seen, and the root ca=
use(s).
>> > >>
>> > >
>> > > I was actually looking forward for some help with this commit me=
ssage,
>> > > as I am still not quite sure what is going on in here. :) Here i=
s the
>> > > log for suspend (btw, cam_pwrdm does not go to off in mainline y=
et, but
>> > > I think that is probably fixed by the patch from Paul,
>> > > omap_set_pwrdm_state() does not work properly.) The warning come=
s out
>> > > after wakeup from off-mode, and it is triggered by the disabling=
 of
>> > > autodeps before off-mode entry.
>> > >
>> > This mostly indicates that one of the per clock-domain module
>> > clock turning ON seems to be not working well with auto deps
>> > disabled. This leads to interconnect violation.
>> >
>> > if not tried already, can you put the per_clockdomain in SW_WKUP
>> > in the low power code early resume path and see if this
>> > error goes away.
>>
>> This seems to get rid of the dump also. It looks like some driver re=
sume
>> is not behaving nicely, I am trying to pinpoint the culprit currentl=
y
>> and see whether it can provide more info.
>
> Okay, I have some more info about this now.
>
> What happens is that when entering off-mode, PER domain remains OFF e=
ven
> during the execution of the exit phase from omap_sram_idle. Adding a
> manual SW_WKUP it comes up and there are no issues. If autodeps are
> enabled on the domain, it comes back from off mode as active.
>
> Looking further in the code, we have this at the end of omap_sram_idl=
e:
>
> =A0 =A0 =A0 =A0if (per_next_state < PWRDM_POWER_ON) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0per_prev_state =3D pwrdm_read_prev_pwr=
st(per_pwrdm);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap2_gpio_resume_after_idle();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wake_per();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (per_prev_state =3D=3D PWRDM_POWER_=
OFF)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap3_per_restore_cont=
ext();
> =A0 =A0 =A0 =A0}
>
> ... which seems to assume that per domain is on. Gpio code does not
> control any clocks currently, as it only requires the interface clock=
 to
> be on, and as this is autoidled....
>
> Any comments how we should handle this? Shall we just keep these two
> patches for handling this or add some different hackery for the gpio
> issue?
>
Good. I thought too that issue will disappear.
The issue is pretty clear. Technically every driver pm_runtime() code s=
hould
be able to manage a clock->clockdomain->power domain power up/down
sequence. That should work without auto deps.

Do you narrowed down which driver resume is creating the dump ?
UART , GPIO ?

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
