From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PM-WIP_CPUFREQ][PATCH V3 4/8] OMAP2+: cpufreq: dont support !freq_table
Date: Wed, 25 May 2011 17:53:23 -0700
Message-ID: <BANLkTikubi_SNj_Xf++Zj=o5nr5h=HPvPw@mail.gmail.com>
References: <1306366733-8439-1-git-send-email-nm@ti.com> <1306366733-8439-5-git-send-email-nm@ti.com>
 <20110526005105.GA21212@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:38433 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757152Ab1EZAxo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 May 2011 20:53:44 -0400
Received: by mail-ww0-f51.google.com with SMTP id 26so156793wwf.20
        for <linux-omap@vger.kernel.org>; Wed, 25 May 2011 17:53:43 -0700 (PDT)
In-Reply-To: <20110526005105.GA21212@google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Todd Poynor <toddpoynor@google.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Kevin <khilman@ti.com>

On Wed, May 25, 2011 at 17:51, Todd Poynor <toddpoynor@google.com> wrot=
e:
>
>> + =A0 =A0 if (!freq_table) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(mpu_dev, "%s: cpu%d: no freq table=
!\n", __func__,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 policy->cp=
u);
>
> Just a minor comment: suggest dev_dbg() or WARN_ONCE() for some of
> these conditions that may be frequently evaluated and probably won't
> be cleared up after being hit once.

This is an error because we dont expect it as far as the device is
concerned. I'd use a debug/warn if I can recover out of it and
continue functionality.

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
