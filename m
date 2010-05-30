From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: omap3 pm: dependency between opp layer and cpufreq
Date: Sun, 30 May 2010 16:20:26 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E5828FC2@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301E71FDD30@dbde02.ent.ti.com>
	 ,<4BFE9D7E.8020602@ti.com>
	 <B85A65D85D7EB246BE421B3FB0FBB59301E5828FC1@dbde02.ent.ti.com>
	 <7A436F7769CA33409C6B44B358BFFF0C0132DE0A84@dlee02.ent.ti.com>
	 <068A0169-7F7B-46D6-B3B6-462EEFB66026@student.utwente.nl>
	 <4BFFC622.90904@ti.com>
	 <B85A65D85D7EB246BE421B3FB0FBB59301E71FE512@dbde02.ent.ti.com>
	 <4BFFCB6B.50005@ti.com>
	  <B85A65D85D7EB246BE421B3FB0FBB59301E71FE537@dbde02.ent.ti.com>,<1275065163.10319.5.camel@Nokia-N900-51-1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33207 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065Ab0E3Kuh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 30 May 2010 06:50:37 -0400
In-Reply-To: <1275065163.10319.5.camel@Nokia-N900-51-1>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth menon <menon.nishanth@gmail.com>, "Menon, Nishanth" <nm@ti.com>
Cc: Koen Kooi <koen@dominion.thruhere.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "eduardo.valentin@nokia.com" <eduardo.valentin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>


________________________________________
From: Nishanth menon [menon.nishanth@gmail.com]
Sent: Friday, May 28, 2010 10:16 PM
To: Premi, Sanjeev; Menon, Nishanth
Cc: Koen Kooi; linux-omap@vger.kernel.org; eduardo.valentin@nokia.com; Kevin Hilman
Subject: Re: omap3 pm: dependency between opp layer and cpufreq

----- Original message -----
(...)
> > > > > > > [sp] I does - via bootarg - mpurate!
> > > > > > >
> > > > > > > When kernel boots, volatge must be set properly.
> > > > > > > We cannot rely on u-boot to be settiing everything
> > > > correctly. e.g. 720MHz
> > > > > > > on OMAP3530 would fail at nominal 1.2V set by u-boot.
> > > > > >
> > > > > > I agree, but mpurate does not seem to use the cpufreq
> > > > interfaces - so is
> > > > > > kinda a question how it interfaces back ->    but note,
> > > > mpurate tells us what
> > > > > > the start freq is for the system - it still does no
> > > > *dynamic* transitions -
> > > > > > just a static startup frequency. But I agree, it assumes
> > > > that if you provide
> > > > > > mpurate, the system supposedly is operating at that
> > > > frequency, aka all
> > > > > > setups have been done for that operational
> > > > frequency(including voltage)
> > > > >
> > > > > There's also a funny bug in the current (PSP)
> > > > mpurate/cpufreq code. The mpurate code has a
> > > >    >  check for 720MHz on 35xx silicon, but cpufreq doesnt.
> > So I can do:
> > > > >
> > > > > setenv bootargs '<foo>    mpurate=720'
> > > > >
> > > > > And the kernel will say "unsupported" and not switch to
> > > > 720MHz during boot. But if I do this after boot:
> > > > >
> > > > > cpufreq-set -f 720
> > > > >
> > > > > it *will* switch to 720MHz, even if the mpurate code
> > > > explicitly forbids it. I tested on all the
> > > >    >OMAP3 silicon I have and it will run at 720MHz fine, even
> > > > if it's out
> > > > of spec, so I'm happy with this bug :)
> > > >
> > > > :) on mainline, if you dont have the frequency in opp
> > definitions and
> > > > your board has not done an explicit opp_add, cpufreq will
> > > > only set u to
> > > > the nearest available freq - easy for mainline fix if someone
> > > > would like
> > > > to send a patch adding the OPPs and the detection logic
> > involved for
> > > > enabling them.
> > > >
> > > > Now, thinking aloud, the voltage setting by SR will
> > probably occur in
> > > > late_init, if mpurate is setting the clock earlier in the
> > > > boot process,
> > > > we might have a potential conflict in the mpurate expecting
> > > > the system
> > > > to be set in a certain voltage based on Sanjeev's argument, but not
> > > > actually there.. we expect ondemand+cpufreq to do the job
> > on runtime
> > > > anyways.
> > >
> > > Nishanth,
> > >
> > > When setting via mpurate, we need to get the appropriate voltage
> > > corresponding to the mpurate so that right combination can be done.
> > >
> > > This is where the mapping between freq and voltage needs to
> > be queried.
> > > And OPP layer is best placed to provide the info... without
> > duplication.
> > > The mechanism of changing the voltage itself can vary on the PMIC.
> > >
> > > BTW, I am getting ready to submit an updated patch for mpurate. Just
> > > waiting for an early resolution to this discussion.
> >
> > aye, I am aware of the concept here, just questioning what
> > does it mean
> > by setting mpurate to the kernel - it could mean two things:
> > a) mean this is mpurate that the system was working on (aka)
> > - now setup
> > the required stuff to continue to function at that rate.
> > b) go to this rate and forget where you were running at.
> >
> > the job of ondemand and other governors is to adjust to an
> > optimal OPP
> > using cpufreq which would conflict IMHO with (b), which kinda
> > questions
> > if you dont use cpufreq, does mpurate mean actually (a)?
>
> 'mpurate' is usually used when cpufreq is not required. It
> means - set me up for the specified freq and forget it. There
> is no further change needed/ possible.
That opens up the question - why not use cpufreq with userspace governor instead? Esp if u dont want a change in freq, ok i get the part where u'd like a single freq for the system to function at, but u also mention, mpurate is for systems that dont care abt any other dependencies. So, bit of a contradiction if it depends on scaling voltage to the right level aka u are selecting an freq from opp table.

This in my mind means u shud modify mpurate to use opp layer aka another user beyond cpufreq.

[sp] That what the discussion is all about. but currently the opp layer is hidden/ wrapped inside CONFIG_CPU_FREQ. And I want to move it out. See an earlier patch that I send to this effect.

>
> You could always argue that it can be done in u-boot; but this
> bootarg helps people choose target freq keeping the u-boot same.

Errr..... Makes me feel that u shud really be using cpufreq instead!
[sp] This bootarg is meant for setting frequency. without baggage of cpufreq; so why not use it?

 Either way i am not completely convinced u shud be doing voltage scaling when using mpurate given ur description- 
[sp] So how would I run the 3530 at 720MHZ when the VDD1 is only 1.2V OR 3630 at 1GHz via 'mpurate'? Do you expect it to run magically :)

if u are trying to write a new cpufreq layer, why not fix why cpufreq doesn't work for u and help the rest of us as well ;)
[sp] There is no mention of cpufreq not working; but specifically the support of bootarg "mpurate" which is independent of cpufreq.

The bootarg mpurate has been existing since quite sometime. I am neither creating a new layer / replacement for cpufreq not trying to duplicate the code. The intent is simply as stated below:

1) Expose OPP layer - don't hinde it under CONFIG_CPU_FREQ.

2) Use OPP layer to:
    - Validate that the requested mpurate is defined in the OPP table for the device
    - And get the voltage corresponding to the OPP.

3) Ensure that right freq and voltage is set - at init time - based on the mpurate.

4) And at some poit later break the linkage between op player amd PMIC.

>
> >
> > anyways for cpufreq to work at 720Mhz, you need to add that frequency
> > and corresponding voltage to the opptable, neither exists, further
> > mpurate should work with opp table as well, else
> > clockframework has no
> > direct mechanism to verify the valid OPPs on a runtime
> > system. that was
> > the intent of opp layer - to provide the rest of the users with a
> > mechanism to verify, query and use opps without functional
> > knowledge of
> > the silicon it works on..
>
> Same for mpurate, if the user only requests a freq and doesn't care
> about dependencies and mechanism for setting the freq.
No it does have a dependency- u are depending on voltage being set right for the freq=cpufreq functionality IMHO.

regrds,
NM

