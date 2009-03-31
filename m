From: Peter Barada <peterb@logicpd.com>
Subject: Re: Problems bringing up new PM 2.6.29 tree on Logic 35x LV SOM
Date: Tue, 31 Mar 2009 17:59:37 -0400
Message-ID: <1238536777.8002.182.camel@blackhole>
References: <1238099752.8002.84.camel@blackhole>
	 <alpine.DEB.2.00.0903261500350.12079@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.logicpd.com ([66.162.60.3]:54485 "EHLO smtp.logicpd.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756257AbZCaV7k (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Mar 2009 17:59:40 -0400
In-Reply-To: <alpine.DEB.2.00.0903261500350.12079@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Thu, 2009-03-26 at 15:13 -0600, Paul Walmsley wrote:
> On Thu, 26 Mar 2009, Peter Barada wrote:
> 
> > I changed the call to omap_init_common_hw to pass in four NULLs (as I
> > think the sdrc params for mt46h32m32lf6 (somehow?) don't match the
> > mt29c2g24maklajg-75 used on our board. 
>                    ^^
> 
> This is why you can't use the MT46H32M32LF-6 parameters.  The -75 part is 
> slower.  You'll need to plug in the -75 timings from the Micron datasheet 
> 1gb_ddr_mobile_sdram_t48m.pdf into calc-sdrc-params.c.  Using those 
> values, create a new file, sdram-micron-mt46h32m32lf-75.h, for that part, 
> and pass in the new SDRAM register structure via omap_init_common_hw() in 
> your board-*.c file.

Ok, I've gone back and started over from scratch with Kevin's PM branch
(2.6.29).  First I ported u-boot 2009.03 from the beagle u-boot git tree
to my board(using beagle code as a starting point), and I have that
working, copmlete with ethernet, NAND, etc. I also took your sdrc timing
generator, and created a mt29c2g24maklajg-75.h for 2.6.29 that contains
the following structure:

static struct omap_sdrc_params mt29c2g24maklajg_75_sdrc_params[] = {
	[0] = {
		.rate	     = 166000000,
		.actim_ctrla = 0x9b6246c7,
		.actim_ctrlb = 0x00011217,
		.rfr_ctrl    = 0x0004dc01,
		.mr	     = 0x00000032,
	},
	[1] = {
		.rate	     = 165941176,
		.actim_ctrla = 0x9b6246c7,
		.actim_ctrlb = 0x00011217,
		.rfr_ctrl    = 0x0004dc01,
		.mr	     = 0x00000032,
	},
	[2] = {
		.rate	     = 133333333,
		.actim_ctrla = 0x7a99b485,
		.actim_ctrlb = 0x00011213,
		.rfr_ctrl    = 0x0003dd01,
		.mr	     = 0x00000032,
	},
	[3] = {
		.rate	     = 83000000,
		.actim_ctrla = 0x51d12484,
		.actim_ctrlb = 0x0001120c,
		.rfr_ctrl    = 0x00025501,
		.mr	     = 0x00000032,
	},
	[4] = {
		.rate	     = 82970588,
		.actim_ctrla = 0x51d12484,
		.actim_ctrlb = 0x0001120c,
		.rfr_ctrl    = 0x00025501,
		.mr	     = 0x00000032,
	},
	[5] = {
		.rate	     = 66666666,
		.actim_ctrla = 0x414d2243,
		.actim_ctrlb = 0x0001120a,
		.rfr_ctrl    = 0x0001d501,
		.mr	     = 0x00000032,
	},
	[6] = {
		.rate	     = 0
	},
};


And using this(and kernel code based on the beagle configuration), I can
boot up 2.6.29 until it wedges trying to program the twl40930 over I2C.
Using the new u-boot, I see from its output:

Clocking rate (Crystal/DPLL/ARM core): 26.0/332/1000 MHz

Which doesn't look right at all.  Before I go too far, I found in u-boot
that the I2C code in the tree made the assumption that the I2C clock was
based on 12Mhz, and blindly calculated the PSC and SCL values directly
from that instead of looking at I2C_IP_CLK (96Mhz).  I wonder if this is
what's (partially) biting me on the 2.6.29 startup.

Before I dig too deep,

1) Does u-boot, if loaded into ram and started up, setup the clocks from
scratch?  I'm asking since Logic has a primarly bootloader, LoLo, that
sets up the world, then I load/invoke u-boot, which then loads/boots the
kernel.  I can envision the clock setup in LoLo being incorrect, iff
u-boot does not program clocks that are already setup(i.e. if u-boot
reprograms all the clocks, then it shouldn't matter if LoLo set them up
incorrectly).

2) Any ideas why the kernel would think the core is running at 1000Mhz?
Dumping DPLL3


> 
> - Paul
-- 
Peter Barada <peterb@logicpd.com>
