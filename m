From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PM-WIP-OPP][PATCH 1/4] omap3: pm: cpufreq: BUG_ON cleanup
Date: Fri, 19 Mar 2010 10:46:54 -0700
Message-ID: <871vfgxkz5.fsf@deeprootsystems.com>
References: <1268937891-19445-1-git-send-email-nm@ti.com>
	<1268937891-19445-2-git-send-email-nm@ti.com>
	<87tysdi6tq.fsf@deeprootsystems.com> <4BA3886E.9070906@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:47053 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751637Ab0CSRq7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Mar 2010 13:46:59 -0400
Received: by pwi5 with SMTP id 5so1390600pwi.19
        for <linux-omap@vger.kernel.org>; Fri, 19 Mar 2010 10:46:59 -0700 (PDT)
In-Reply-To: <4BA3886E.9070906@ti.com> (Nishanth Menon's message of "Fri\, 19 Mar 2010 09\:21\:34 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Linux-Omap <linux-omap@vger.kernel.org>, "K, Ambresh" <ambresh@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, Phil Carmody <ext-phil.2.carmody@nokia.com>, "Premi, Sanjeev" <premi@ti.com>, Tero Kristo <tero.kristo@nokia.com>, "Gopinath, Thara" <thara@ti.com>

Nishanth Menon <nm@ti.com> writes:

> Kevin Hilman had written, on 03/18/2010 05:49 PM, the following:
>> Nishanth Menon <nm@ti.com> writes:
>>
>>> BUG_ON should not ideally contain a functional code. Remove it out.
>>
>> True.  But this code should not be using BUG_ON() in the first place.
>>
>> We should not crash the whole kernel in this case, just fail
>> with a warning.
>>
>> If you're cleaning this up, can you make it fail more gracefully.
> I agree  if this was a preipheral driver or a non-critical path. but
> in this case:
>
> a) we are speaking of a core description of the h/w - OPPs frequencies
> and voltages which out which the functionality of the system is at
> stake. I am not speaking of just having a basic kernel boot up to
> shell prompt - we need the kernel to do much better than that.

A system can boot fine without OPPs/DVFS.  OPPs will not be
registered with CPUfreq, and no DVFS atempts will be made.  

> b) Is there any reason why the registration could fail - if it did
> fail at this point, there is something catastrophic happening - some
> other driver is going beserk OR Opp layer is by itself screwed up -
> why continue if we can warn the system and force a fix of the code?

Using WARN() will produce a nice loud message that alert users, get
reported and get fixed as well.

> c) is there a recovery mechanism to put the system back in a usable
> mode with dvfs etc? I might prefer to get some ideas on it..

What is to recover from?  While not optimal in power/performance, a
kernel can boot and work just fine without OPPs/DVFS.  If this call
fails, no DVFS will be available but the system is still quite usable.

The bigger problem is that everyone things that their
feature/subsystem is so crucial that any problems should hang the
system, when things could actually continue just fine without it in
most cases.

IMO, Using BUG* macros usually indicates improper or incomplete error
handling rather than a real catastrophic system failure.

Kevin

