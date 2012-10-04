From: Tony Lindgren <tony@atomide.com>
Subject: Re: Converting vrfb.c
Date: Thu, 4 Oct 2012 09:33:25 -0700
Message-ID: <20121004163324.GB3874@atomide.com>
References: <1348833847.2437.36.camel@deskari>
 <20120928150052.GA4840@atomide.com>
 <20121003184149.GG4840@atomide.com>
 <1349345938.32558.0.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:19697 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1946047Ab2JDQd1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Oct 2012 12:33:27 -0400
Content-Disposition: inline
In-Reply-To: <1349345938.32558.0.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [121004 03:20]:
> On Wed, 2012-10-03 at 11:41 -0700, Tony Lindgren wrote:
> > Hi,
> > 
> > * Tony Lindgren <tony@atomide.com> [120928 08:02]:
> > > * Tomi Valkeinen <tomi.valkeinen@ti.com> [120928 05:05]:
> > > > Hi,
> > > > 
> > > > I'm a bit at loss how to deal with drivers/video/omap2/vrfb.c.
> > > > 
> > > > VRFB is part of the SDRAM controller on OMAP2 and OMAP3. vrfb.c uses the
> > > > following functions from sdrc.h:
> > > > 
> > > > omap2_sms_write_rot_control();
> > > > omap2_sms_write_rot_size();
> > > > omap2_sms_write_rot_physical_ba();
> > > > 
> > > > There are no other dependencies to the sdrc.c.
> > > > 
> > > > Those functions are quite simple:
> > > > 
> > > > void omap2_sms_write_rot_control(u32 val, unsigned ctx)
> > > > {
> > > > 	sms_write_reg(val, SMS_ROT_CONTROL(ctx));
> > > > }
> > > > 
> > > > void omap2_sms_write_rot_size(u32 val, unsigned ctx)
> > > > {
> > > > 	sms_write_reg(val, SMS_ROT_SIZE(ctx));
> > > > }
> > > > 
> > > > void omap2_sms_write_rot_physical_ba(u32 val, unsigned ctx)
> > > > {
> > > > 	sms_write_reg(val, SMS_ROT_PHYSICAL_BA(ctx));
> > > > }
> > > > 
> > > > vrfb.c is in turn used by omapfb and omap v4l2 driver.
> > > > 
> > > > 
> > > > So... Should I just remove the sdrc.h dependency and make vrfb.c ioremap
> > > > those SMS registers itself? Those three registers are VRFB specific, so
> > > > they are not used by anyone else. In that case I'd need to pass the SMS
> > > > base address to vrfb.c somehow.
> > > > 
> > > > Or should I have some kind of platform data passed to vrfb.c, which
> > > > contains func pointers to the above three functions?
> > > > 
> > > > Or should vrfb.c be moved into mach-omap2/? But then how would omapfb
> > > > call it? Passing vrfb functions as pointers in omapfb platform data?
> > > 
> > > Maybe just export those functions in sdrc.c for now? Eventually
> > > that should be just a regular device driver too..
> > 
> > Actually, if you're only using it to save and restore the hw
> > context, why don't you let mach-omap2/sdrc.c do it based on runtime
> > PM calls? It already has omap2_sms_save/restore_context.
> 
> No, the functions are used to configure the rotation parameters whenever
> the user asks for a new rotation.

OK. If vrfb.c is the only user of these registers, I suggest you
request_mem_region + ioremap the SMS registers directly in vrfb.c.
You can pass the extra io area passed in platform data or from
device tree. And the extra io area is not passed, do nothing.

The reason why I think it's better to ioremap independent register
ranges diretly in the driver is that we can avoid exporting omap
specific functions like sms_read/write.

Of course we probably also need also a core SDRC driver eventually
for clocking and saving and restoring the state etc.

Regards,

Tony
