From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4] ARM: dts: Add minimal support for dm8168-evm
Date: Wed, 18 Mar 2015 09:54:54 -0700
Message-ID: <20150318165453.GP31346@atomide.com>
References: <1421192272-20754-1-git-send-email-tony@atomide.com>
 <1421192272-20754-5-git-send-email-tony@atomide.com>
 <20150117164709.GS18552@atomide.com>
 <CAALWOA-XVrC84=6Xt04m+QaBhweAcp2HVTH7v=QewtJmQLEaWA@mail.gmail.com>
 <20150202160932.GF16250@atomide.com>
 <20150318000652.GJ31346@atomide.com>
 <CAALWOA9yoS5sdo-A_hdqhkqGqZ-VCg9jZfdavhxskFdE_pA1Sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:38379 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932781AbbCRQ7i (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Mar 2015 12:59:38 -0400
Content-Disposition: inline
In-Reply-To: <CAALWOA9yoS5sdo-A_hdqhkqGqZ-VCg9jZfdavhxskFdE_pA1Sg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Brian Hutchinson <b.hutchman@gmail.com>, Felipe Balbi <balbi@ti.com>

* Matthijs van Duin <matthijsvanduin@gmail.com> [150318 01:33]:
> > And we also need to populate the tables along the lines of 27b7d5f3cc49
> > ("bus: omap_l3_noc: Add AM4372 interconnect error data").
> 
> I think intercon data should be in DT rather than some hardcoded table.

Yeah so it seems.
 
> > Do the below ranges match your JTAG results?
> 
> Yup. Based a memory dump I had done earlier, combined with the high
> degree of similarity with centaurus and filling in the remaining
> blanks with my best guess yields:
>
> 44000000 host L3F
> 44000100 target 01 dmm port 0
> 44000200 target 02 dmm port 1
> 44000300 target 03 iva 0 sl2 ?
> 44000400 target 04 iva 1 sl2 ?
> 44000500 target 05 dsp sdma
> 44000600 target 06 expansion port
> 44000700 target 07 edma tc 0
> 44000800 target 08 edma tc 1
> 44000900 target 09 edma tc 2
> 44000a00 target 0a edma tc 3
> 44000b00 target 0b edma cc
> 44000c00 target 23 system mmu
> 44000d00 target 25 iva 2 sl2 ?
> 44000e00 flagmux l3f
> 44000f00 flagmux top
> 44001000 statcoll

Oh there's a gap here and it goes all the way to 2400.. Is there
a gap on am335x too?

> 44001400 statcoll
> 44001800 statcoll
> 44001c00 bw-regulator
> 44001d00 bw-regulator
> 44001e00 bw-regulator
> 44001f00 bw-regulator
> 44002000 bw-regulator
> 44002100 bw-regulator
> 44002200 bw-regulator
> 44002300 bw-regulator
> 44002400 bw-regulator
> 
> 44400000 host L3M
> 44400100 target 0d ducati
> 44400200 target 0e sgx
> 44400300 target 0f pcie
> 44400400 target 10 ocmc ram
> 44400500 target 11 vcp
> 44400600 target 12 iva config
> 44400700 target 13 iss
> 44400800 target 14 tppss
> 44400900 target 15 l4hs port 0
> 44400a00 target 16 secss
> 44400b00 target 24 l4hs port 1
> 44400c00 target 26 mmc 2
> 44400d00 target 1f l3_instr
> 44400e00 flagmux L3M
> 44401000 statcoll
> 
> 44800000 host L3S
> 44800100 target 18 vlynq ?
> 44800200 target 19 mcbsp
> 44800300 target 1a hdmi
> 44800400 target 1b l4fw
> 44800500 target 1c l4ls port 0
> 44800600 target 1d l4ls port 1
> 44800700 target 1e gpmc
> 44800800 target 20 mcasp 0
> 44800900 target 21 mcasp 1
> 44800a00 target 22 mcasp 2
> 44800b00 target 27 usb
> 44800c00 flagmux L3S

OK that's great, thanks for the data!
 
> Note BTW that centaurus (in contrast with netra and subarctic)
> actually has a pretty good interconnect chapter with full register
> maps (except for the L3 firewals).

OK that's good to hear.
 
> > That got me wondering if we can actually scan that data based
> > on the ranges below as target is 00130001 and flagmux 00370001.
> > We would be missing the names, but that would be still less data
> > to pile up in the kernel :) If some module is disabled, then it
> > should never produce errors so it seems safe to scan the data..
> 
> Note that reading invalid addresses while scanning does yield bus
> errors you'd need to trap. There can be gaps, and some modules can be
> larger than 0x100 (e.g. statcoll is variable in size), but other than
> that it's just a matter of reading words in increments of 0x100 and
> match with one of the known types:
>         // 13'0001  target
>         // 1a'0001  host
>         // 2c'0001  bw_limiter
>         // 2d'0001  rate_adapter
>         // 31'0001  bw_regulator
>         // 37'0001  flagmux
>         // 38'0001  pwr_discon
>         // 3a'0001  statcoll
> 
> The statcoll content should read as zeros after reset, so no risk in
> accidently detecting a module inside it.
> 
> > Can we dig even more info?
> 
> Much can be auto-detected indeed, although it may be preferred to use
> auto-detection to generate the data, assign missing names, and then
> have other users use that data file.
> 
> If you know where the FlexNOC L3 intercon registers themselves are
> located (called the "service network" in Vayu), then you can scan the
> L3 with the following steps:
> 
> 1. Detect all FlexNOC components as mentioned above. The components we
> care about for now are Target NIUs and Flagmuxes, and optionally the
> Host to decode errors while scanning the service network itself. In
> this step you learn the association Target NIU regbase <-> Target NIU
> ID since this is indicated in one of the regs.   Make sure error
> logging is enabled for all targets.
> 
> 2. Disable all L3 Target NIUs. You will temporarily lose access to all
> peripherals, OCMC ram, and on subarctic also DDR memory (I think on
> devices with a DMM you'd retain access to DDR memory). Note that the
> service network itself isn't considered an L3 target.

Hmm well we could that in the kernel using the SRAM code as long as
it does not reset the devices.
 
> 3. Probe the whole address space with reads or writes, while trapping
> data aborts (or use posted writes, those won't generate a data abort
> but only signal the L3 error irq).  The smallest L3 ranges I've seen
> so far were 64 KB, so scanning the whole address space would require
> 2^16 accesses. Shouldn't take too long. Ranges which are not routed to
> L3 targets (e.g. the service networks themselves, or MPUSS-local
> peripherals) should be manually excluded.

OK the driver would have to be enabled with interrupts while scanning.
 
> 4. For each access, examine the Flagmux modules and Target NIU error
> logs. (Then clear the error log for the next access) You should now
> learn:
>   a. which target was reached at that address
>   b. to which target-local address it was mapped
>   c. which bit of which flagmux is used for errors from this target
>   d. to which bit of the top flagmux this flagmux connects
> 
> Note that usually a Target NIU will have its regs in the service
> network of the L3 it belongs to, and report errors to the associated
> Flagmux. Centaurus is a counter-example since for some odd reason its
> DMM Target NIUs regs moved to the L3M service network, even though
> they attach to the L3F and report errors to the L3F flagmux.
> 
> Distinguishing the top flagmux from the others, or even more general
> flagmux topologies, can also be deduced programmatically but I'm not
> sure that's worth the effort.
> 
> The target which seems to be reachable at many many address ranges,
> none of which documented as containing any peripheral, is your "error
> target" where unroutable packets are sent to to generate an error
> reply.
> 
> 5. Reenable all target NIUs.
> 
> 6. Identify the L3 targets. This will be semi-automatic at best, since
> there's no generally reliable way to do this. Not all peripherals have
> a highlander-style revision register, and even the ones that do
> sometimes have it at a non-zero offset or failed to pick a unique
> function code to identify the module. (Or split it into two 16-bit
> halves in consecutive 32-bit registers... nicely done, omap-i2c)
> 
> One interesting option is keeping a database of L3 targets across
> multiple devices and taking advantage of design reuse: if you find a
> target whose NIU ID and mapped memory ranges match those of a specific
> target in another device, then there's a good chance they are in fact
> the same. This is highly visible in centaurus vs subarctic for
> example.

Yes sounds like that would be probably the best way to go eventually.
 
> 7. Some targets will be other interconnects; proceed with inspecting
> those. (Fortunately the L4 intercons are easier to scan).

Thanks for all the info :)

Regards,

Tony
