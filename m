From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PM-WIP_CPUFREQ][PATCH V3 6/8] OMAP2+: cpufreq: fix freq_table leak
Date: Wed, 25 May 2011 18:36:01 -0700
Message-ID: <BANLkTi=rWe28EgH6nde43X_PN-sSeuY+7Q@mail.gmail.com>
References: <1306366733-8439-1-git-send-email-nm@ti.com> <1306366733-8439-7-git-send-email-nm@ti.com>
 <20110526012508.GC21212@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:58612 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752762Ab1EZBgY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 May 2011 21:36:24 -0400
Received: by wye20 with SMTP id 20so253861wye.34
        for <linux-omap@vger.kernel.org>; Wed, 25 May 2011 18:36:22 -0700 (PDT)
In-Reply-To: <20110526012508.GC21212@google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Todd Poynor <toddpoynor@google.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Kevin <khilman@ti.com>

On Wed, May 25, 2011 at 18:25, Todd Poynor <toddpoynor@google.com> wrot=
e:
> On Wed, May 25, 2011 at 04:38:51PM -0700, Nishanth Menon wrote:
>> Since we have multiple CPUs, the cpuinit call for CPU1 causes
>> freq_table of CPU0 to be overwritten. Instead, we maintain
>> a counter to keep track of cpus who use the cpufreq table
>> allocate it once(one freq table for all CPUs) and free them
>> once the last user is done with it. We also need to protect
>> freq_table and this new counter from updates from multiple
>> contexts to be on a safe side.
>>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> ---
> ...
>> =A0static int freq_table_alloc(void)
>> =A0{
>> - =A0 =A0 if (use_opp)
>> - =A0 =A0 =A0 =A0 =A0 =A0 return opp_init_cpufreq_table(mpu_dev, &fr=
eq_table);
>> + =A0 =A0 int ret =3D 0;
>>
>> - =A0 =A0 clk_init_cpufreq_table(&freq_table);
>> - =A0 =A0 if (!freq_table)
>> - =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> + =A0 =A0 mutex_lock(&freq_table_lock);
>>
>> - =A0 =A0 return 0;
>> + =A0 =A0 freq_table_users++;
>> + =A0 =A0 /* Did we allocate previously? */
>> + =A0 =A0 if (freq_table_users - 1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> +
>> + =A0 =A0 /* no, so we allocate */
>> + =A0 =A0 if (use_opp) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D opp_init_cpufreq_table(mpu_dev, &f=
req_table);
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 clk_init_cpufreq_table(&freq_table);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!freq_table)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> + =A0 =A0 }
>> + =A0 =A0 /* if we did not allocate cleanly.. reduce user count */
>> + =A0 =A0 if (!ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 freq_table_users--;
>
> "if (ret)" intended? =A0ret =3D=3D 0 means allocated OK.

arrgh.. yikes..

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
