From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH v4-alt 3/6] ARM: OMAP3: hwmod data: add gpmc
Date: Tue, 22 May 2012 00:47:30 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205212344460.1275@utopia.booyaka.com>
References: <cover.1335941443.git.afzal@ti.com> <99ffbbcc634022ed3c781c37e03989f1d898003e.1335941444.git.afzal@ti.com> <alpine.DEB.2.00.1205051949290.20926@utopia.booyaka.com> <C8443D0743D26F4388EA172BF4E2A7A93E987188@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1205080915220.9984@utopia.booyaka.com> <C8443D0743D26F4388EA172BF4E2A7A93E98A2F3@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46815 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896Ab2EVGrb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 May 2012 02:47:31 -0400
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E98A2F3@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, khilman@ti.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Afzal

On Thu, 10 May 2012, Mohammed, Afzal wrote:

> On Tue, May 08, 2012 at 21:02:33, Paul Walmsley wrote:

(attribution lost)

> 
> > > Major reason was that there are some boards that rely on bootloader
> > > settings, eg. kernel does not do any setting for smsc911x. I did not
> > > want to break those, at least it causes problem with omap3evm, see below
> > 
> > But this is the whole point.  The Linux GPMC driver and integration code 
> > should be setting up the GPMC registers based on board file and/or DT 
> > data, before the kernel touches any GPMC devices.
> > 
> > We don't want to rely on the bootloader settings unless we absolutely have 
> > no other choice.  Otherwise, the stability of the kernel could easily be 
> > impacted by the bootloader's GPMC timings and other register settings, and 
> > we want to minimize those potential sources of variation.
> > 
> > So if we absolutely have no choice than to keep HWMOD_INIT_NO_RESET here, 
> > which doesn't sound like the case so far, we need to understand exactly 
> > why this is so.
> 
> There are 14 out of 20 boards partially or fully relying on bootloader
> settings. I will try to do configuration for smsc911x in Kernel itself,
> this is the only one that can be tested from my side (on omap3evm), but
> there are other peripherals like NOR, quaduart, onenand-flash (different
> from omap-onenand), then smc91x (timings are not set from kernel for
> sdp boards), these would affect 7 boards of both omap2 & omap3. To
> get configuration done from Kernel properly without having these boards
> is too tough for me.

I'd suggest implementing two ways of programming the GPMC from the kernel.

The first, preferred, method would be used with boards that we have timing 
data for that is independent from the GPMC clock rate -- i.e., timing 
data in nanoseconds or picoseconds.  These boards will be capable of CORE 
DVFS.

The second, deprecated, method would be used with boards that we only have 
GPMC clock rate-dependent timing data for -- i.e., raw GPMC register data.
These boards will not be CORE DVFS-capable.

It should be possible for the kernel to configure the GPMC with either one 
of these methods, either from DT or from platform_data.

I'd suggest starting by adding code to allow a board file/DT to configure 
the GPMC to set the timings for a given chip-select based on clock 
rate-independent data (the first method above).  Some good starting points 
for this code would be in the arch/arm/mach-omap2/gpmc-*.c files.  Then 
the rate-independent data can be added for the boards which have available 
schematics or for which we have the data.  For the DT case, you'll 
probably need to define a clock rate-independent binding if you haven't 
already.

Next, I'd suggest implementing the code to allow GPMC timing configuration 
from raw register data (the second method above).  This is hackish but for 
some boards, this is all we'll have.  This will also presumably require 
some extra DT bindings for the register data.  If this method is used, 
this code should also call a PM function to block clock rate changes on 
the GPMC clock, and an explanatory warning should be logged to the 
console.

For boards that we don't have access to, and all someone would have are 
the register values set by the bootloader, I'd propose a phased approach:

1. The kernel should log the bootloader-provided GPMC timing registers to 
the console during boot, along with a warning message that indicates that 
GPMC for these boards will cease to function in the near future unless 
patches are provided to update the kernel board file and/or DT data with 
the GPMC register contents.  This should allow people who have those 
boards and who care about them to submit kernel patches to allow the 
GPMC-attached devices to continue to function.

2. A patch to Documentation/feature-removal-schedule.txt should be
submitted which states that support for implicit bootloader GPMC timings
will be removed within two or three kernel releases.

3. The board maintainers and anyone who has contributed to the mainline 
git tree for those boards who seems to actually have the board should be 
contacted with a short E-mail message asking them to update their board 
GPMC timings.

4. When the expiration date specified in #2 is released, 
HWMOD_INIT_NO_RESET would be removed from the GPMC hwmod, and the GPMC 
code should refuse to initialize unless explicit timing data has been 
provided.

If this protocol is followed, I wouldn't have a significant objection to 
specifying HWMOD_INIT_NO_RESET for the GPMC.  That's because, under these 
conditions, the flag will only be present for a short period of time, and 
there will be a strong incentive for people with those boards to update 
the mainline board file/DT data with the GPMC timings.  Otherwise their 
boards will be broken.

> > > Another issue on OMAP3EVM is the detection of evm revision based on 
> > > phy id, by reading hardcoded address, 0x2c000000. It had to be 
> > > skipped to reach till above mentioned.
> > 
> > Looking at omap3_evm_get_revision() it seems that the OMAP3EVM 
> > detection happens by reading the Ethernet chip's revision register.  
> > So can't this be fixed by programming the GPMC appropriately to access 
> > the Ethernet chip first?
> 
> I did not get you, may be let me explain the problem once again,
> 
> 0x2c000000 is physical address configured by bootloader. And omap3evm board
> file depends on this value to read eth chip revision register. Ideally this
> register should be accessed by smsc911x driver only.
> 
> Once gpmc is reset, physical address for smsc911x can vary.  With gpmc 
> driver conversion, address of smsc911x register would be available only 
> to smsc911x driver, and this address would not be setup until gpmc 
> driver is probed, and so would not available for omap3_evm_get_revision, 
> which has to be called before gpmc device registration.
> 
> And here we are depending on eth revision register to find board revision.

Perhaps I am misunderstanding you.  Are you stating that the Ethernet 
controller is wired to appear at different physical addresses, depending 
on the board revision?  And that there is no other way to determine the 
board revision, other than to attempt to access the Ethernet controller?

If that is the case, then that board's hardware design seems broken.  
There should be an unambiguous, side-effect-free way to determine the 
board revision.  That said, there still seem to be ways to work around it.  
For non-DT kernels, I'd suggest defining a kernel command line option 
which would specify the board revision to this specific board file, which 
then could configure the GPMC appropriately.  The bootloader could pass 
this flag.  For DT kernels, the GPMC setup information should be passed in 
the DT data.


- Paul
