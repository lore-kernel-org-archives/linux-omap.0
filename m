From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH] arm: omap: Use only valid power domain states
Date: Thu, 3 May 2012 09:01:46 +0200
Message-ID: <CAORVsuUD6sHn+mDLQDLVD-K_JngcxY-BrVT8KQACd+9Z5s_SGA@mail.gmail.com>
References: <1335821126-12994-1-git-send-email-mgreer@animalcreek.com>
	<CAORVsuUJQOL-aTaGdo6VsOGm3ZHU=nWinQYrP70Lx0kG6G34TQ@mail.gmail.com>
	<20120502220420.GA19579@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:53548 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752469Ab2ECHBr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 03:01:47 -0400
Received: by vbbff1 with SMTP id ff1so1048351vbb.19
        for <linux-omap@vger.kernel.org>; Thu, 03 May 2012 00:01:47 -0700 (PDT)
In-Reply-To: <20120502220420.GA19579@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>, khilman@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com

Hi Mark,

On Thu, May 3, 2012 at 12:04 AM, Mark A. Greer <mgreer@animalcreek.com>=
 wrote:
> On Tue, May 01, 2012 at 10:47:35AM +0200, Jean Pihet wrote:
>> Hi Mark,
>
> Hi Jean. =A0Thanks for the review.
>
>> On Mon, Apr 30, 2012 at 11:25 PM, Mark A. Greer <mgreer@animalcreek.=
com> wrote:
>> > From: "Mark A. Greer" <mgreer@animalcreek.com>
>
>> > diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-oma=
p2/cpuidle34xx.c
>> > index 5358664..2c91711 100644
>> > --- a/arch/arm/mach-omap2/cpuidle34xx.c
>> > +++ b/arch/arm/mach-omap2/cpuidle34xx.c
>> > @@ -175,19 +175,25 @@ static int next_valid_state(struct cpuidle_d=
evice *dev,
>> > =A0 =A0 =A0 =A0struct cpuidle_state_usage *curr_usage =3D &dev->st=
ates_usage[index];
>> > =A0 =A0 =A0 =A0struct cpuidle_state *curr =3D &drv->states[index];
>> > =A0 =A0 =A0 =A0struct omap3_idle_statedata *cx =3D cpuidle_get_sta=
tedata(curr_usage);
>> > - =A0 =A0 =A0 u32 mpu_deepest_state =3D PWRDM_POWER_RET;
>> > - =A0 =A0 =A0 u32 core_deepest_state =3D PWRDM_POWER_RET;
>> > + =A0 =A0 =A0 u32 mpu_deepest_state, mpu_deepest_possible;
>> > + =A0 =A0 =A0 u32 core_deepest_state, core_deepest_possible;
>> > =A0 =A0 =A0 =A0int next_index =3D -1;
>> >
>> > + =A0 =A0 =A0 mpu_deepest_possible =3D pwrdm_get_deepest_state(mpu=
_pd);
>> > + =A0 =A0 =A0 mpu_deepest_state =3D max_t(u32, mpu_deepest_possibl=
e, PWRDM_POWER_RET);
>> I do not think you need to change the pwrdm API and the cpuidle code=
 for that.
>> Instead you should use the pwrst* fields in the power domains data
>> files, which allow to specify the allowed states.
>> After reading the rest of your patches it seems you are addressing t=
he
>> issue in a subsequent patch 'arm: omap3: am35x: Set proper powerdoma=
in
>> states'.
>
> That patch sets the allowable power domain states for the am35x; the =
intent
> of this patch was to make the code respect what is set in the pwrst* =
fields.
>
>> > diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-oma=
p2/powerdomain.c
>> > index 96ad3dbe..9c80c19 100644
>> > --- a/arch/arm/mach-omap2/powerdomain.c
>> > +++ b/arch/arm/mach-omap2/powerdomain.c
>> > @@ -1078,3 +1078,28 @@ bool pwrdm_can_ever_lose_context(struct pow=
erdomain *pwrdm)
>> >
>> > =A0 =A0 =A0 =A0return 0;
>> > =A0}
>> > +
>> > +/**
>> > + * pwrdm_get_deepest_state - Get deepest valid state domain can e=
nter
>> > + * @pwrdm: struct powerdomain *
>> > + *
>> > + * Find and return the deepest valid state a power domain can be =
in.
>> > + * Returns the deepest state that @pwrdm can enter.
>> > + */
>> > +u32 pwrdm_get_deepest_state(struct powerdomain *pwrdm)
>> > +{
>> > + =A0 =A0 =A0 u32 valid_states, deepest_state;
>> > +
>> > + =A0 =A0 =A0 valid_states =3D pwrdm->pwrsts;
>> > +
>> > + =A0 =A0 =A0 if (valid_states & PWRSTS_OFF)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 deepest_state =3D PWRDM_POWER_OFF;
>> > + =A0 =A0 =A0 else if (valid_states & PWRSTS_RET)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 deepest_state =3D PWRDM_POWER_RET;
>> > + =A0 =A0 =A0 else if (valid_states & PWRSTS_INACTIVE)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 deepest_state =3D PWRDM_POWER_INACTI=
VE;
>> > + =A0 =A0 =A0 else
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 deepest_state =3D PWRDM_POWER_ON;
>> > +
>> > + =A0 =A0 =A0 return deepest_state;
>> > +}
>>
>> The pwrdm API already performs those checks on pwrst*, cf.
>> pwrdm_set_next_pwrst for example.
>
> Well, sort of. =A0pwrdm_set_next_pwrst() fails if its an invalid stat=
e
> returning -EINVAL. =A0Very few of the callers actually check to see i=
f
> it failed so they don't try the "next-one-up" power state. =A0The net
> result is that the next state doesn't change even though it could
> move to a lower state (just not the one that was asked for).
>
> Is that acceptable?
No that is not acceptable. In fact the next power state should only be
set using omap_set_pwrdm_state, which falls back to the next valid
power state. Note: my latest patches about the functional power states
is using omap_set_pwrdm_state as the only function to set the power,
logic states.

> Another sort of strange one is omap3_pm_off_mode_enable(). =A0If its
> called with 'enable' set and PWRDM_POWER_OFF isn't a valid state,
> omap_set_pwrdm_state() will return 0 and leave the next state alone.
> When omap3_pm_off_mode_enable() is called again with 'enable' set,
> omap_set_pwrdm_state() will find the lowest valid state >=3D RET.
> So, if you had a device where OFF wasn't valid but RET was and
> its currently ON, when the user enables OFF mode, it stays ON
> and when they disable OFF mode, it moves to RET.
>
> Is that acceptable?
No. omap_set_pwrdm_state should be fixed in that case.
In fact the enable_off_mode flag is scheduled for removal in favor of
the PM QoS constraints.

> If the things above are acceptable, then I think you're right, we can
> forget this patch. =A0FYI, the am35x appears to work okay and no inva=
lid
> states are entered (according to /sys/kernel/debug/pm_debug/count)
> without this patch.
I think we should fix the existing code if it has problems, not add
more specific code.

Kevin, what is your take on this?

> Mark

Regards,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
