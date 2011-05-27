From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PM-WIP_CPUFREQ][PATCH 0/6 V3] Cleanups for cpufreq
Date: Thu, 26 May 2011 23:07:10 -0700
Message-ID: <BANLkTinv3HMBE_FBGWfLvnWyTRM=wXhpxA@mail.gmail.com>
References: <1306366733-8439-1-git-send-email-nm@ti.com> <87ipsxcoz0.fsf@ti.com>
 <4DDF3169.9070503@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:44932 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751537Ab1E0GHb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 May 2011 02:07:31 -0400
Received: by mail-wy0-f171.google.com with SMTP id 32so1490192wyb.16
        for <linux-omap@vger.kernel.org>; Thu, 26 May 2011 23:07:30 -0700 (PDT)
In-Reply-To: <4DDF3169.9070503@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Thu, May 26, 2011 at 22:06, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> On 5/26/2011 11:40 PM, Kevin Hilman wrote:
>>
>> So here's a dumb question, being rather ignorant of CPUfreq on SMP.
>>
>> Should we be running a CPUfreq instance on both CPUs when they canno=
t be
>> scaled independently?
>>
>> What is being scaled here is actually the cluster (the MPU SS via
>> dpll_mpu_ck), not an individual CPU. =A0So to me, it only makes sens=
e to
>> have a an instance of the driver per scalable device, which in this =
case
>> is a single MPU SS.
>>
> We are running only one instance and for the exact same reason as abo=
ve.
> You are completely right and that's the whole intention of those
> CPUMASK two lines in the initialization code.
>
>
>> What am I missing?
>>
> Not at all.

So not have cpufreq driver registered at all for CPU1? Life would be a
lot simpler in omap2-cpufreq.c as a result. but that said, two views:
a) future silicon somewhere ahead might need the current
infrastructure to scale into different tables..
b) as far as userspace sees it - cpu0 and cpu1 exists, cool, *but*
cpu1 is not scalable(no /sys/devices/system/cpu/cpu1/cpufreq.. but
=2E../cpu1/online is present). Keep in mind that userspace is usually
written chip independent. IMHO registering drivers for both devices do
make sense they reflect what the reality of the system is. 2 cpus
scaling together - why do we want to OMAP "specific" stuff here?

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
