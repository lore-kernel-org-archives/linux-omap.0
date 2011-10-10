From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 4/8] OMAP2+: omap_hwmod: manage the wake-up latency constraints
Date: Mon, 10 Oct 2011 10:08:06 +0200
Message-ID: <CAORVsuXuFPD2QX4RXF_gfhw=U8izWVDVq4MZr8ZKvTVEw+5HqA@mail.gmail.com>
References: <1316621649-3622-1-git-send-email-j-pihet@ti.com>
	<1316622258-3892-1-git-send-email-j-pihet@ti.com>
	<1316622258-3892-5-git-send-email-j-pihet@ti.com>
	<alpine.DEB.2.00.1110062048160.4611@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:49095 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455Ab1JJIIH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Oct 2011 04:08:07 -0400
Received: by vws1 with SMTP id 1so4380670vws.19
        for <linux-omap@vger.kernel.org>; Mon, 10 Oct 2011 01:08:06 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1110062048160.4611@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, magnus.damm@gmail.com, Todd Poynor <toddpoynor@google.com>, Jean Pihet <j-pihet@ti.com>

Hi Paull,

On Fri, Oct 7, 2011 at 4:53 AM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi
>
> a comment:
>
> On Wed, 21 Sep 2011, jean.pihet@newoldbits.com wrote:
>
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> Hwmod is queried from the OMAP_PM layer to manage the power domains
>> wake-up latency constraints. Hwmod retrieves the correct power domai=
n
>> and if it exists it calls the corresponding power domain function.
>>
>> Tested on OMAP3 Beagleboard and OMAP4 Pandaboard in RET/OFF using wa=
ke-up
>> latency constraints on MPU, CORE and PER.
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/omap_hwmod.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 26=
 +++++++++++++++++++++++++-
>> =A0arch/arm/plat-omap/include/plat/omap_hwmod.h | =A0 =A02 ++
>> =A02 files changed, 27 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/=
omap_hwmod.c
>> index 84cc0bd..c6b1cc9 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>> @@ -2618,11 +2619,34 @@ ohsps_unlock:
>> =A0 =A0 =A0 return ret;
>> =A0}
>>
>> +/*
>> + * omap_hwmod_set_wkup_constraint- set/release a wake-up latency co=
nstraint
>> + *
>> + * @oh: struct omap_hwmod* to which the target device belongs to.
>> + * @cookie: identifier of the constraints list for @oh.
>> + * @min_latency: the minimum allowed wake-up latency for @oh.
>> + *
>> + * Returns 0 upon success.
>> + */
>
> It's good that there is some documentation here, but it would be bett=
er if
> it were kerneldoc-style documentation. =A0Please see
> Documentation/kernel-doc-nano-HOWTO.txt.
> Also it would be good to have a bit more documentation here beyond si=
mply
> "Returns 0 upon success." =A0For example, how should a caller remove =
a
> wakeup latency constraint? =A0Also, this function can return -EINVAL,=
 not
> counting whatever pwrdm_set_wkup_lat_constraint() can return, so that
> should be documented above also.
>
> This applies to the function comments in the rest of the patches too.
> Some of them have quite good kerneldoc comments, such as
> pwrdm_wakeuplat_update_pwrst(); others need some work, like
> pwrdm_set_wkup_lat_constraint().

Not all functions have kernel doc comments, i.e. this one does not (no
/** at the start of the header).
The intention is to document the functions from the API and the ones
that implement the core service (pwrdm_set_wkup_lat_constraint()), and
not the pure pass-through functions (omap_hwmod_set_wkup_constraint).

In any case I will review the comments and resubmit.

Thanks,
Jean

>
> - Paul
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
