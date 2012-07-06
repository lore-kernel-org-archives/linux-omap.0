From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH] OMAP: config : disable the usb host configuration in omap2plus_defconfig
Date: Fri, 6 Jul 2012 19:04:36 +0530
Message-ID: <CAP05o4J9f+HCCSnyBaEEW_3zkh1iq3EAJdRFot0rR3JxpmDAgA@mail.gmail.com>
References: <1341575380-11972-1-git-send-email-keshava_mgowda@ti.com>
	<CAP05o4LAQXzPs_gLBn70X-VbRWTCHOk0b4afH9gn0aUur2C7FQ@mail.gmail.com>
	<CAMQu2gwYDz10QcZvN1BSCr4TQLG2PEwshTN7VVk10PYzj6B2QQ@mail.gmail.com>
	<CAP05o4LBpbCHmXi_J1C6wtKX9SFHrntcZz7uWwMJvYHwPZsM+g@mail.gmail.com>
	<20120706120700.GV1122@atomide.com>
	<CAP05o4L6CXjgDCe_eoY15aKFNDf7vMcYJGOqxpE3rMPSAxU57w@mail.gmail.com>
	<20120706123913.GX1122@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:42230 "EHLO
	na3sys009aog127.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750736Ab2GFNey (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jul 2012 09:34:54 -0400
Received: by lbbgj3 with SMTP id gj3so11693695lbb.25
        for <linux-omap@vger.kernel.org>; Fri, 06 Jul 2012 06:34:36 -0700 (PDT)
In-Reply-To: <20120706123913.GX1122@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, Partha Basak <parthab@india.ti.com>, sameo@linux.intel.com, balbi@ti.com, Kevin Hilman <khilman@ti.com>

On Fri, Jul 6, 2012 at 6:09 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Munegowda, Keshava <keshava_mgowda@ti.com> [120706 05:30]:
>> On Fri, Jul 6, 2012 at 5:37 PM, Tony Lindgren <tony@atomide.com> wrote:
>> >
>> > I think it's best to fix things properly, even if it means that it will
>> > take longer and go into next kernel version.
>>
>>     This requires ehci remote wakeup feature to be implemented, which
>> will take at least to 3 months to
>> get reviewed in opensource.
>> hence for now  kevin is also agreed to disable it by default;
>
> Why does echi need a "remote wakeup" feature? If you're talking about
> echi wake-up events, I don't see how that would affect core retention.

Hi Tony
     the cpu should hit the retention in idle; in this case,  up on
usb bus suspend ( no device connected) , if I cut the clock, then later
device detection happen through I/O wakeup, so implementing the
ehci remote wakeup using I/O chain handler ensure the retention in idle too.
now, with the existing ehci driver in mainline, whether device connected or not
the clocks are not cut and prevents the retention in idle.
so, I need to implement the ehci clock gating mechanism through I/O interrupts
in bus spend /resume . This activity will take some time.

regards
keshava
