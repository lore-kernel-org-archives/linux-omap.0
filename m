From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 2/5] ARM: OMAP2+: PM: use the power domains registers
 cache for the power states
Date: Thu, 3 May 2012 09:28:18 +0200
Message-ID: <CAORVsuU8gxD6+SRaKwP7bOxnNdB+hTuh2V9-MB9FwdfwJFPGAA@mail.gmail.com>
References: <1335877663-32649-1-git-send-email-j-pihet@ti.com>
	<1335877663-32649-3-git-send-email-j-pihet@ti.com>
	<4FA00343.3020704@ti.com>
	<B5906170F1614E41A8A28DE3B8D121433EA71233@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:55984 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753423Ab2ECH2S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 03:28:18 -0400
Received: by vbbff1 with SMTP id ff1so1057940vbb.19
        for <linux-omap@vger.kernel.org>; Thu, 03 May 2012 00:28:18 -0700 (PDT)
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EA71233@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, "Hunter, Jon" <jon-hunter@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Pihet-XID, Jean" <j-pihet@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Jon, Vaibhav,

On Thu, May 3, 2012 at 8:38 AM, Bedia, Vaibhav <vaibhav.bedia@ti.com> w=
rote:
> On Tue, May 01, 2012 at 21:07:39, Hunter, Jon wrote:
> [...]
>> > =A0int pwrdm_read_pwrst(struct powerdomain *pwrdm)
>> > =A0{
>> > - =A0 int ret =3D -EINVAL;
>> > + =A0 int pwrst, ret =3D -EINVAL;
>> >
>> > =A0 =A0 if (!pwrdm)
>> > =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> >
>> > - =A0 if (arch_pwrdm && arch_pwrdm->pwrdm_read_pwrst)
>> > + =A0 if (!pwrdm_cache_read(pwrdm, PWRDM_CACHE_PWRST, &pwrst))
>> > + =A0 =A0 =A0 =A0 =A0 return pwrst;
>> > +
>> > + =A0 if (arch_pwrdm && arch_pwrdm->pwrdm_read_pwrst) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 ret =3D arch_pwrdm->pwrdm_read_pwrst(pwrdm=
);
>> > + =A0 =A0 =A0 =A0 =A0 if (ret >=3D 0)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_cache_write(pwrdm, PWR=
DM_CACHE_PWRST, ret);
>> > + =A0 }
>>
>> Do we really want to use the cache for the current state? This is
>> updated by hardware. In the above it appears that once we have read =
it
>> once we will just return this value until the cache is invalidated.
>> Makes me a little nervous.
I agree with your concerns. The HW can update things in our back and
so there is a risk of having the wrong state reported by the API.
Ideally the registers accesses shall be optimized in the HW itself
(hint for next gen chipsets ;-).

IMO a generic approach on caching is preferred on a hack on the low pow=
er code.

The cache implementation is based on the following principles:
1. the registers value are read from the cache if it is 'hot', the
values are read from the registers if the cache has been invalidated
2. the coherency of the cache fields relies on the invalidate of the
fields at the right time during the low power transitions
3. the previous states fields of the cache are invalidated when
clearing the previous power states
4. the current states fields of the cache are invalidated after coming
back from the low power mode, i.e. after the return from the low level
WFI instruction
5. the pwrdm_state_switch function detects the states changes, updates
the last internal state (pwrdm->state) and the states statistics
6. in PM debug any discrepancy between pwrdm->state and the current
state from the API is reported. More checking could be added in PM
debug

So there must be a compromise on which fields are invalidated and
when. I first tried to invalidate the whole cache after every low
power transition, which works fine but does not gain much in
performance. The current invalidate scheme (points 3, 4) is optimized
for performance and has been tested succesfully on OMAP3 (using
cpuidle in RET and OFF).

In any case if the HW asynchronously changes the registers states it
will not always be detected, with or without the cache implementation.
=46or example if a power domain transitions more than once, only the
last transition -to a different state than pwrdm->state- will be
detected the next time pwrdm_state_switch runs.

>
> I echo the concern here. If a powerdomain transition occurs when h/w =
conditions
> are met, the cached values will go out of sync and this may lead to u=
nexpected
> behavior wherever this API is being used.
>
> As Jon pointed out in another patch, the registers which can be updat=
ed by h/w should
> be handled differently.
Agree but if you do not cache the previous and current registers there
is no point in having the cache in place.

>
> Just a wild thought, can PRCM_MPU_IRQ ([4]TRANSITION_EN) be used as a=
 trigger to update
> the cache if the transition happened under s/w control?
That is a nice suggestion. We need to explore the ways to detect transi=
tions.

>
> Regards,
> Vaibhav

Thanks for your comments!

Regards,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
