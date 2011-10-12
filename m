From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 4/8] OMAP2+: omap_hwmod: manage the wake-up latency constraints
Date: Wed, 12 Oct 2011 17:27:36 +0200
Message-ID: <CAORVsuWkSpG1=3T+BkC5HUXtxTcucFPBx+cjK7fpAkqZTiBBRQ@mail.gmail.com>
References: <1316621649-3622-1-git-send-email-j-pihet@ti.com>
	<1316622258-3892-1-git-send-email-j-pihet@ti.com>
	<1316622258-3892-5-git-send-email-j-pihet@ti.com>
	<alpine.DEB.2.00.1110062048160.4611@utopia.booyaka.com>
	<CAORVsuXuFPD2QX4RXF_gfhw=U8izWVDVq4MZr8ZKvTVEw+5HqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:51976 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753302Ab1JLP1i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Oct 2011 11:27:38 -0400
Received: by vcbgb30 with SMTP id gb30so657484vcb.19
        for <linux-omap@vger.kernel.org>; Wed, 12 Oct 2011 08:27:37 -0700 (PDT)
In-Reply-To: <CAORVsuXuFPD2QX4RXF_gfhw=U8izWVDVq4MZr8ZKvTVEw+5HqA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, magnus.damm@gmail.com, Todd Poynor <toddpoynor@google.com>, Jean Pihet <j-pihet@ti.com>, Ming Lei <tom.leiming@gmail.com>

Hi Paul,

The series has been updated with the kerneldoc and error path rework,
then re-submitted as v3.
Can you please look at it and possibly pull it?

Please let me know.

Regards,
Jean

On Mon, Oct 10, 2011 at 10:08 AM, Jean Pihet <jean.pihet@newoldbits.com=
> wrote:
> Hi Paull,
>
> On Fri, Oct 7, 2011 at 4:53 AM, Paul Walmsley <paul@pwsan.com> wrote:
>> Hi
>>
>> a comment:
>>
>> On Wed, 21 Sep 2011, jean.pihet@newoldbits.com wrote:
>>
>>> From: Jean Pihet <j-pihet@ti.com>
>>>
>>> Hwmod is queried from the OMAP_PM layer to manage the power domains
>>> wake-up latency constraints. Hwmod retrieves the correct power doma=
in
>>> and if it exists it calls the corresponding power domain function.
>>>
>>> Tested on OMAP3 Beagleboard and OMAP4 Pandaboard in RET/OFF using w=
ake-up
>>> latency constraints on MPU, CORE and PER.
>>>
>>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>>> ---
>>> =A0arch/arm/mach-omap2/omap_hwmod.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 2=
6 +++++++++++++++++++++++++-
>>> =A0arch/arm/plat-omap/include/plat/omap_hwmod.h | =A0 =A02 ++
>>> =A02 files changed, 27 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2=
/omap_hwmod.c
>>> index 84cc0bd..c6b1cc9 100644
>>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>>> @@ -2618,11 +2619,34 @@ ohsps_unlock:
>>> =A0 =A0 =A0 return ret;
>>> =A0}
>>>
>>> +/*
>>> + * omap_hwmod_set_wkup_constraint- set/release a wake-up latency c=
onstraint
>>> + *
>>> + * @oh: struct omap_hwmod* to which the target device belongs to.
>>> + * @cookie: identifier of the constraints list for @oh.
>>> + * @min_latency: the minimum allowed wake-up latency for @oh.
>>> + *
>>> + * Returns 0 upon success.
>>> + */
>>
>> It's good that there is some documentation here, but it would be bet=
ter if
>> it were kerneldoc-style documentation. =A0Please see
>> Documentation/kernel-doc-nano-HOWTO.txt.
>> Also it would be good to have a bit more documentation here beyond s=
imply
>> "Returns 0 upon success." =A0For example, how should a caller remove=
 a
>> wakeup latency constraint? =A0Also, this function can return -EINVAL=
, not
>> counting whatever pwrdm_set_wkup_lat_constraint() can return, so tha=
t
>> should be documented above also.
>>
>> This applies to the function comments in the rest of the patches too=
=2E
>> Some of them have quite good kerneldoc comments, such as
>> pwrdm_wakeuplat_update_pwrst(); others need some work, like
>> pwrdm_set_wkup_lat_constraint().
>
> Not all functions have kernel doc comments, i.e. this one does not (n=
o
> /** at the start of the header).
> The intention is to document the functions from the API and the ones
> that implement the core service (pwrdm_set_wkup_lat_constraint()), an=
d
> not the pure pass-through functions (omap_hwmod_set_wkup_constraint).
>
> In any case I will review the comments and resubmit.
>
> Thanks,
> Jean
>
>>
>> - Paul
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
