From: Kevin Hilman <khilman@ti.com>
Subject: Re: 3.5-rc3: PM/DSS broken (was vdd_mpu_iva warnings)
Date: Wed, 04 Jul 2012 07:01:39 -0700
Message-ID: <87vci339rw.fsf@ti.com>
References: <WC20120618103957.6103F2@terrafix.co.uk> <87zk7h5096.fsf@ti.com>
	<WC20120703083759.980337@terrafix.co.uk> <4FF2B476.6000900@ti.com>
	<WC20120703091232.480345@terrafix.co.uk> <4FF2D089.8030507@ti.com>
	<WC20120703135255.990389@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:57336 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750917Ab2GDOBb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jul 2012 10:01:31 -0400
Received: by pbbrq13 with SMTP id rq13so11824987pbb.8
        for <linux-omap@vger.kernel.org>; Wed, 04 Jul 2012 07:01:29 -0700 (PDT)
In-Reply-To: <WC20120703135255.990389@terrafix.co.uk> (Joe Woodward's message
	of "Tue, 03 Jul 2012 14:52:55 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>
Cc: Archit Taneja <a0393947@ti.com>, tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, jaswinder.singh@linaro.org

"Joe Woodward" <jw@terrafix.co.uk> writes:

> ...snip...
>
>> > #
>> 
>> Thanks for testing this out.
>> 
>> I was going through Tomi's queue for the 3.6 merge window:
>> 
>> git://gitorious.org/linux-omap-dss2/linux.git master
>> 
>> There is a commit called:
>> 
>> 2b8501d777346ce1d4fe99167e9b3c0e42aae7a8
>> 
>> OMAPDSS: Use PM notifiers for system suspend
>> 
>> The commit message mentions the issue you see, and seems to resolve it.
>> Could you give this a try?
>> 
>> Tomi is out on vacation, and I don't know why this wasn't intended for 
>> the 3.5-rcs, maybe there are still some discussion going on about this?
>> 
>
> Thanks, this did remove the DSS warnings when suspending.
>
> Is there any chance this patch will make 3.5, or is it far too late now?
>
> However, core still fails to power down:
> # echo mem > /sys/power/state
> [   64.905975] PM: Syncing filesystems ... done.
> [   64.926879] Freezing user space processes ... (elapsed 0.01 seconds) done.
> [   64.952697] Freezing remaining freezable tasks ... (elapsed 0.02 seconds) done.
> [   64.983947] Suspending console(s) (use no_console_suspend to debug)
> [   65.115112] PM: suspend of devices complete after 121.215 msecs
> [   65.117797] PM: late suspend of devices complete after 2.655 msecs
> [   65.122314] PM: noirq suspend of devices complete after 4.486 msecs
> [   65.122344] Disabling non-boot CPUs ...
> [   66.095733] Powerdomain (core_pwrdm) didn't enter target state 1
> [   66.095733] Could not enter target state in pm_suspend
> [   66.098236] PM: noirq resume of devices complete after 2.319 msecs
> [   66.101409] PM: early resume of devices complete after 1.770 msecs
> [   66.471008] mmc1: error -110 during resume (card was removed?)
> [   66.516784] PM: resume of devices complete after 415.252 msecs
> [   66.580841] Restarting tasks ... done.
> sh: write error: Operation not permitted
>
> I'm guessing this is a question for Kevin, any idea how to debug this?

Already debugged and fixed. The exact solution is still under
discussion, but while waiting for the right fix, you can use this patch
and you should see CORE hitting retention:

   http://marc.info/?l=linux-omap&m=134000053229888&w=2

>
> Also, why is it now saing "sh: write error: Operation not permitted" after waking, this never happened with 3.4?

I have seen this here and there and have never looked into why that is
happening.  Clearly the write actually worked because the suspend
happened, so I'm not sure what's going on there.

Kevin

