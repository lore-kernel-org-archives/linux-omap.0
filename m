From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] gpio: omap-gpio: add support for pm_runtime autosuspend
Date: Wed, 31 Oct 2012 16:35:52 +0530
Message-ID: <50910610.5080602@ti.com>
References: <20121026114250.GA26342@arwen.pp.htv.fi> <1351257553-7896-1-git-send-email-tim.niemeyer@corscience.de> <508E266C.6090901@ti.com> <20121029080523.GC13657@arwen.pp.htv.fi> <508E3D09.9090802@ti.com> <20121029200328.GE30152@arwen.pp.htv.fi> <508F7471.8060402@ti.com> <87vcdr2ah9.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55920 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933580Ab2JaLGB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Oct 2012 07:06:01 -0400
In-Reply-To: <87vcdr2ah9.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: balbi@ti.com, Tim Niemeyer <tim.niemeyer@corscience.de>, Jon Hunter <jon-hunter@ti.com>, Linux OMAP List <linux-omap@vger.kernel.org>

On Wednesday 31 October 2012 04:07 PM, Kevin Hilman wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>
> [...]
>
>> Just to summaries, there are 3 things we are talking here.
>
> Santosh, thanks for the summary.  You are right on.
>
>> 1. Delaying the idle with a timeout which $subject patch is
>> trying to do to reduce latency for interrupts. That itself
>> is reasonable.
>
> I agree, this is reasonable.   IMO, adding autosuspend should be done as
> an isolated patch and kept separate from any other cleanup or changes.
>
> Also, as Jon mentioned, I think this should be done with a default
> timeout of zero so that current behaviour is unchanged.  Tim can then
> set the timeout from userspace for his usecase and everyone is happy.
>
Default 0 sounds good to me as well.

>> 2. Removal of the bank "mod_usage" which is also clubbed
>> in $subject path. Ofcourse that break the current driver
>> for idle. So that change needs to be made with better thought
>> and in a separate patch. This is doable.
>
> I had this discussion with Charu/Tarun during the last round of cleanup
> because I didn't like this mod_usage either.  The alternative is to do a
> 'get' for every GPIO in the bank since runtime PM is doing the
> usecounting already.  As Santosh said, this is fine for suspend, but for
> idle it means calling 'put' for every enabled GPIO in the bank instead
> of just forcing things with a single 'put.'
>
Exactly. The oherhead becomes too much when if you need to call put like 
6 Banks * 32 GPIOS times.
Actually even though there are 32 GPIOs in a bank, from PM point of
view, it only needs to care about a bank level control. Because
clocks and register set is per bank. And we model a GPIO device
per bank as well.

>> 3. Removing omap_gpio_[prepare/resume]_for_idle() with soome thing
>> better. For this one though, so far I have not come across a good
>> solution. Ideas/Solution is welcome !!
>
> I agree that the prepare/resume idle hooks a are ugly and should be
> removed, but this needs quite a bit more thought.  In particular,
> the 'remove triggering' stuff that is done needs pretty close
> examination.
>
> I'm not saying it can't be done, but patches to do this should be
> separate, well described and well tested, especially with off-mode.
>
Couldn't agree more. Thanks for confirming the points.

Regards
santosh

