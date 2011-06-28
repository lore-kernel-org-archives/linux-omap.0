From: Colin Cross <ccross@google.com>
Subject: Re: [PATCHv2] omap2+: pm: cpufreq: Fix loops_per_jiffy calculation
Date: Tue, 28 Jun 2011 15:56:46 -0700
Message-ID: <CAMbhsRRsEy_oXZO10fMEpM+puJwqTLesXenFBB1Ngj9-=tcV8A@mail.gmail.com>
References: <1308923618-5333-1-git-send-email-premi@ti.com>
	<CAMbhsRQUKBZbC3jJt8XpjTW2n7uA529D6G0g4eT5iLEHn2iNLg@mail.gmail.com>
	<4E0A5982.8040002@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:62473 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412Ab1F1W4u convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Jun 2011 18:56:50 -0400
Received: from hpaq12.eem.corp.google.com (hpaq12.eem.corp.google.com [172.25.149.12])
	by smtp-out.google.com with ESMTP id p5SMunv7008507
	for <linux-omap@vger.kernel.org>; Tue, 28 Jun 2011 15:56:49 -0700
Received: from gyc15 (gyc15.prod.google.com [10.243.49.143])
	by hpaq12.eem.corp.google.com with ESMTP id p5SMulfL007681
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Tue, 28 Jun 2011 15:56:48 -0700
Received: by gyc15 with SMTP id 15so408852gyc.10
        for <linux-omap@vger.kernel.org>; Tue, 28 Jun 2011 15:56:47 -0700 (PDT)
In-Reply-To: <4E0A5982.8040002@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Sanjeev Premi <premi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King - ARM Linux <linux@arm.linux.org.uk>

<resending as plain text again, sorry, mailer troubles>

On Tue, Jun 28, 2011 at 3:45 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
>
> On 6/28/2011 3:29 PM, Colin Cross wrote:
>>
>> <resending as plain text>
>>
>> On Fri, Jun 24, 2011 at 6:53 AM, Sanjeev Premi<premi@ti.com> =A0wrot=
e:
>>>
>
>>> +#ifdef CONFIG_SMP
>>> + =A0 =A0 =A0 /* Adjust jiffies before transition */
>>> + =A0 =A0 =A0 for_each_cpu(i, policy->cpus) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long lpj =3D per_cpu(cpu_dat=
a, i).loops_per_jiffy;
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 per_cpu(cpu_data, i).loops_per_jiffy =
=3D cpufreq_scale(lpj,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 freqs.old,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 freqs.new);
>
> This isn't the right patch since it does suffer from the progressive
> error. There was an updated patch on this thread from Russell which
> I re-based.

Both patches have the same issue - they update loops_per_jiffy, which
is unsafe on an SMP system.

>>
>> Can't this rewrite the loops_per_jiffy for the other CPU while it is
>> in a udelay? =A0If it has already calculated the number of loops
>> necessary, and the CPU frequency increases, it could end up returnin=
g
>> too early from udelay.
>>
>> There were previous discussions about polling a fixed-frequency time=
r
>> for udelay on SMP systems.
>>
> The udelay code doesn't use the per-cpu lpj variable. It uses the glo=
bal
> lpj. Secondly the calibration of no. of loops to be done is
> precalculateed so overwrite shouldn't impact the scenario you mention=
ed.
>
> Though it has an issue where, pre-calculated loops can become short/l=
ong
> based on new clock change which impacts both CPU's on OMAP, when the =
other CPU is in in the middle of u-delay routine..

The precalculated loops is exactly the problem I described.
udelay(100) can return in 50 microseconds if the cpu speed is doubled.
 On OMAP4, frequencies can range from 350Mhz to 1.5GHz, so udelay can
be more than 4 times too short.  That breaks the guarantees of udelay.

> When CPU can scale independently, then we have bigger problem since
> global lpj based udelay becomes always error prone in all scenario's.
>
> So for the OMAP, where the whole CPU cluster is scaled together,
> I don't see this as a bigger problem.
>
> Regards
> Santosh
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
