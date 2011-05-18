From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PM-WIP_CPUFREQ][PATCH 3/6 v2] OMAP2+: cpufreq: minor comment cleanup
Date: Wed, 18 May 2011 15:34:42 -0500
Message-ID: <BANLkTikKiG4aCJ13yoVLXX+oMaw93kxvgA@mail.gmail.com>
References: <1305704266-17623-4-git-send-email-nm@ti.com> <20110518200856.GA8149@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:44018 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751922Ab1ERUfL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 May 2011 16:35:11 -0400
Received: by mail-ww0-f43.google.com with SMTP id 17so2048125wwb.0
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 13:35:02 -0700 (PDT)
In-Reply-To: <20110518200856.GA8149@google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Todd Poynor <toddpoynor@google.com>
Cc: kevin <khilman@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Wed, May 18, 2011 at 15:08, Todd Poynor <toddpoynor@google.com> wrot=
e:
> On Wed, May 18, 2011 at 02:37:43AM -0500, Nishanth Menon wrote:
>> this should probably get squashed in..
>>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/omap2plus-cpufreq.c | =A0 =A06 ++++--
>> =A01 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c b/arch/arm/mach=
-omap2/omap2plus-cpufreq.c
>> index 6e3666a..45f1e9e 100644
>> --- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
>> +++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
>> @@ -84,8 +84,10 @@ static int omap_target(struct cpufreq_policy *pol=
icy,
>> =A0 =A0 =A0 if (is_smp() && (num_online_cpus() < NR_CPUS))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>>
>> - =A0 =A0 /* Ensure desired rate is within allowed range. =A0Some go=
venors
>> - =A0 =A0 =A0* (ondemand) will just pass target_freq=3D0 to get the =
minimum. */
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Ensure desired rate is within allowed range. =A0Some =
govenors
>> + =A0 =A0 =A0* (ondemand) will just pass target_freq=3D0 to get the =
minimum.
>
> So long as the comment is being touched up, could fixup the typo for
> "governor" (and also copied to a new block of code in another patch
> in the series).

Will do. thanks for catching it :).

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
