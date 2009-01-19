From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: new PM branch available
Date: Mon, 19 Jan 2009 21:16:25 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301BBA4F654@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02E6815EA9@dbde02.ent.ti.com>
 <87fxjj845c.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36528 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751621AbZASPqi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Jan 2009 10:46:38 -0500
In-Reply-To: <87fxjj845c.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "Nayak, Rajendra" <rnayak@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

 

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin Hilman
> Sent: Saturday, January 17, 2009 12:33 AM
> To: Nayak, Rajendra
> Cc: linux-omap@vger.kernel.org
> Subject: Re: new PM branch available
> 
> "Nayak, Rajendra" <rnayak@ti.com> writes:
> 
> > I did some testing today on my 3.0GP 3430SDP. This is with 
> the omap_3430sdp_min_defconfig.
> >
> > 1) Idle.
> > echo -n 1 > /sys/power/clocks_off_while_idle echo -n 1 > 
> > /sys/power/enable_off Could not hit RET. something seems to 
> be still 
> > active. Not sure if it could be something to do with this 
> error that's 
> > thrown while bootup
> >
> > <6>Disabling unused clock "dpll5_ck"
> > Disabling unused clock "dpll5_ck"
> > <3>clock: dpll5_ck failed transition to 'locked'
> > clock: dpll5_ck failed transition to 'locked'
> 
> This is the same results I see on my SDP.
> 
> Looking at the registers, I am pretty sure it is the D2D 
> clockdomain that still has activity, but due to very poor 
> Stacked-mode docs and no responses to the D2D questions asked 
> to TI I have not been able to figure this one out.
> 
> Help debugging this would be greatly appreciated.
> 
> > Further doing a
> > echo -n 1 > /sys/power/sleep_while_idle causes a hang after 
> the 5 odd 
> > secs of UART inactivity.
> > Is'nt this option supposed to affect only the suspend path behavior?
> 
> No, this affects the common idle loop, with and without CPUidle.
> 
> > Is CPUidle disabled in the default defconfig now?
> >
> > 2) Suspend
> > echo -n 1 > /sys/power/clocks_off_while_idle Hangs on a echo mem > 
> > /sys/power/state Goes into suspend, but cannot recover
> 
> I'm pretty sure all the hangs going into RET are related.
> 
> Kevin
> 
> > 3) DVFS
> > Both VDD1 and VDD2 DVFS seem to function fine.
> >

[sp] I was trying to test DVFS on the OMAP3EVM. This log from my console illustrates the problems I face:

# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors
ondemand performance
#
# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
cat: read error: No such device
#
# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
performance
#
# echo -n "ondemand" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
#
# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
Performance

Here is snapshot from "menuconfig":
[*] CPU Frequency scaling
[ ]   Enable CPUfreq debugging
<*>   CPU frequency translation statistics
[ ]     CPU frequency translation statistics details
      Default CPUFreq governor (performance)  --->
-*-   'performance' governor
< >   'powersave' governor
< >   'userspace' governor for userspace frequency scaling
<*>   'ondemand' cpufreq policy governor
< >   'conservative' cpufreq governor

Currently building with ondemand as default...

Best regards,
Sanjeev

> >> -----Original Message-----
> >> From: linux-omap-owner@vger.kernel.org 
> >> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin Hilman
> >> Sent: Wednesday, January 14, 2009 3:22 AM
> >> To: linux-omap@vger.kernel.org
> >> Subject: new PM branch available
> >> 
> >> Hello,
> >> 
> >> The latest PM branch is now available[1].
> >> 
<snip>--<snip>
