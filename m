From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: omap3 pm: dependency between opp layer and cpufreq
Date: Fri, 28 May 2010 19:12:14 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E71FE512@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301E71FDD30@dbde02.ent.ti.com>,<4BFE9D7E.8020602@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E5828FC1@dbde02.ent.ti.com>
 <7A436F7769CA33409C6B44B358BFFF0C0132DE0A84@dlee02.ent.ti.com>
 <068A0169-7F7B-46D6-B3B6-462EEFB66026@student.utwente.nl>
 <4BFFC622.90904@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51089 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751973Ab0E1NmX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 May 2010 09:42:23 -0400
In-Reply-To: <4BFFC622.90904@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, Koen Kooi <koen@dominion.thruhere.net>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "eduardo.valentin@nokia.com" <eduardo.valentin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>

> -----Original Message-----
> From: Menon, Nishanth 
> Sent: Friday, May 28, 2010 7:03 PM
> To: Koen Kooi
> Cc: Premi, Sanjeev; linux-omap@vger.kernel.org; 
> eduardo.valentin@nokia.com; Kevin Hilman
> Subject: Re: omap3 pm: dependency between opp layer and cpufreq
> 
> On 05/28/2010 10:56 AM, Koen Kooi wrote:
> >
> > Op 28 mei 2010, om 09:39 heeft Menon, Nishanth het volgende 
> geschreven:
> >
> >>> -----Original Message-----
> >>> From: Premi, Sanjeev
> >>> Sent: Thursday, May 27, 2010 10:30 PM
> >>
> >> [...]
> >>
> >>>>
> >>>> 3) Was there any specific need to tie the functions 
> "opp_get_voltage"
> >>> and others to cpufreq only?
> >>>
> >>> yes, because without cpufreq there is no transitions in 
> the system :)
> >>>
> >>> [sp] I does - via bootarg - mpurate!
> >>>
> >>> When kernel boots, volatge must be set properly.
> >>> We cannot rely on u-boot to be settiing everything 
> correctly. e.g. 720MHz
> >>> on OMAP3530 would fail at nominal 1.2V set by u-boot.
> >>
> >> I agree, but mpurate does not seem to use the cpufreq 
> interfaces - so is
> >> kinda a question how it interfaces back ->  but note, 
> mpurate tells us what
> >> the start freq is for the system - it still does no 
> *dynamic* transitions -
> >> just a static startup frequency. But I agree, it assumes 
> that if you provide
> >> mpurate, the system supposedly is operating at that 
> frequency, aka all
> >> setups have been done for that operational 
> frequency(including voltage)
> >
> > There's also a funny bug in the current (PSP) 
> mpurate/cpufreq code. The mpurate code has a
>  > check for 720MHz on 35xx silicon, but cpufreq doesnt. So I can do:
> >
> > setenv bootargs '<foo>  mpurate=720'
> >
> > And the kernel will say "unsupported" and not switch to 
> 720MHz during boot. But if I do this after boot:
> >
> > cpufreq-set -f 720
> >
> > it *will* switch to 720MHz, even if the mpurate code 
> explicitly forbids it. I tested on all the
>  >OMAP3 silicon I have and it will run at 720MHz fine, even 
> if it's out 
> of spec, so I'm happy with this bug :)
> 
> :) on mainline, if you dont have the frequency in opp definitions and 
> your board has not done an explicit opp_add, cpufreq will 
> only set u to 
> the nearest available freq - easy for mainline fix if someone 
> would like 
> to send a patch adding the OPPs and the detection logic involved for 
> enabling them.
> 
> Now, thinking aloud, the voltage setting by SR will probably occur in 
> late_init, if mpurate is setting the clock earlier in the 
> boot process, 
> we might have a potential conflict in the mpurate expecting 
> the system 
> to be set in a certain voltage based on Sanjeev's argument, but not 
> actually there.. we expect ondemand+cpufreq to do the job on runtime 
> anyways.

Nishanth,

When setting via mpurate, we need to get the appropriate voltage
corresponding to the mpurate so that right combination can be done.

This is where the mapping between freq and voltage needs to be queried.
And OPP layer is best placed to provide the info... without duplication.
The mechanism of changing the voltage itself can vary on the PMIC.

BTW, I am getting ready to submit an updated patch for mpurate. Just
waiting for an early resolution to this discussion.

~sanjeev
> 
> Regards,
> Nishanth Menon
> 