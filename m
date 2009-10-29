From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] omap-pm: Fixes behaviour of some shared resource framework functions
Date: Thu, 29 Oct 2009 08:42:58 -0700
Message-ID: <87zl7a1a0t.fsf@deeprootsystems.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DDCE4650@dbde02.ent.ti.com>
	<87iqejktan.fsf@deeprootsystems.com>
	<alpine.DEB.2.00.0910281236270.19865@utopia.booyaka.com>
	<003201ca581b$256863c0$544ff780@am.dhcp.ti.com>
	<87hbtj3zpc.fsf@deeprootsystems.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301DE16EE0D@dbde02.ent.ti.com>
	<74583B8642AB8841B30447520659FCA9DDEF056E@dnce01.ent.ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301DE16F1FC@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.216.179]:52998 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755092AbZJ2Pm6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Oct 2009 11:42:58 -0400
Received: by pxi9 with SMTP id 9so1248700pxi.4
        for <linux-omap@vger.kernel.org>; Thu, 29 Oct 2009 08:43:03 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DE16F1FC@dbde02.ent.ti.com> (Romit Dasgupta's message of "Thu\, 29 Oct 2009 20\:22\:05 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Dasgupta, Romit" <romit@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, 'Paul Walmsley' <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Titiano, Patrick" <p-titiano@ti.com>, "Turquette, Mike" <mturquette@ti.com>

"Dasgupta, Romit" <romit@ti.com> writes:

> Hello Benoit,
>                         One comment below:
>> 
>> In fact, this is Mike who started that analysis. We discussed that internally and
>> our point is that if the CPUFreq ondemand or conservative heuristic is not able
>> to increase quickly enough the CPU need to handle correctly the UI, we have
>> to somehow improve or modify the governor in order to provide it a extra
>> information in term of constraint maybe in order to increase immediately the
>> frequency.
>
> The information as you mention needs to be supplied by the
> driver. The governor would then act on behalf of the driver!  This
> begs for a new governor API or a signature change to an existing
> governor API.
>
>> This should not be done in the low level omap_pm code; this is not
>> the right level to do that. The issue is in the ondemand and must
>> be fixed there.
> 
> At the end of the day it would still be the driver making the
> decision!

No.  The drivers can give hints about their requirements, but the
drivers don't make decisions that are system wide.  The govenor acts
on behalf of the entire system based on multiple inputs, not any one
driver.

Benoit's point (and I agree with) is that this is a *system wide*
problem that needs a *system wide* solution.  I agree that tweaked or
new governor is the right approach to solving this for the long term,

In the mean time, I have a couple ideas for experimentation.

Ultimately, we're still talking about a power vs. perfomance tradeoff,
which is a system wide choice that should be left to the system
integrator (or maybe even end user.)  If performance is desired over
power (like maybe when the UI is active), there are couple things that
could be done

1) Switch to performance governor, 

2) or better, keep ondemand but use with CPUfreq policy changes

With CPUfreq policies, you can change which OPPs are available to the
system.

To see the currently available OPPs and the min/max settings:

/sys/devices/system/cpu/cpu0/cpufreq # cat scaling_available_frequencies        
600000 550000 500000 250000 125000                                              
/sys/devices/system/cpu/cpu0/cpufreq # cat scaling_max_freq                     
600000                                                                          
/sys/devices/system/cpu/cpu0/cpufreq # cat scaling_min_freq                     
125000                                                                          

To make OPP3 the minimum OPP, all that's needed is:

/sys/devices/system/cpu/cpu0/cpufreq # echo 500000 > scaling_min_freq           

Changing the min freq is what you are trying to do from the MMC
driver.  The difference here is that since this is a system wide
policy decision, it should be done a system wide level.

Kevin
