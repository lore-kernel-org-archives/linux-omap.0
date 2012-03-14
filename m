From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH] OMAP3: OPP: Test for IVA subsystem before attempting to
 add IVA OPP
Date: Wed, 14 Mar 2012 16:35:17 -0500
Message-ID: <CAOMWX4eYQvwHfpci1AgLO8kk1yxzB-zruMQQvLXeLnxbfUHFgw@mail.gmail.com>
References: <1331746695-24372-1-git-send-email-mvs@tigris.de> <874ntqg9yr.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:35411 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759794Ab2CNVfj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Mar 2012 17:35:39 -0400
Received: by mail-we0-f180.google.com with SMTP id f3so3573952wer.39
        for <linux-omap@vger.kernel.org>; Wed, 14 Mar 2012 14:35:37 -0700 (PDT)
In-Reply-To: <874ntqg9yr.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Maximilian Schwerin <mvs@tigris.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Steve Sakoman <steve@sakoman.com>

On Wed, Mar 14, 2012 at 16:15, Kevin Hilman <khilman@ti.com> wrote:
> Maximilian Schwerin <mvs@tigris.de> writes:
>
>> From: Steve Sakoman <steve@sakoman.com>
>>
>> Don't try to add IVA OPPs for OMAP3 versions not containing an IVA
>> subsystem, as this would make omap_init_opp_table fail.
>>
>> Signed-off-by: Steve Sakoman <steve@sakoman.com>
>> Signed-off-by: Maximilian Schwerin <mvs@tigris.de>
>
> Minor: patch subjects for arch/arm/* core code need to have the ARM:
> prefix also.
>
> Also, please run scripts/checkpatch.pl on your patch and fix the
> warnings.
>
>> ---
>> =A0arch/arm/mach-omap2/opp.c | =A0 =A04 ++++
>> =A01 files changed, 4 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/opp.c b/arch/arm/mach-omap2/opp.c
>> index 9262a6b..414f2ec 100644
>> --- a/arch/arm/mach-omap2/opp.c
>> +++ b/arch/arm/mach-omap2/opp.c
>> @@ -62,6 +62,10 @@ int __init omap_init_opp_table(struct omap_opp_de=
f *opp_def,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__=
, i);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if ((strcmp(opp_def->hwmod_name,"iva") =3D=
=3D 0) && !omap3_has_iva())
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 oh =3D omap_hwmod_lookup(opp_def->hwmod_=
name);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!oh || !oh->od) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warn("%s: no hwmod or=
 odev for %s, [%d] "
>
> Wouldn't the one-liner below do the same thing?
>
> Actually, your patch makes it less noisy at boot time, avoiding the
> pr_warn(), so is probably better.

The only issue i have with current patch is that it focusses to solve
a specific device IVA.
we could have similar variances if we had SGX/AESS device etc
registered in the common
table. a generic solution might be preferable - could we reduce the
severity of pr_warn to pr_debug and do a continue instead?

>
> Kevin
>
> diff --git a/arch/arm/mach-omap2/opp.c b/arch/arm/mach-omap2/opp.c
> index 9262a6b..d3d4fa2 100644
> --- a/arch/arm/mach-omap2/opp.c
> +++ b/arch/arm/mach-omap2/opp.c
> @@ -67,7 +67,7 @@ int __init omap_init_opp_table(struct omap_opp_def =
*opp_def,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_warn("%s: no hwmod =
or odev for %s, [%d] "
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"canno=
t add OPPs.\n", __func__,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0opp_de=
f->hwmod_name, i);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev =3D &oh->od->pdev->dev;


Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
