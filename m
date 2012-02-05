From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP34xx
Date: Sun, 5 Feb 2012 18:05:21 +0000
Message-ID: <20120205180521.GG17309@n2100.arm.linux.org.uk>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk> <20120204190109.GL20333@atomide.com> <20120204203453.GD17309@n2100.arm.linux.org.uk> <20120205125626.GA11372@n2100.arm.linux.org.uk> <20120205143824.GA12577@n2100.arm.linux.org.uk> <20120205174036.GT20333@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:38098 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752228Ab2BESFd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 5 Feb 2012 13:05:33 -0500
Content-Disposition: inline
In-Reply-To: <20120205174036.GT20333@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

On Sun, Feb 05, 2012 at 09:40:37AM -0800, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [120205 06:07]:
> > On Sun, Feb 05, 2012 at 12:56:26PM +0000, Russell King - ARM Linux wrote:
> > > And here's another (set of) problem(s) on the 4430SDP board once the
> > > previous have been worked around:
> > > 
> > > omap_hwmod: l3_div_ck: missing clockdomain for l3_div_ck.
> > > omap_hwmod: ipu: failed to hardreset
> > > omap_hwmod: mcpdm: cannot be enabled (3)
> > > ...
> > > machine_constraints_voltage: VUSB: failed to apply 3300000uV constraint
> > > ...
> > > twl_reg twl_reg.46: can't register VUSB, -22
> > > twl_reg: probe of twl_reg.46 failed with error -22
> > > ...
> > > omap_vc_i2c_init: I2C config for all channels must match.
> > > omap_vc_i2c_init: I2C config for all channels must match.
> > 
> > Fixing this error message to provide something useful allows this problem
> > to be diagnosed.
> > 
> > omap_vc_i2c_init: I2C config for vdd_iva does not match other channels (0).
> > omap_vc_i2c_init: I2C config for vdd_mpu does not match other channels (0).
> > 
> > Let's look at the PMIC data for OMAP4:
> > 
> > static struct omap_voltdm_pmic omap3_mpu_pmic = {
> >         .i2c_high_speed            = true,
> > static struct omap_voltdm_pmic omap3_core_pmic = {
> >         .i2c_high_speed            = true,
> > static struct omap_voltdm_pmic omap4_mpu_pmic = {
> >         .i2c_high_speed            = true,
> > static struct omap_voltdm_pmic omap4_iva_pmic = {
> >         .i2c_high_speed            = true,
> > static struct omap_voltdm_pmic omap4_core_pmic = {
> > 
> > So, OMAP4's PMIC information for the core domain does not have I2C high
> > speed set, yet the others do.  So if this is an illegal configuration
> > then the TWL data is plainly wrong.  If it's a legal configuration, the
> > voltage domain code is talking utter crap about requiring all these to
> > match.  They can't both be right.
> 
> Indeed.
>  
> > Has this code been tested on OMAP4 platforms?  I think not (or if it
> > was, it was done blindly without regard for the messages the kernel
> > was spitting out - again, that's a failing of people to properly test
> > their code _before_ sending it upstream.)
> 
> Let's let Kevin investigate this one.
>  
> > > Power Management for TI OMAP4.
> > > clock: disabling unused clocks to save power
> > > omapfb omapfb: no driver for display: lcd
> > > omapfb omapfb: no driver for display: lcd2
> > 
> > Okay, so this requires backlight support, and TAAL selected, so that sorts
> > that error, but causes others:
> > 
> > taal display0: taal panel revision e3.83.7d
> > omapdss DSI error: DSI CIO error, cio irqstatus 200000
> > DSI CIO IRQ 0x200000: ERRCONTENTIONLP1_1
> > omapdss DSI error: DSI CIO error, cio irqstatus 200000
> > DSI CIO IRQ 0x200000: ERRCONTENTIONLP1_1
> > omapdss DSI error: DSI CIO error, cio irqstatus 200000
> > DSI CIO IRQ 0x200000: ERRCONTENTIONLP1_1
> > omapdss DSI error: DSI CIO error, cio irqstatus 200000
> > DSI CIO IRQ 0x200000: ERRCONTENTIONLP1_1
> > omapdss DSI error: DSI CIO error, cio irqstatus 200000
> > DSI CIO IRQ 0x200000: ERRCONTENTIONLP1_1
> > omapdss DSI error: DSI CIO error, cio irqstatus 200000
> > DSI CIO IRQ 0x200000: ERRCONTENTIONLP1_1
> > 
> > > Failed to set PHY power mode to 1
> > > omapdss HDMI error: failed to power on device
> > 
> > For some reason, enabling TAAL fixes this HDMI error.  Why I don't
> > understand but it's very very counter intuitive.
> 
> Let's let Tomi investigate this one.
>  
> > > ------------[ cut here ]------------
> > > WARNING: at /home/rmk/git/linux-omap/arch/arm/mach-omap2/omap_hwmod.c:1604 _idle+0x34/0xc8()
> > > omap_hwmod: dss_hdmi: idle state can only be entered from enabled state
> > 
> > This message doesn't exist in the kernel source as far as I can find.
> > Ah, yes it does, someone well wrapped the message.
> > 
> >                 WARN(1, "omap_hwmod: %s: idle state can only be entered from "
> >                      "enabled state\n", oh->name);
> > 
> > So that goes into my patch of omap fixes.  There's others in that file
> > which will get the same treatment.
> 
> This is not a fix, this should queued for the next merge window
> as clean-up.

I would much rather have your agreement, but at the moment given the
(yet again) poor state of OMAP, I'm not inclined to allow this to be
pushed into the next merge window.

And if that means I have to apply it to my tree in the fixes branch,
that's what I'll do.

The fact is that because of the wrapping, the message is difficult to
find, and that's good enough justification for me to put it in my fixes
branch.

In fact, I'll even send it as a plain patch to Linus so he can see it
for what it is and decide whether _he_ wants to apply it, and I believe
he will apply it without any questions.
