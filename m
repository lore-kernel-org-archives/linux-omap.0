From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v6 07/10] ARM: OMAP2+: gpmc: generic timing calculation
Date: Mon, 27 Aug 2012 10:37:42 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9BA63D@DBDE01.ent.ti.com>
References: <cover.1345524670.git.afzal@ti.com>
 <83b963e4ebcc1009a26a8c6419c785ac6d742c0b.1345524670.git.afzal@ti.com>
 <50359C64.40603@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54877 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752722Ab2H0Khu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Aug 2012 06:37:50 -0400
In-Reply-To: <50359C64.40603@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Jon,

On Thu, Aug 23, 2012 at 08:28:44, Hunter, Jon wrote:
> On 08/21/2012 05:45 AM, Afzal Mohammed wrote:

> > +/* can the cycles be avoided ? */
> 
> What is the above comment referring too?

This was added in the initial stages and refers to the usage of
cycles in struct gpmc_device_timings. I wanted to avoid usage
of cycles, but it seems it is required logically as well. This
was mentioned as a note for future to find out whether at any
future point of time this can be removed.

> > +/* Device timings in picoseconds */
> 
> Why pico seconds and not nanoseconds? I understand you may need to
> temporarily convert to pico-secs for rounding, but when providing timing
> it seems nano-secs is more suitable.

For more accuracy, if you see some of the tusb6010 calculation
are in picoseconds, this can be true for any device although
only tusb does so. If we hold on to picoseconds till the last
moment, value would be more accurate. For eg. 300 ps has to be
used in the case of tusb, and with ns, it can't be accounted for

> I am a little concerned about the above timings structure. For example,
> if I am adding support for a new devices it is not clear ...
> 
> 1. Which are required
> 2. Which are applicable for async, sync, address-data multiplexed etc.
> 3. Exactly how these relate to the fields in the gpmc registers.

Please see at the end

> 
> I understand that this is based upon how timings for onenand and tusb
> are being calculated today, but I am not sure that this is the way to go
> for all devices. Personally, I would like to see us get away from how
> those devices are calculating timings for any new device.

You cannot do away with many of the those, as logically they
are right. Eg. read data should be available at access time,
assuming a zero data hold time, we can very well derive an
expression as,

read de-assertion time (oe_off) = access time plus 1 gpmc clock,

and this is what the existing calculations do, and also the
generic routine. There could be other constraints, but this
certainly should be one (I do realize that oe_off could be
optimized to be less than access time, by relying on read
hold time, then again effect of it would be in similar way
for different peripherals, but let's forget about
optimization in the beginning)

> In general, I am concerned that we are abstracting the timings further
> from the actual register fields. For example, the timings parameter
> "t_ceasu" is described "address setup to CS valid" which is not
> incorrect but this value is really just programming the CSONTIME field
> and so why not call this cs_on?

Timing fields of struct gpmc_device_timings are selected such
that they should be bindable by DT. At least one of the peripheral
datasheet has these fields. If user knows timings in terms of
gpmc values, he can directly use struct gpmc_timings, but
then all the values should be updated in struct gpmc_timings.
User should not update some of the values in terms of
peripheral timings, others in terms of gpmc timings, that
would make things complex and does not seem the right way
to me.

cs_on and other gpmc aware timings could be binded by DT, not as
peripheral timing, but as gpmc timing.

Bindings for peripheral DT timings should be something that
can be obtained from peripheral datasheet, here accidentally
it is same as gpmc timings, but not most timings are this way.
Also there could be other constraints that can come for cs_on,
even though I have not come across any till now.

> 
> So although this may consolidate how the timings are calculated today, I
> am concerned it will be confusing to add timings for a new device. At
> least if I am calculating timings, I am taking the timing information
> for the device and translating that to the how I need to program the
> gpmc register fields.

If I am not wrong, GPMC IP has been present for around a
decade, and so far I have not come across any generic time
calculation method that can be applied to all peripherals.
Getting to work same peripheral for a different gpmc
frequency is another problem.

Here we are trying to generalize based on the understanding of
gpmc & peripheral timings, as well as by a kind of reverse
engineering without most of the hardware or datasheet. Think of
this as an attempt to create one, let it evolve and become a
robust one. If a new user want to add a peripheral, let him add
support, input timings are selected such that it is found in
peripheral datasheet, if that does not work, let him try
to add any new timing field or alter existing expression
as he deems to be proper and verify that it does not break
others. And I can help provided I am not heavily loaded
with other works.

And at least for initial users, they are expected to have
some grasp on how to calculate timings, such a user will
not be much worried about your 3 concerns above, anyway as
of now they need to have a good grasp on it.

Meanwhile I will try to document more.

Regards
Afzal
