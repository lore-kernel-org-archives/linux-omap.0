From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v4-alt 3/6] ARM: OMAP3: hwmod data: add gpmc
Date: Tue, 22 May 2012 11:35:39 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E98F2FF@DBDE01.ent.ti.com>
References: <cover.1335941443.git.afzal@ti.com>
 <99ffbbcc634022ed3c781c37e03989f1d898003e.1335941444.git.afzal@ti.com>
 <alpine.DEB.2.00.1205051949290.20926@utopia.booyaka.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E987188@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1205080915220.9984@utopia.booyaka.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E98A2F3@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1205212344460.1275@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54105 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758446Ab2EVLfp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 May 2012 07:35:45 -0400
In-Reply-To: <alpine.DEB.2.00.1205212344460.1275@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Paul,

On Tue, May 22, 2012 at 12:17:30, Paul Walmsley wrote:
> Hi Afzal
> 
> On Thu, 10 May 2012, Mohammed, Afzal wrote:
> 
> > On Tue, May 08, 2012 at 21:02:33, Paul Walmsley wrote:
> 
> (attribution lost)

Hmm, second time, normally I try to delete as much as possible contents from
the original mail to make it more readable while keeping the core

> 
> I'd suggest implementing two ways of programming the GPMC from the kernel.
> 
> The first, preferred, method would be used with boards that we have timing 
> data for that is independent from the GPMC clock rate -- i.e., timing 
> data in nanoseconds or picoseconds.  These boards will be capable of CORE 
> DVFS.
> 
> The second, deprecated, method would be used with boards that we only have 
> GPMC clock rate-dependent timing data for -- i.e., raw GPMC register data.
> These boards will not be CORE DVFS-capable.
> 
> It should be possible for the kernel to configure the GPMC with either one 
> of these methods, either from DT or from platform_data.
> 
> I'd suggest starting by adding code to allow a board file/DT to configure 
> the GPMC to set the timings for a given chip-select based on clock 
> rate-independent data (the first method above).  Some good starting points 
> for this code would be in the arch/arm/mach-omap2/gpmc-*.c files.  Then 
> the rate-independent data can be added for the boards which have available 
> schematics or for which we have the data.  For the DT case, you'll 
> probably need to define a clock rate-independent binding if you haven't 
> already.
> 
> Next, I'd suggest implementing the code to allow GPMC timing configuration 
> from raw register data (the second method above).  This is hackish but for 
> some boards, this is all we'll have.  This will also presumably require 
> some extra DT bindings for the register data.  If this method is used, 
> this code should also call a PM function to block clock rate changes on 
> the GPMC clock, and an explanatory warning should be logged to the 
> console.
> 
> For boards that we don't have access to, and all someone would have are 
> the register values set by the bootloader, I'd propose a phased approach:
> 
> 1. The kernel should log the bootloader-provided GPMC timing registers to 
> the console during boot, along with a warning message that indicates that 
> GPMC for these boards will cease to function in the near future unless 
> patches are provided to update the kernel board file and/or DT data with 
> the GPMC register contents.  This should allow people who have those 
> boards and who care about them to submit kernel patches to allow the 
> GPMC-attached devices to continue to function.
> 
> 2. A patch to Documentation/feature-removal-schedule.txt should be
> submitted which states that support for implicit bootloader GPMC timings
> will be removed within two or three kernel releases.
> 
> 3. The board maintainers and anyone who has contributed to the mainline 
> git tree for those boards who seems to actually have the board should be 
> contacted with a short E-mail message asking them to update their board 
> GPMC timings.
> 
> 4. When the expiration date specified in #2 is released, 
> HWMOD_INIT_NO_RESET would be removed from the GPMC hwmod, and the GPMC 
> code should refuse to initialize unless explicit timing data has been 
> provided.
> 
> If this protocol is followed, I wouldn't have a significant objection to 
> specifying HWMOD_INIT_NO_RESET for the GPMC.  That's because, under these 
> conditions, the flag will only be present for a short period of time, and 
> there will be a strong incentive for people with those boards to update 
> the mainline board file/DT data with the GPMC timings.  Otherwise their 
> boards will be broken.

Summarized GPMC tasks as per my understanding based on Tony's & yours
comments and that I am working on as follows,

1. convert to driver
2. remove dependency of bootloader for configuration

Approach being taken is to migrate to driver while keeping old interface w.r.t
boards intact (i.e. configuring gpmc in board files for old interface can be
done the way it is done now, tasks now achieved in gpmc_init would be done by
probe, only that much, but that would not make any difference for boards using
old interface) along with having new interface till all boards are converted to
use new interface. Once all boards are converted to use new interface, old
interface would be removed. For boards using new interface, in probe, in addition
to the tasks presently done by gpmc_init, it would do configuring for boards,
creating platform devices for the peripherals connected.

Configuration that is not presently done in Kernel would be handled the way
you have suggested; first preference clk rate independent, if not possible
then use register values, if that also not possible do as per your points
1-4. GPMC configuration that would be added newly in the Kernel would be
using new interface

Tony, Paul, please let me know if you have any divergent views on the above.

> 
> > > > Another issue on OMAP3EVM is the detection of evm revision based on 
> > > > phy id, by reading hardcoded address, 0x2c000000. It had to be 
> > > > skipped to reach till above mentioned.
> > > 
> > > Looking at omap3_evm_get_revision() it seems that the OMAP3EVM 
> > > detection happens by reading the Ethernet chip's revision register.  
> > > So can't this be fixed by programming the GPMC appropriately to access 
> > > the Ethernet chip first?
> > 
> > I did not get you, may be let me explain the problem once again,
> > 
> > 0x2c000000 is physical address configured by bootloader. And omap3evm board
> > file depends on this value to read eth chip revision register. Ideally this
> > register should be accessed by smsc911x driver only.
> > 
> > Once gpmc is reset, physical address for smsc911x can vary.  With gpmc 
> > driver conversion, address of smsc911x register would be available only 
> > to smsc911x driver, and this address would not be setup until gpmc 
> > driver is probed, and so would not available for omap3_evm_get_revision, 
> > which has to be called before gpmc device registration.
> > 
> > And here we are depending on eth revision register to find board revision.
> 
> Perhaps I am misunderstanding you.  Are you stating that the Ethernet 
> controller is wired to appear at different physical addresses, depending 
> on the board revision?  And that there is no other way to determine the 
> board revision, other than to attempt to access the Ethernet controller?
> 
> If that is the case, then that board's hardware design seems broken.  
> There should be an unambiguous, side-effect-free way to determine the 
> board revision.  That said, there still seem to be ways to work around it.  
> For non-DT kernels, I'd suggest defining a kernel command line option 
> which would specify the board revision to this specific board file, which 
> then could configure the GPMC appropriately.  The bootloader could pass 
> this flag.  For DT kernels, the GPMC setup information should be passed in 
> the DT data.

No, physical address is same, init_machine would no longer have same physical
address valid if reset is done by hwmod, hence address with which omap3evm
tried to find eth revision register would no longer be valid as address is
hardcoded. Once gpmc driver is probed we can have a valid physical address, but
it may differ from what is hardcoded & would not be available at init_machine

I will try whether omap3evm board revision can be found some other way.

Thank you for the detailed reply.

Regards
Afzal
