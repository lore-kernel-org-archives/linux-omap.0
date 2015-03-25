From: Nishanth Menon <nm@ti.com>
Subject: Re: omap voltage management
Date: Wed, 25 Mar 2015 17:47:12 -0500
Message-ID: <CAGo_u6rjAfzZ9YO0xDFcZQi1Su6fThn8xaKUAJ2xH_jK-Lf8mw@mail.gmail.com>
References: <CAJ2oMhKGG9YrM4+rVdi2wZP=y4OBmCkw3GjgwBq-HpvtbWyNVg@mail.gmail.com>
	<20150319202750.GM31346@atomide.com>
	<CAJ2oMhLTH5ix0-6i=bzyqsGVuhf3aJUY5RhYyDLacdKOTCLNRg@mail.gmail.com>
	<CAJ2oMhKLL8O2Pngg4=YwLmOMApvnJm9UPUhu+SJ421H72ONhTg@mail.gmail.com>
	<20150325214725.GC31346@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:33623 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022AbbCYWrM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Mar 2015 18:47:12 -0400
Received: by ignm3 with SMTP id m3so3340655ign.0
        for <linux-omap@vger.kernel.org>; Wed, 25 Mar 2015 15:47:12 -0700 (PDT)
In-Reply-To: <20150325214725.GC31346@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Ran Shalit <ranshalit@gmail.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Wed, Mar 25, 2015 at 4:47 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Ran Shalit <ranshalit@gmail.com> [150321 12:18]:
>> On Fri, Mar 20, 2015 at 7:11 AM, Ran Shalit <ranshalit@gmail.com> wrote:
>> >> We currently are missing dm8148 support from mainline, dm8168
>> >> does have basic support now. Adding dm8148 will hopefully happen
>> >> too with time permitting :)
>> >>
>> >
>> > Hi Tony,
>> >
>> > What is exactly the "voltage driver" capability ? Does it mean that it
>> > does not support AVS (feature for power saving) ?
>> >
>> > Regards,
>> > Ran
>>
>> Hi Tony,
>>
>> Is it AVS or "voltage scaling" (used with cpufreq) ?
>
> Nishanth might be able to summarize what all is happening :)

Oh Boy, where do i start?????

Overall.... quick < 5 min write up:

PMIC Voltage rail-> voltage domain -> power domain -> clock domain -> clocks IP
TRM for each OMAP technology IPs should show how this looks like

Voltage domain and voltage rail can be tweaked depending on how the
frequency of IPs are.
We do a lot of stuff to save power depending on SoC family.. Some
places like OMAP5/DRA7 certain features might be originally designed,
but later descoped due to various other reasons.. anyways..

Lets take OMAP3 and beagleboard as an example
SMPS1 supplies MPU voltage domain that has MPU power domain and A8 under it

MPU DPLL clocks A8, and you can play around with frequency for it.. as
we reduce frequency, we can actually operate it at lower voltage -
these are discrete pairs called OPPs - even though intermediate
frequencies are possible to function, SoC companies like TI cannot
test all possible combinations, so do not guarentee functionality at
intermediate frequencies beyond what is provided in the data sheet.

we let cpufreq control that depending on the various load conditions...

For a specific frequency, the simplest thing is just reduce voltage -
but can we do better? ofcourse yes. it kinda plays with how SoC
production wafers behave.. and the silicon process itself.. this is
where AVS comes into play - AVS (or Adaptive Voltage Scaling) is a set
of different techniques depending on the SoC and process node, process
type etc.. but basically, the game is to find the least possible
voltage for functioning at frequency X, for a specific sample instance
at a certain point in time. AVS class0, class1, 1.5, 2 and class 3 are
some of the techniques used, there are aspects of temperature
compensation on certain SoCs as well. But this just ensures that the
worst possible usecase can still function at frequency X and tries to
reduce voltage below the OPP start voltage point (start voltage is
called nominal voltage in some parts of TI)..

Now, for the specific frequency, you can play further games by
controlling transistor leakage by providing a bias voltage - this is
called ABB - which is an SoC internal LDO, which can be controlled as
well - we can reverse or forward bias depending on vdd (voltage domain
voltage)

in a nut shell:
- A8 can operate in multiple frequencies
- for each frequency X, we can come with a common voltage which works
on every single silicon for every time for worst case usecase for the
worst possible conditions - we call this as nominal voltage(Y), this,
and the tuple (X,Y) is what we define as OPP - which is generic for
any OMAP3 sample.
- to do optimization per sample, we now need to tweak Y to lower value
- this is done along with tweaking ABB. - this ensures that as little
leakage of transistor at the least voltage is used for achieving
frequency X.


Does the game end there? nope. we can play even more.. Lets say at
frequency X, we dont have anything to do... ok, we can go to lower
power state - cpuidle, here we can gate clocks and go into different
deeper power saving states which trades off with wakeup latency
times.. at some lower power states, we dont even need the AVS
optimized voltage anymore.. - the voltage for operating in low power
state is called retention voltage - only some SoCs+PMIC combination
have ability to automatically do this since A8 itself is in idle when
the SoC decides it can achieve this low power state.


So voltage driver is a bit of a misnomer...
- Do we have a common entity that can ensure sequencing of AVS, ABB,
frequency in the right order in upstream - answer is no.. I did
attempt to post [1] but folks did not like it yet.. and i have'nt had
time to respin it - actually I dont really know where to go given that
maintainers differ in opinions..
- can we control a smps PMIC power supply? yeah - regulator framework
and corresponding regulator driver
- can we control ABB - yep - we have abb regulator driver in upstream
- can we control frequency - yep - all clock framework stuff
- what do we need for avs support? - well... VC and VP need to become
dt only (attempted[2]-but got killed), then AVS smartreflex need to be
modified to fit into that new framework - again dt-fication pending..
never got around to it..

my wish list from long time[3] is still waiting...

Hope this helps..

[1] https://lwn.net/Articles/587018/
[2] https://lkml.org/lkml/2013/5/22/471
[3] https://plus.google.com/112464029509057661457/posts/gvyZQcNieoq

-- 
---
Regards,
Nishanth Menon
