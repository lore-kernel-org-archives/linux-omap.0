From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v6 2/4] ARM: dts: am437x-gp-evm: add support for parallel
 NAND flash
Date: Fri, 16 May 2014 09:20:50 -0700
Message-ID: <20140516162049.GF22031@atomide.com>
References: <1400238230-26357-1-git-send-email-pekon@ti.com>
 <1400238230-26357-3-git-send-email-pekon@ti.com>
 <537602FE.4020108@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:35313 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756073AbaEPQUz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2014 12:20:55 -0400
Content-Disposition: inline
In-Reply-To: <537602FE.4020108@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Pekon Gupta <pekon@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Javier Martinez Canillas <javier@dowhile0.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

* Roger Quadros <rogerq@ti.com> [140516 05:23]:
> On 05/16/2014 02:03 PM, Pekon Gupta wrote:
> > +&gpmc {
> > +	status = "okay";
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&nand_flash_x8>;
> > +	ranges = <0 0 0 0x01000000>;	/* minimum GPMC partition = 16MB */
> > +	nand@0,0 {
> > +		reg = <0 0 0x37c>;	/* device IO registers */
> 
> This register space is used by the parent GPMC node as well as the NAND controller. So doing a request_and_ioremap() on this space will fail as it is already taken by the GPMC driver. 
> 
> Further, the GPMC register space doesn't map to the GPMC memory map created by this Chip select but it is mapped to L3_IO space. i.e. (physical address 0x6e00 0000)
> 
> We could have split the GPMC register space into GPMC part and NAND part but to add to the complexity, the register spaces for GPMC vs NAND are interleaved so it can't be easily split up. The way the NAND driver is currently written is that it expects the register addresses to come via platform data, primarily to get around this address interleaving issue. 
> 
> Apart from the GPMC register space, the NAND controller uses 4 bytes of GPMC memory map for I/O, and that is something that could be reflected here.
> 
> e.g.
> 		reg = <0 0 4>;		/* NAND I/O space */

Guys, the reg size here is size of the IO region for the
NAND driver, it should not have anything to do with the GPMC
registers for the GPMC functions that the NAND driver may call.

So it sounds like 0x37c is wrong, and 4 is the right value if
the NAND chip has only one IO register.
 
> But still, the start address can't be 0 and has to be assigned when this CS region is mapped. It is still unclear to me how that can be done.

If the offset for the NAND driver needs to be different from 0,
it can be in the offset. For example, the smsc,lan91c94 driver
wants the IO address space to be at offset 0x300 to avoid some
extra warnings during the boot. So for that, the reg entry is:

reg = <1 0x300 0xf>;

Where we have:

1 = chip select
0x300 = offset of smsc device register IO space from the start of
        16MB minimum GPMC partition
0xf = size of smsc device register IO space that the Ethernet
      driver ioremaps

Regards,

Tony
