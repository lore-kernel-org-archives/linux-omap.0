From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/5] omap: mux: Add new style pin multiplexing data for
 34xx
Date: Tue, 10 Nov 2009 14:37:08 -0800
Message-ID: <20091110223708.GE23952@atomide.com>
References: <20091029203124.11843.89983.stgit@localhost>
 <20091029203631.11843.1364.stgit@localhost>
 <4AED6330.8020007@compulab.co.il>
 <20091102191018.GD6692@atomide.com>
 <f870da180911022310n65b63bffw9a425e4aeaa9187b@mail.gmail.com>
 <20091103164324.GE8981@atomide.com>
 <4AF129CE.9080508@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57110 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758406AbZKJWhK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Nov 2009 17:37:10 -0500
Content-Disposition: inline
In-Reply-To: <4AF129CE.9080508@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: Mike Rapoport <mike.rapoport@gmail.com>, linux-omap@vger.kernel.org

Hi,

Sorry for the delay, have not had a chance to work on this for a few
days.

* Mike Rapoport <mike@compulab.co.il> [091103 23:14]:
> 
> 
> Tony Lindgren wrote:
> > * Mike Rapoport <mike.rapoport@gmail.com> [091102 23:10]:
> >> On Mon, Nov 2, 2009 at 9:10 PM, Tony Lindgren <tony@atomide.com> wrote:
> >>> * Mike Rapoport <mike@compulab.co.il> [091101 02:30]:
> >>>>
> >>>> Tony Lindgren wrote:

<snip snip>
 
> > We can easily do something like this if we add char *muxname to
> > struct omap_board_mux (untested):
> > 
> > #define OMAP_MUX_SIGNAL(signal, mux_flags)				\
> > {									\
> > 	.muxname	= #signal,					\
> > 	.flags		= (mux_flags),					\
> > }
> > 
> > #define OMAP_MUX_GPIO(gpio, mux_flags)					\
> > {									\
> > 	.muxname	= gpio_##signal,				\
> > 	.flags		= (mux_flags),					\
> > }
> > 
> > #ifdef CONFIG_OMAP_MUX
> > static struct omap_board_mux board_mux[] __initdata = {
> > 	OMAP_MUX_SIGNAL(i2c1_scl, OMAP_PIN_INPUT),
> > 	OMAP_MUX_GPIO(98, OMAP_PIN_INPUT_PULLUP),
> > 	OMAP_MUX_GPIO(99, OMAP_PIN_INPUT_PULLUP | OMAP_MUX_DYNAMIC),
> > 	{ .reg_offset = OMAP_MUX_TERMINATOR },
> > };
> > #endif
> > 
> > Of course then we have to warn on potential duplicate signal names,
> > but those can be specified using the register offset + mode as
> > needed.

Or use mode0_name.modeX_name for the full naming.

> > Is the above close enough to what you have in mind regarding the
> > board specific mux tables, or do you have still something else
> > in mind?
> 
> It's closer :)

OK, hopefully that means close to usable then :)

> What I have in mind is a simple wrapper macro defining mux configuration for
> straightforward cases, just like a bunch of defines in
> arch/arm/mach-omap2/include/mach/mux34xx.h in my earlier patch [1].
> And just use OMAP_MUX_SIGNAL, or OMAP3_MUX for more complicated cases where
> flags and/or OFF mode settings are required.
> For instance, for making i2c1_scl to be actually routed to its pin you would have
> 
> static struct omap_board_mux board_mux[] __initdata = {
>  	OMAP_MUX_I2C1_SCL,
>         ...
> }
> 
> and for dss_pclk to became hw_dbg12 you have
> 
> static struct omap_board_mux board_mux[] __initdata = {
> 	OMAP_MUX_PCLK_HW_DBG12,
>         ...
> }

The more I've been thinking about it, I think we should move away from using
the register offsets if we can use the signal names instead. A lot of the board
init code can be done in a generic way then, and should work across various
omaps better.

For example, see what setup_ehci_io_mux() becomes then:

	switch (port_mode[0]) {
	case EHCI_HCD_OMAP_MODE_PHY:
		omap_mux_init_signal("hsusb1_stp", OMAP_PIN_OUTPUT);
		omap_mux_init_signal("hsusb1_clk", OMAP_PIN_OUTPUT);
		omap_mux_init_signal("hsusb1_dir", OMAP_PIN_INPUT_PULLDOWN);
		omap_mux_init_signal("hsusb1_nxt", OMAP_PIN_INPUT_PULLDOWN);
		omap_mux_init_signal("hsusb1_data0", OMAP_PIN_INPUT_PULLDOWN);
		omap_mux_init_signal("hsusb1_data1", OMAP_PIN_INPUT_PULLDOWN);
		omap_mux_init_signal("hsusb1_data2", OMAP_PIN_INPUT_PULLDOWN);
		omap_mux_init_signal("hsusb1_data3", OMAP_PIN_INPUT_PULLDOWN);
		omap_mux_init_signal("hsusb1_data4", OMAP_PIN_INPUT_PULLDOWN);
		omap_mux_init_signal("hsusb1_data5", OMAP_PIN_INPUT_PULLDOWN);
		omap_mux_init_signal("hsusb1_data6", OMAP_PIN_INPUT_PULLDOWN);
		omap_mux_init_signal("hsusb1_data7", OMAP_PIN_INPUT_PULLDOWN);
		break;
		...

Of course, that does not mean that we should not allow muxing by using the
register offsets especially for board specific custom devices. But it helps
with the common platform init code for the integrated devices.
 
> Another my point was, that each board-* file will have all the mux settings in
> one consolidated place. Indeed, currently there are no many uses of omap_cfg_reg
> in the board files, but think of crappy bootloaders that fail to configure half
> of the pins or cases when you delibarately want to setup mux configuration in
> kernel.

Agreed. We should do it in the board-*.c files because bootloaders do what they
do. And for common integrated devices we can do it in the common platform init
code based on the nr_lines like we do for MMC and USB already.
 
> I agree, that having the macros I'm talking about is more or less "syntactic
> sugar" and I'm Ok to live without them :)

OK, let's see how it works once I get back to working on it..

> The most important that we don't need to add enumerated mux setting to
> arch/arm/*omap*/mux.[ch] for each pin that was not there and mux setup can
> completely defined by the board-* files.

:)

Except we still have it for mach-omap1. The mux registers are scattered in
multiple registers, so let's not mess with that right now.

Regards,

Tony

> 
> 
> [1] http://thread.gmane.org/gmane.linux.ports.arm.omap/25681
