From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 2/2] ARM: OMAP3: PM: cpuidle: optimize the clkdm idle
 latency in C1 state
Date: Fri, 1 Jun 2012 17:14:17 +0200
Message-ID: <CAORVsuWeHJufTA+MMg1OUNjqVdoUn0M80-atnFB5B7d4jU3eDA@mail.gmail.com>
References: <1336560912-26753-1-git-send-email-j-pihet@ti.com>
	<1336560912-26753-2-git-send-email-j-pihet@ti.com>
	<87pq9k1fhd.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:52233 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932649Ab2FAPOT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jun 2012 11:14:19 -0400
Received: by lahd3 with SMTP id d3so1621555lah.19
        for <linux-omap@vger.kernel.org>; Fri, 01 Jun 2012 08:14:17 -0700 (PDT)
In-Reply-To: <87pq9k1fhd.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Jean Pihet <j-pihet@ti.com>

Hi Kevin,

On Thu, May 31, 2012 at 6:29 PM, Kevin Hilman <khilman@ti.com> wrote:
> jean.pihet@newoldbits.com writes:
>
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> It is not needed to iterate through all the clock domains of a
>> power domain in order to allow or deny it to idle.
>
> Why? =A0(I know the answer, but would like it answered here.)
>
>> This patch allows or denies only the first registered clock domain
>> of a power domain, and so optimizes the latency of the low power
>> code. The functions _cpuidle_allow_idle and _cpuidle_deny_idle are
>> not used anymore and so are removed.
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>
> Other than the changelog update, it looks good but also needs a rebas=
e
> like the previous patch.
>
> After that, I'll add them to my for_3.6/pm/performance branch and que=
ue
> for v3.6.
The new series has been sent as '[PATCH 0/3] ARM: OMAP3: PM: optimize
cpuidle C1 state latency' with the suggested changes (changelog
updated, rebased on for_3.6/pm/performance).

Note: with the code from the branch the CORE does not idle. The
optimization changes have been tested OK though.

>
> Thanks!
>
> Kevin
>

Regards,
Jean


>> ---
>> =A0arch/arm/mach-omap2/cpuidle34xx.c | =A0 22 ++++------------------
>> =A01 files changed, 4 insertions(+), 18 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2=
/cpuidle34xx.c
>> index 353dd8d..d44b68a 100644
>> --- a/arch/arm/mach-omap2/cpuidle34xx.c
>> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
>> @@ -73,20 +73,6 @@ struct omap3_idle_statedata omap3_idle_data[OMAP3=
_NUM_STATES];
>>
>> =A0struct powerdomain *mpu_pd, *core_pd, *per_pd, *cam_pd;
>>
>> -static int _cpuidle_allow_idle(struct powerdomain *pwrdm,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct clo=
ckdomain *clkdm)
>> -{
>> - =A0 =A0 clkdm_allow_idle(clkdm);
>> - =A0 =A0 return 0;
>> -}
>> -
>> -static int _cpuidle_deny_idle(struct powerdomain *pwrdm,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct clo=
ckdomain *clkdm)
>> -{
>> - =A0 =A0 clkdm_deny_idle(clkdm);
>> - =A0 =A0 return 0;
>> -}
>> -
>> =A0static int __omap3_enter_idle(struct cpuidle_device *dev,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct c=
puidle_driver *drv,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int inde=
x)
>> @@ -105,8 +91,8 @@ static int __omap3_enter_idle(struct cpuidle_devi=
ce *dev,
>>
>> =A0 =A0 =A0 /* Deny idle for C1 */
>> =A0 =A0 =A0 if (index =3D=3D 0) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_for_each_clkdm(mpu_pd, _cpuidle_deny=
_idle);
>> - =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_for_each_clkdm(core_pd, _cpuidle_den=
y_idle);
>> + =A0 =A0 =A0 =A0 =A0 =A0 clkdm_deny_idle(mpu_pd->pwrdm_clkdms[0]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 clkdm_deny_idle(core_pd->pwrdm_clkdms[0]);
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 /*
>> @@ -128,8 +114,8 @@ static int __omap3_enter_idle(struct cpuidle_dev=
ice *dev,
>>
>> =A0 =A0 =A0 /* Re-allow idle for C1 */
>> =A0 =A0 =A0 if (index =3D=3D 0) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_for_each_clkdm(mpu_pd, _cpuidle_allo=
w_idle);
>> - =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_for_each_clkdm(core_pd, _cpuidle_all=
ow_idle);
>> + =A0 =A0 =A0 =A0 =A0 =A0 clkdm_allow_idle(mpu_pd->pwrdm_clkdms[0]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 clkdm_allow_idle(core_pd->pwrdm_clkdms[0])=
;
>> =A0 =A0 =A0 }
>>
>> =A0return_sleep_time:
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
