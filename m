From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v6 2/4] ARM: dts: am437x-gp-evm: add support for parallel
 NAND flash
Date: Fri, 16 May 2014 14:01:51 -0700
Message-ID: <20140516210150.GA12881@atomide.com>
References: <1400238230-26357-1-git-send-email-pekon@ti.com>
 <1400238230-26357-3-git-send-email-pekon@ti.com>
 <537602FE.4020108@ti.com>
 <20140516162049.GF22031@atomide.com>
 <20980858CB6D3A4BAE95CA194937D5E73EACDBE5@DBDE04.ent.ti.com>
 <5376751C.1020300@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64785 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859AbaEPVB4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2014 17:01:56 -0400
Content-Disposition: inline
In-Reply-To: <5376751C.1020300@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: "Gupta, Pekon" <pekon@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Javier Martinez Canillas <javier@dowhile0.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

* Roger Quadros <rogerq@ti.com> [140516 13:30]:
> Pekon,
> 
> On 05/16/2014 09:52 PM, Gupta, Pekon wrote:
> > Hi Tony, Roger,
> > 
> >> From: Tony Lindgren [mailto:tony@atomide.com]
> >>
> >> * Roger Quadros <rogerq@ti.com> [140516 05:23]:
> >>> On 05/16/2014 02:03 PM, Pekon Gupta wrote:
> >>>> +&gpmc {
> >>>> +	status = "okay";
> >>>> +	pinctrl-names = "default";
> >>>> +	pinctrl-0 = <&nand_flash_x8>;
> >>>> +	ranges = <0 0 0 0x01000000>;	/* minimum GPMC partition = 16MB */
> >>>> +	nand@0,0 {
> >>>> +		reg = <0 0 0x37c>;	/* device IO registers */
> >>>
> >>> This register space is used by the parent GPMC node as well as the NAND controller. So doing a
> >> request_and_ioremap() on this space will fail as it is already taken by the GPMC driver.
> >>>
> >>> Further, the GPMC register space doesn't map to the GPMC memory map created by this Chip select
> >> but it is mapped to L3_IO space. i.e. (physical address 0x6e00 0000)
> >>>
> >>> We could have split the GPMC register space into GPMC part and NAND part but to add to the
> >> complexity, the register spaces for GPMC vs NAND are interleaved so it can't be easily split up. The way
> >> the NAND driver is currently written is that it expects the register addresses to come via platform data,
> >> primarily to get around this address interleaving issue.
> >>>
> >>> Apart from the GPMC register space, the NAND controller uses 4 bytes of GPMC memory map for
> >> I/O, and that is something that could be reflected here.
> >>>
> >>> e.g.
> >>> 		reg = <0 0 4>;		/* NAND I/O space */
> >>
> >> Guys, the reg size here is size of the IO region for the
> >> NAND driver, it should not have anything to do with the GPMC
> >> registers for the GPMC functions that the NAND driver may call.
> >>
> >> So it sounds like 0x37c is wrong, and 4 is the right value if
> >> the NAND chip has only one IO register.
> >>
> > Yes, Roger and myself both agree on the actual size of 4.
> > But what I'm not sure is what should be offset for a io-remapped region.
> > 
> > Apologies for my ignorance here, as I'm not good in this memory mapping concept..
> > -  I understand that for 'memory mapped' device <offset> is with respect to
> >    base-address of chip-select.
> > - But for indirectly mapped device (like NAND) how is  <offset> calculated?
> 
> This would depend on what the NAND driver expects. In the current OMAP nand driver it expects only the memory mapped NAND I/O resource. > 
> > Example: For CS0 in GPMC ..
> > GPMC_NAND_COMMAND_0 = 0x007c
> > GPMC_NAND_ADDRESS_0 = 0x0080
> > GPMC_NAND_DATA_0 = 0x0084
> 
> OK, let's say that we want to update that NAND driver to accept a second memory resource which would be the GPMC registers starting from GPMC_NAND_COMMAND_0 (phy.addr 0x6e00 007c), then we need to define a new address in the ranges property of the gpmc node. 
> 
> Something like so
> 
> 	ranges = <0 0 0x00000000 0x01000000	/* GPMC external map */
> 		  1 0 0x6e000000 0x0000037c>;	/* GPMC register map */
> 	nand@0,0 {
> 		reg = <0 0 4		/* NAND I/O space */
> 		       1 0x7c 3> 	/* NAND controller registers */
> 
> Since range 1 started from 0x6e000000 we specify offset as 0x7c.
> 
> But at the moment the NAND driver doesn't directly access the GPMC register map so it should be sufficient to just specify the I/O space.
> 
> > 
> > (1) Now, should the 'offset' for <reg> property used for NAND node
> >    connected at CS=0.  reg = <0 ??  4>
> >    (a) Should it be equal to 'GPMC_NAND_ADDRESS_0'?
> >    OR
> >    (b) There is no relation between 'GPMC register' and 'NAND partition' offset?
> > 
> > (2) If considering (a) then should size consider only GPMC_NAND_ADDRESS_0
> >    or also include GPMC_NAND_COMMAND_0 and GPMC_NAND_DATA_0?
> > 
> > This is why I used the size of complete GPMC register space for NAND region also.

The NAND driver should only ioremap the NAND register(s). The
GPMC driver has the GPMC registers ioremapped, and should allow
the NAND driver to use those registers via some functions in the
GPMC code. Those functions should be ideally made available to
the NAND driver by some Linux generic framework rather than
custom exported functions.

> >>> But still, the start address can't be 0 and has to be assigned when this CS region is mapped. It is still
> >> unclear to me how that can be done.
> >>
> >> If the offset for the NAND driver needs to be different from 0,
> >> it can be in the offset. For example, the smsc,lan91c94 driver
> >> wants the IO address space to be at offset 0x300 to avoid some
> >> extra warnings during the boot. So for that, the reg entry is:
> >>
> >> reg = <1 0x300 0xf>;
> >>
> >> Where we have:
> >>
> >> 1 = chip select
> >> 0x300 = offset of smsc device register IO space from the start of
> >>        16MB minimum GPMC partition
> > 
> > This is where my confusion lies, where is the 0x300 coming from?
> > Is this the offset of I/O register in given Ethernet IP register space?
> 
> I'm not sure about 0x300 but this is my guess.
> The smsc register addresses start at 0x300. In theory this could be aligned to the CS start address and we could have worked with 0 offset. But because of the 16MB min. granularity requirement for the GPMC CS start address, A23:A0 have to be 0. As CS start address can never be aligned to 0x300 we can't have 0 offset.

The 0x300 is just a legacy requirement by the smc91x.c
driver where it does some checking of the addresses. It
still works just fine if 0x300 is set to 0, but will warn
about the address space.

Regards,

Tony
