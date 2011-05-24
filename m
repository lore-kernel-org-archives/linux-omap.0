From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH] PM: OPP: introduce function to free cpufreq table
Date: Mon, 23 May 2011 21:42:21 -0500
Message-ID: <BANLkTi=mo_o=WCHg27XeOTYP9gDEFROMVQ@mail.gmail.com>
References: <1306192335-19883-1-git-send-email-nm@ti.com> <20110524000549.GA20225@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:38959 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751832Ab1EXCmn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 May 2011 22:42:43 -0400
Received: by wwi18 with SMTP id 18so7210364wwi.29
        for <linux-omap@vger.kernel.org>; Mon, 23 May 2011 19:42:41 -0700 (PDT)
In-Reply-To: <20110524000549.GA20225@google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Todd Poynor <toddpoynor@google.com>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, linux-omap <linux-omap@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Mon, May 23, 2011 at 19:05, Todd Poynor <toddpoynor@google.com> wrot=
e:
> On Mon, May 23, 2011 at 06:12:15PM -0500, Nishanth Menon wrote:
>> cpufreq table allocated by opp_init_cpufreq_table is better
>> freed by OPP layer itself. This allows future modifications to
>> the table handling to be transparent to the users.
> ...
>> +void opp_free_cpufreq_table(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct cpu=
freq_frequency_table **table)
>> +{
>> + =A0 =A0 if (!table)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 /* Pretend as if I am an updater */
>> + =A0 =A0 mutex_lock(&dev_opp_list_lock);
>> + =A0 =A0 kfree(*table);
>> + =A0 =A0 *table =3D NULL;
>> + =A0 =A0 mutex_unlock(&dev_opp_list_lock);
>> +}
>
> Not clear what the mutex protects here. =A0Currently it protects only
> device opp list modifications. =A0opp_init_cpufreq_table holds the lo=
ck only
> while looking up and walking the device opp list; the cpufreq table i=
t
> creates is not complete by the time the lock is dropped.

hmm.. right.. mutex protection does'nt really make sense here..

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
