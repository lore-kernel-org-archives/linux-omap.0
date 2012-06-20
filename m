From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 3/3] ARM: OMAP3: PM: cpuidle: optimize the clkdm idle
 latency in C1 state
Date: Wed, 20 Jun 2012 10:31:04 +0200
Message-ID: <CAORVsuWEpsY2MDO=6oLWs=Sdxq+0gk5PHvMvqCwYCjv1+4WDOw@mail.gmail.com>
References: <1338563468-31403-1-git-send-email-j-pihet@ti.com>
	<1338563468-31403-4-git-send-email-j-pihet@ti.com>
	<4FE187A8.8060203@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:62711 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752993Ab2FTIbF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jun 2012 04:31:05 -0400
Received: by lbbgm6 with SMTP id gm6so280291lbb.19
        for <linux-omap@vger.kernel.org>; Wed, 20 Jun 2012 01:31:04 -0700 (PDT)
In-Reply-To: <4FE187A8.8060203@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

Hi Rajendra,

On Wed, Jun 20, 2012 at 10:19 AM, Rajendra Nayak <rnayak@ti.com> wrote:
> Hi Jean,
>
>
> On Friday 01 June 2012 08:41 PM, Jean Pihet wrote:
>>
>> For a power domain to idle all the clock domains in it must idle.
>> This patch implements an optimization of the cpuidle code by
>> denying and later allowing only the first registered clock domain
>> of a power domain, and so optimizes the latency of the low power cod=
e.
>
>
> How much do we really save doing this? I understand what you are doin=
g
> by looking at the patch but the changelog seems very confusing.
The gain is on the registers accesses and the internal PRCM state machi=
ne.
If needed the changelog can be updated.

> What the patch does is get rid of a few function indirection
> and assumes there is only *one* clkdm for mpu and core. Is that right=
?
Not exactly. The patch does not assume that there is only one clkdm
per power domain. It just allows or denies only one clkdm to idle,
which has the same effect at the power domain level.

Thanks for reviewing,
Jean

>
> regards,
> Rajendra
>
>
>>
>> The functions _cpuidle_allow_idle and _cpuidle_deny_idle are
>> not used anymore and so are removed.
>>
>> Signed-off-by: Jean Pihet<j-pihet@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/cpuidle34xx.c | =A0 22 ++++------------------
>> =A01 files changed, 4 insertions(+), 18 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c
>> b/arch/arm/mach-omap2/cpuidle34xx.c
>> index 2e2f1c6..e6ae3fe 100644
>> --- a/arch/arm/mach-omap2/cpuidle34xx.c
>> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
>> @@ -77,20 +77,6 @@ static struct omap3_idle_statedata omap3_idle_dat=
a[] =3D
>> {
>>
>> =A0static struct powerdomain *mpu_pd, *core_pd, *per_pd, *cam_pd;
>>
>> -static int _cpuidle_allow_idle(struct powerdomain *pwrdm,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct=
 clockdomain *clkdm)
>> -{
>> - =A0 =A0 =A0 clkdm_allow_idle(clkdm);
>> - =A0 =A0 =A0 return 0;
>> -}
>> -
>> -static int _cpuidle_deny_idle(struct powerdomain *pwrdm,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct=
 clockdomain *clkdm)
>> -{
>> - =A0 =A0 =A0 clkdm_deny_idle(clkdm);
>> - =A0 =A0 =A0 return 0;
>> -}
>> -
>> =A0static int __omap3_enter_idle(struct cpuidle_device *dev,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struc=
t cpuidle_driver *drv,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int i=
ndex)
>> @@ -108,8 +94,8 @@ static int __omap3_enter_idle(struct cpuidle_devi=
ce
>> *dev,
>>
>> =A0 =A0 =A0 =A0/* Deny idle for C1 */
>> =A0 =A0 =A0 =A0if (index =3D=3D 0) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_for_each_clkdm(mpu_pd, _cpuidle_=
deny_idle);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_for_each_clkdm(core_pd, _cpuidle=
_deny_idle);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clkdm_deny_idle(mpu_pd->pwrdm_clkdms[0=
]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clkdm_deny_idle(core_pd->pwrdm_clkdms[=
0]);
>> =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0/*
>> @@ -131,8 +117,8 @@ static int __omap3_enter_idle(struct cpuidle_dev=
ice
>> *dev,
>>
>> =A0 =A0 =A0 =A0/* Re-allow idle for C1 */
>> =A0 =A0 =A0 =A0if (index =3D=3D 0) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_for_each_clkdm(mpu_pd, _cpuidle_=
allow_idle);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_for_each_clkdm(core_pd, _cpuidle=
_allow_idle);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clkdm_allow_idle(mpu_pd->pwrdm_clkdms[=
0]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clkdm_allow_idle(core_pd->pwrdm_clkdms=
[0]);
>> =A0 =A0 =A0 =A0}
>>
>> =A0return_sleep_time:
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
