From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PM-WIP_CPUFREQ][PATCH 4/6 v2] OMAP2: cpufreq: use
 clk_init_cpufreq_table if OPPs not available
Date: Thu, 19 May 2011 08:51:26 -0500
Message-ID: <BANLkTinKByYJ1kbRXkWsc1UWrdxcj9+84g@mail.gmail.com>
References: <1305704266-17623-5-git-send-email-nm@ti.com> <87d3jeal6r.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:36354 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756953Ab1ESNvx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 May 2011 09:51:53 -0400
Received: by mail-ww0-f50.google.com with SMTP id 33so2696597wwc.19
        for <linux-omap@vger.kernel.org>; Thu, 19 May 2011 06:51:46 -0700 (PDT)
In-Reply-To: <87d3jeal6r.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Thu, May 19, 2011 at 08:12, Kevin Hilman <khilman@ti.com> wrote:
> Nishanth Menon <nm@ti.com> writes:
>
>> OMAP2 does not use OPP tables at the moment for DVFS. Currently,
>> we depend on opp table initialization to give us the freq_table,
>> which makes sense for OMAP3+. for OMAP2, we should be using
>> clk_init_cpufreq_table - so if the opp based frequency table
>> initilization fails, fall back to clk_init_cpufreq_table to give
>> us the table.
>>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>
> This is a good approach, but for readability, the OPP version and the
> clk version should probably be separated into separate functions, alo=
ng
> with their error handling.
Was thinking more of the lines of splitting the file up. OMAP3+ all
have OPPs defined. only one pending is OMAP2
Either we introduce OPPs to OMAP2 OR we split it up and depend the OPP
based stuff on ARCH_HAS_OPP and CPUFREQ

>
> Minor: please capitalize acronyms: OPP, CPU, OMAP, etc...

will do.
Regards,
Nishanth Menon

>
> Kevin
>
>> ---
>> =A0arch/arm/mach-omap2/omap2plus-cpufreq.c | =A0 =A09 ++++++++-
>> =A01 files changed, 8 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c b/arch/arm/mach=
-omap2/omap2plus-cpufreq.c
>> index 45f1e9e..854f4b3 100644
>> --- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
>> +++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
>> @@ -180,7 +180,13 @@ static int __cpuinit omap_cpu_init(struct cpufr=
eq_policy *policy)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: unable to get the mpu de=
vice\n", __func__);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> =A0 =A0 =A0 }
>> - =A0 =A0 opp_init_cpufreq_table(mpu_dev, &freq_table);
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* if we dont get cpufreq table using opp, use tradition=
al omap2 lookup
>> + =A0 =A0 =A0* as a fallback
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (opp_init_cpufreq_table(mpu_dev, &freq_table))
>> + =A0 =A0 =A0 =A0 =A0 =A0 clk_init_cpufreq_table(&freq_table);
>>
>> =A0 =A0 =A0 if (freq_table) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 result =3D cpufreq_frequency_table_cpuin=
fo(policy, freq_table);
>> @@ -188,6 +194,7 @@ static int __cpuinit omap_cpu_init(struct cpufre=
q_policy *policy)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpufreq_frequency_table_=
get_attr(freq_table,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 policy->cpu);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_exit_cpufreq_table(&fr=
eq_table);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN(true, "%s: fallback=
 to clk_round(freq_table=3D%d)\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 __func__, result);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(freq_table);
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
