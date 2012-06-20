From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 03/10] ARM: OMAP2+: PM QoS: manage the per-device latency
 constraints in hwmod
Date: Wed, 20 Jun 2012 13:38:08 +0200
Message-ID: <CAORVsuWxys+p0PHYG3C362jSUmLJv-HsTOvPq6v-GSKedJenjQ@mail.gmail.com>
References: <1339686361-11526-1-git-send-email-j-pihet@ti.com>
	<1339686361-11526-4-git-send-email-j-pihet@ti.com>
	<4FE1A601.9000802@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:38836 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754773Ab2FTLiK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jun 2012 07:38:10 -0400
Received: by lbbgm6 with SMTP id gm6so488302lbb.19
        for <linux-omap@vger.kernel.org>; Wed, 20 Jun 2012 04:38:09 -0700 (PDT)
In-Reply-To: <4FE1A601.9000802@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>, paul@pwsan.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, Jean Pihet <j-pihet@ti.com>

Rajendra,

On Wed, Jun 20, 2012 at 12:29 PM, Rajendra Nayak <rnayak@ti.com> wrote:
> On Thursday 14 June 2012 08:35 PM, Jean Pihet wrote:
>>
>> Call the per-device PM QoS functions of the power domain code from t=
he
>> hwmod layer, in order to apply the constraints requested to a device=
=2E
>>
>> While at it, correct the functions kerneldoc.
>
>
> Shouldn't this patch be just merged with PATCH 02/10?
Ideally yes!

Paul,
Is this possiblr or is the patch 02/10 already scheduled for inclusion
in l-o or mainline?

Regards,
Jean

>
>
>>
>> Signed-off-by: Jean Pihet<j-pihet@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/omap_hwmod.c | =A0 22 ++++++----------------
>> =A01 files changed, 6 insertions(+), 16 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c
>> b/arch/arm/mach-omap2/omap_hwmod.c
>> index cc173d9..4f43e0c 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>> @@ -3302,15 +3302,13 @@ ohsps_unlock:
>> =A0}
>>
>> =A0/**
>> - * omap_hwmod_set_wakeuplat_constraint - set/release a wake-up late=
ncy
>> + * omap_hwmod_set_wakeuplat_constraint - Set or update a wake-up la=
tency
>> =A0 * constraint
>> =A0 * @oh: struct omap_hwmod* to which the target device belongs to.
>> =A0 * @cookie: identifier of the constraints list for @oh.
>> =A0 * @min_latency: the minimum allowed wake-up latency for @oh.
>> =A0 *
>> - * Sets a wakeup latency contraint. =A0(To remove a wakeup latency
>> - * constraint, call omap_hwmod_remove_wakeuplat_constraint()).
>> - * Returns the return value from pwrdm_wakeuplat_remove_constraint(=
),
>> + * Returns the return value from pwrdm_wakeuplat_update_constraint(=
),
>> =A0 * or -EINVAL in case of invalid parameters.
>> =A0 */
>> =A0int omap_hwmod_set_wakeuplat_constraint(struct omap_hwmod *oh, vo=
id
>> *cookie,
>> @@ -3321,21 +3319,17 @@ int omap_hwmod_set_wakeuplat_constraint(stru=
ct
>> omap_hwmod *oh, void *cookie,
>> =A0 =A0 =A0 =A0if (!pwrdm)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>>
>> - =A0 =A0 =A0 /*
>> - =A0 =A0 =A0 =A0* XXX Update to use pwrdm_wakeuplat_update_constrai=
nt() when
>> - =A0 =A0 =A0 =A0* that code is ready
>> - =A0 =A0 =A0 =A0*/
>> - =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 =A0 return pwrdm_wakeuplat_update_constraint(pwrdm, cookie=
,
>> min_latency);
>> =A0}
>>
>> =A0/**
>> - * omap_hwmod_remove_wakeuplat_constraint - release a wake-up laten=
cy
>> + * omap_hwmod_remove_wakeuplat_constraint - Release a wake-up laten=
cy
>> =A0 * constraint
>> =A0 * @oh: struct omap_hwmod* to which the target device belongs to.
>> =A0 * @cookie: identifier of the constraints list for @oh.
>> =A0 *
>> =A0 * Removes a wakeup latency contraint. =A0Returns the return valu=
e from
>> - * pwrdm_wakeuplat_update_constraint(), or -EINVAL in case of inval=
id
>> + * pwrdm_wakeuplat_remove_constraint(), or -EINVAL in case of inval=
id
>> =A0 * parameters.
>> =A0 */
>> =A0int omap_hwmod_remove_wakeuplat_constraint(struct omap_hwmod *oh,=
 void
>> *cookie)
>> @@ -3345,11 +3339,7 @@ int omap_hwmod_remove_wakeuplat_constraint(st=
ruct
>> omap_hwmod *oh, void *cookie)
>> =A0 =A0 =A0 =A0if (!pwrdm)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>>
>> - =A0 =A0 =A0 /*
>> - =A0 =A0 =A0 =A0* XXX Update to use pwrdm_wakeuplat_remove_constrai=
nt() when
>> - =A0 =A0 =A0 =A0* that code is ready
>> - =A0 =A0 =A0 =A0*/
>> - =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 =A0 return pwrdm_wakeuplat_remove_constraint(pwrdm, cookie=
);
>> =A0}
>>
>> =A0/**
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
