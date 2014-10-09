From: Nishanth Menon <nm@ti.com>
Subject: Re: cpuidle - minimum time for sleep
Date: Thu, 9 Oct 2014 14:20:39 -0500
Message-ID: <5436E007.7000909@ti.com>
References: <CAJ2oMhJXi-wxZJFcmm3LsTQOC35tAVKwr1PihUc0CmbnNtfPVQ@mail.gmail.com> <11792.1412881303@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35482 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751128AbaJITVF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Oct 2014 15:21:05 -0400
In-Reply-To: <11792.1412881303@turing-police.cc.vt.edu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Valdis.Kletnieks@vt.edu, Ran Shalit <ranshalit@gmail.com>
Cc: kernelnewbies <kernelnewbies@kernelnewbies.org>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux-embedded@vger.kernel.org

On 10/09/2014 02:01 PM, Valdis.Kletnieks@vt.edu wrote:
> On Thu, 09 Oct 2014 21:28:23 +0300, Ran Shalit said:
> 
>> Does anybody know what is the minimum expected time for sleep period
>> with the cpuidle ?
> 
> Both processor dependent and sleep level dependent.  There's a certain
> amount of latency induced by the hardware waking up.
> 
> Look at /sys/devices/system/cpu/cpu*/cpuidle/state*/latency
> 
Yes, that is correct. the sleep and wakeup time are dependent on the
power state we attempt (may or maynot achieve)

I personally toggle an unused pin using padmux register write with
weak pull up/down in controlled tests (mostly using disable =1 for
states I am not measuring), then capture pinctrl toggles using [1]
into a csv for many thousands of iterations then use the conservative
values. I usually do this at the slowest frequency to capture the
worst case values that i feed into cpuidle_driver.states.exit_latency
and appropriate value for target_residency - I usually ignore
power_usage as the value is never a constant and depends on quiet a
few factors that i cannot discuss in public domain.

Here are some helpful links on OMAP specific strategies (these may be
a little old, but just search for CPUIDLE latency measure in google)

https://lwn.net/Articles/384146/

http://www.omappedia.org/wiki/Power_Management_Device_Latencies_Measurement

http://lists.linaro.org/pipermail/linaro-dev/2010-August/000568.html


[1] https://www.saleae.com/

-- 
Regards,
Nishanth Menon
