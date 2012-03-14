From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP3: OPP: Test for IVA subsystem before attempting to add IVA OPP
Date: Wed, 14 Mar 2012 15:06:37 -0700
Message-ID: <8762e6et1u.fsf@ti.com>
References: <1331746695-24372-1-git-send-email-mvs@tigris.de>
	<874ntqg9yr.fsf@ti.com>
	<CAOMWX4eYQvwHfpci1AgLO8kk1yxzB-zruMQQvLXeLnxbfUHFgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:37682 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761261Ab2CNWG0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Mar 2012 18:06:26 -0400
Received: by ggmb2 with SMTP id b2so2346743ggm.15
        for <linux-omap@vger.kernel.org>; Wed, 14 Mar 2012 15:06:25 -0700 (PDT)
In-Reply-To: <CAOMWX4eYQvwHfpci1AgLO8kk1yxzB-zruMQQvLXeLnxbfUHFgw@mail.gmail.com>
	(Nishanth Menon's message of "Wed, 14 Mar 2012 16:35:17 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: Maximilian Schwerin <mvs@tigris.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Steve Sakoman <steve@sakoman.com>

"Menon, Nishanth" <nm@ti.com> writes:

> On Wed, Mar 14, 2012 at 16:15, Kevin Hilman <khilman@ti.com> wrote:
>> Maximilian Schwerin <mvs@tigris.de> writes:
>>
>>> From: Steve Sakoman <steve@sakoman.com>
>>>
>>> Don't try to add IVA OPPs for OMAP3 versions not containing an IVA
>>> subsystem, as this would make omap_init_opp_table fail.
>>>
>>> Signed-off-by: Steve Sakoman <steve@sakoman.com>
>>> Signed-off-by: Maximilian Schwerin <mvs@tigris.de>
>>
>> Minor: patch subjects for arch/arm/* core code need to have the ARM:
>> prefix also.
>>
>> Also, please run scripts/checkpatch.pl on your patch and fix the
>> warnings.
>>
>>> ---
>>> =C2=A0arch/arm/mach-omap2/opp.c | =C2=A0 =C2=A04 ++++
>>> =C2=A01 files changed, 4 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/opp.c b/arch/arm/mach-omap2/opp.c
>>> index 9262a6b..414f2ec 100644
>>> --- a/arch/arm/mach-omap2/opp.c
>>> +++ b/arch/arm/mach-omap2/opp.c
>>> @@ -62,6 +62,10 @@ int __init omap_init_opp_table(struct omap_opp_d=
ef *opp_def,
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__, i);
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 return -EINVAL;
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((strcmp(opp_def->hw=
mod_name,"iva") =3D=3D 0) && !omap3_has_iva())
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 continue;
>>> +
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 oh =3D omap_hwmod_=
lookup(opp_def->hwmod_name);
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!oh || !oh->od=
) {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 pr_warn("%s: no hwmod or odev for %s, [%d] "
>>
>> Wouldn't the one-liner below do the same thing?
>>
>> Actually, your patch makes it less noisy at boot time, avoiding the
>> pr_warn(), so is probably better.
>
> The only issue i have with current patch is that it focusses to solve
> a specific device IVA.
> we could have similar variances if we had SGX/AESS device etc
> registered in the common
> table. a generic solution might be preferable - could we reduce the
> severity of pr_warn to pr_debug and do a continue instead?

I agree, that would be a better generic solution.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
