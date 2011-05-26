From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PM-WIP_CPUFREQ][PATCH V3 5/8] OMAP2+: cpufreq: fix invalid
 cpufreq table with central alloc/free
Date: Wed, 25 May 2011 18:21:18 -0700
Message-ID: <BANLkTinHv4iOiOA5KP0S1D8CvWMtSn67Cw@mail.gmail.com>
References: <1306366733-8439-1-git-send-email-nm@ti.com> <1306366733-8439-6-git-send-email-nm@ti.com>
 <20110526010904.GB21212@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:39358 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755964Ab1EZBVj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 May 2011 21:21:39 -0400
Received: by mail-wy0-f170.google.com with SMTP id 34so291575wyb.1
        for <linux-omap@vger.kernel.org>; Wed, 25 May 2011 18:21:38 -0700 (PDT)
In-Reply-To: <20110526010904.GB21212@google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Todd Poynor <toddpoynor@google.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Kevin <khilman@ti.com>

On Wed, May 25, 2011 at 18:09, Todd Poynor <toddpoynor@google.com> wrot=
e:
>> + =A0 =A0 if (result || !freq_table) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(mpu_dev, "%s: cpu%d: unable to get=
 freq table [%d]\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, policy->cpu, res=
ult);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return result;
>
> The "|| !freq_table" isn't needed, and technically allows the code to
> return zero for an error return if the subexpression does evaluate
> true.
>
Ack..


Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
