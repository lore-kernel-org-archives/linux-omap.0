From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv7 00/36] ARM: OMAP: clock data conversion to DT
Date: Sun, 13 Oct 2013 23:45:20 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1310132023240.27397@utopia.booyaka.com>
References: <1380098922-30340-1-git-send-email-t-kristo@ti.com> <524EE00F.7010208@ti.com> <20131007021556.GV8949@atomide.com> <52525642.8010307@ti.com> <20131007154103.GW8949@atomide.com> <20131007190322.GY8949@atomide.com> <alpine.DEB.2.02.1310091551540.30199@utopia.booyaka.com>
 <alpine.DEB.2.02.1310091858411.30199@utopia.booyaka.com> <525654AE.7060009@ti.com> <alpine.DEB.2.02.1310111749180.27397@utopia.booyaka.com> <52584785.2020504@ti.com> <alpine.DEB.2.02.1310112226130.27397@utopia.booyaka.com> <525923AB.4030807@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:38229 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755331Ab3JMXpV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 13 Oct 2013 19:45:21 -0400
In-Reply-To: <525923AB.4030807@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, mturquette@linaro.org, linux-omap@vger.kernel.org, nm@ti.com, khilman@linaro.org, pdeschrijver@nvidia.com, rnayak@ti.com, bcousson@baylibre.com, linux-arm-kernel@lists.infradead.org, swarren@nvidia.com, mark.rutland@arm.com


Here you go:

1. Create DT nodes for the IP blocks that contain the clock control 
registers, underneath the appropriate bus node.  So for example OMAP4 
would have:

/ocp {

    prm@4a306000 { 
	compatible = xxx;
	regs = <0x4a306000 xxxx>;
    };

    cm1@4a004000 { 
	compatible = xxx;
	regs = <0x4a004000 xxxx>;
    };

    cm2@4a008000 { 
	compatible = xxx;
	regs = <0x4a008000 xxxx>;
    };

};

This is pure OS-independent hardware description (with the unfortunate 
exception of the "ocp" part).


2. Create the clock data underneath the corresponding PRCM/CM/PRM device 
nodes that their control registers exist in.  So for example, dpll_per_ck 
would belong to the "cm1" device, since that's where its control registers 
are located.  Something like this:

    cm1@4a004000 {
        ...
        clocks { 
            dpll_per_ck@.... {
		<clock data goes here>
            };
        };
    };


The DT data is intended to portray addressable devices from the 
perspective of the CPUs that are booted with that data, organized by bus 
structure.  From this point of view, clocks that are controlled via a 
particular IP block should have their data associated with that block.


3. Place clock register accesses in the low-level PRCM/CM/PRM device 
driver.  If other kernel code needs some resource that's provided by the 
IP block, it should either come from common Linux framework routines (like 
the clock code), or use functions exported from the low-level driver that 
don't expose register addresses.

Otherwise, if MMIO accesses to that device are allowed from all over the 
codebase, it creates an undebuggable mess:

A. It could result in IP blocks being partially programmed before they are 
probed by their drivers.  If their drivers (or the integration code) reset 
the IP blocks, the non-driver code has no way of knowing that it needs to 
reprogram the underlying IP block.

B. If any preparation is needed before the clock registers can be 
accessed, like runtime PM calls or device_enable()-type calls, this should 
be coordinated by the low-level IP block itself.  We don't expect this to 
be the case for PRCM/CM/PRM, but we do expect it to be the case for UART, 
DSS, some audio clocks, etc.

C. The low-level IP block drivers may want to implement some caching layer 
like regmap.  If some register writes bypass the low-level driver, then 
someone is likely to get a big unpleasant surprise.

D. It impairs the common debugging technique of adding code to the IP 
block MMIO read/write functions to log register accesses.



4. Use relative register offsets from the top of the containing IP block's 
base address, rather than absolute addresses. 

   cm1@4a004000 {
        ...
        clocks {
            dpll_per_ck@4140 {
                <clock data goes here>
            };
        };
    };

This makes it possible to reuse the same DT clock data in cases where the 
same IP block is used, but at a different base address.  This is probably 
not a big issue with the system integration IP blocks, but quite possible 
with the non-SoC-integration IP blocks.  It also makes it obvious if 
someone tries to sneak clocks into the IP block data that aren't 
controlled by that IP block.


5. Register the clocks from the low-level IP block drivers, rather than 
from external code.  That way there's no need to export low-level register 
manipulation functions off to other kernel code.  This registration can be 
done when the PRCM/CM/PRM driver probes.


6. Move the OMAP clockdomain data underneath the DT node for the low-level 
IP block that contains them:


   cm1@4a004000 {
        ...
        clocks {
	       ...
        };

        clockdomains {
               l3_init_clkdm: l3_init_clkdm@... {
                   ... 
               };
        };
    };

For non-OMAP folks reading this thread, OMAP clockdomains have control 
registers associated with them, located in the PRCM/CM/PRM IP block 
address space, so that's where they belong.


7. drivers/clk/ti is probably the wrong place for most of the low-level 
drivers for IP blocks like the PRM/PRCM/CM.  Most of these IP blocks do 
more than just control clocks: they also control other system entities 
like reset lines, OMAP powerdomains, AVS, or OMAP "clockdomains" (which in 
some cases may have nothing to do with clocks).

drivers/clk/ti is almost defensible for CM, if it weren't for the OMAP 
"clockdomain" registers that are there.  However, for the other OMAP 
integration IP blocks, drivers/clk/ti definitely seems out of place.  And 
since some OMAP chips like OMAP2420 or AM43XX don't have separate CM and 
PRM blocks -- they combine them both into a single PRCM module -- it seems 
best to place CM, PRM, and other related code into a single common 
directory, so they can easily share code across chips.

I'd suggest putting them in drivers/sysctrl/omap/.  This would be intended 
for low-level SoC IP block drivers that control system integration. 
Otherwise drivers/clk/XXX is going to turn into another drivers/mfd.


8. A few random comments about the individual clock binding data formats 
themselves, based on a quick look:

A. It seems pretty odd and unnecessarily obscure to do something like 
this:

dpll_usb_ck: dpll_usb_ck@... {
       ...
       reg = <0x4a008180 0x4>, <0x4a008184 0x4>, <0x4a008188 0x4>, <0x4a00818c 0x4>;
       ...
};

It's at least self-documenting to do something like this:

dpll_usb_ck: dpll_usb_ck@... {     
       ...
       control-reg = < ... >;
       idlest-reg = < ... >;
       .. etc. ..
};

Which itself might not even be needed, depending on how the DPLL control 
code is implemented.  For example, if the relative offsets are always the 
same for all OMAP4-family devices, maybe there's not even a need to 
explicitly encode that into the DT data.

B. Seems like you can remove the "ti," prefix on the properties, since 
they have no pretentions at genericity: they are specific to the 
PRCM/CM/PRM IP block data, and registered by those drivers.

C. Looks like the patches use the property "autoidle-low" to indicate that 
the autoidle bit should be inverted.  "Low" seems like the wrong 
expression here - it invokes the actual voltage logic level of a hardware 
signal, and we have no idea whether the hardware signal is using a low 
voltage or a high voltage to express this condition.  Would suggest 
something like 'invert-autoidle-bit' instead.

D. Regarding "ti,index-starts-at-one", it seems best to explicitly state 
which index starts at one.  The code mentions a "mux index" so please 
consider renaming this something like "mux-index-starts-at-one" or 
"one-based-mux-index"



- Paul
