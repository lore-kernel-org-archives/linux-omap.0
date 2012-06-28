From: Kevin Hilman <khilman@ti.com>
Subject: Re: Bringing back gptimer_wakeup
Date: Thu, 28 Jun 2012 09:00:34 -0500
Message-ID: <87pq8jpmd9.fsf@ti.com>
References: <4FDEF24C.8020305@gmail.com> <87k3z4lcrs.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:34380 "EHLO
	na3sys009aog127.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754465Ab2F1OAX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 10:00:23 -0400
Received: by yhoo21 with SMTP id o21so2649414yho.18
        for <linux-omap@vger.kernel.org>; Thu, 28 Jun 2012 07:00:21 -0700 (PDT)
In-Reply-To: <87k3z4lcrs.fsf@ti.com> (Kevin Hilman's message of "Mon, 18 Jun
	2012 11:01:59 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tasslehoff Kjappfot <tasskjapp@gmail.com>
Cc: linux-omap@vger.kernel.org

Kevin Hilman <khilman@ti.com> writes:

> Tasslehoff Kjappfot <tasskjapp@gmail.com> writes:
>
>> The support for using a timer to wake from suspend was removed in:
>> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=98e182a26bbbf5575457622337684ef61493e864
>>
>> I found an alternative patch
>> (http://www.mail-archive.com/linux-omap@vger.kernel.org/msg47836.html)
>> that claimed to keep it working using GPTIMER1 instead, but I haven't
>> been able to make it work (likely because the timer code has changed a
>> good deal since the patch was posted).
>>
>> Anyone got
>> a) a patch that enables this feature on newer kernels, or
>> b) an idea how the patch above can be made to work?
>
> The branch below (based on v3.4) will work (at least on OMAP3)
>
> We've been holding off on putting this back becasue the timer interface
> has been going through some major cleanup/rework, but I would like to
> see this make it back in soonish.

Note that another feature that can be used for this same feature is
wakeup using RTC.

On OMAP3 platoforms with TWL4030 PMIC (which contains an RTC), this is
successfully working using the 'rtcwake' utility.

E.g., to suspend-to-RAM and trigger an RTC wakeup 4 seconds later, do:

  # rtcwake -m mem -s 4

The RTC timekeeping seems a bit broken and the actual delay seems to be
about 2x the value passed in here, but otherwise this works.

There are currently some problems with the OMAP4 RTC driver that prevent
this from working, but they need to be investigated.

Kevin
