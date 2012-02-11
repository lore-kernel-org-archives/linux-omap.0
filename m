From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: OMAP1: ams-delta: correct init data section
	assignments
Date: Sat, 11 Feb 2012 10:24:24 +0000
Message-ID: <20120211102424.GC13587@n2100.arm.linux.org.uk>
References: <1328696173-17226-1-git-send-email-grinberg@compulab.co.il> <1328786302-25131-1-git-send-email-jkrzyszt@tis.icnet.pl> <20120209144853.GU1275@n2100.arm.linux.org.uk> <1580046.EEGIFOPvyy@vclass>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1580046.EEGIFOPvyy@vclass>
Sender: linux-input-owner@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Tony Lindgren <tony@atomide.com>, linux-fbdev@vger.kernel.org, Artem Bityutskiy <Artem.Bityutskiy@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-mtd@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, Feb 10, 2012 at 05:31:31PM +0100, Janusz Krzysztofik wrote:
> On Thursday 09 of February 2012 14:48:53 Russell King - ARM Linux wrote:
> > > -static struct map_desc ams_delta_io_desc[] __initdata = {
> > > +static struct map_desc ams_delta_io_desc[] __initconst = {
> > 
> > You're not making this comst so don't change it to __initconst.
> 
> OK, however, I think there must be a bug in gcc, otherwise it should probably 
> never accept such wrong constructs, while sometimes it does (not only mine, 
> see [1]).

No - because you don't understand what's going on with these tags.
The __initconst and other tags are just tell the compiler to place
stuff into a named section.  The name is interpreted by GCC as a mere
string which it passes through to the ELF file.

So, gcc has no idea that a section named '.init.rodata' could be placed
in read-only memory, and therefore has no idea that it should also be
marked 'const'.

Therefore, gcc has no way to verify that 'const' and '__initconst' are
always paired.

> > > -static struct omap_lcd_config ams_delta_lcd_config = {
> > > +static struct omap_lcd_config ams_delta_lcd_config __initconst = {
> > 
> > This change probably adds a bug.  Are you sure this will never be used
> > outside init context?
> 
> I may be wrong, but before I've changed this, and now once again, I've verified 
> that a copy of this data is made inside __init omap_init_fb() by means of a 
> structure assignment operation.

Ok, in that case add a 'const' to it.

> > > -static struct omap_usb_config ams_delta_usb_config __initdata = {
> > > +static struct omap_usb_config ams_delta_usb_config __initdata_or_module
> > > = {
> > Even if you don't have modules enabled, have you checked whether the
> > driver can be bound and unbound via
> > /sys/bus/platform/driver/<name>/{bind,unbind} ?
> 
> No, I didn't even think of it, I am afraid.
> 
> > I suspect this is a bug.
> 
> Indeed, that data is not copied on init, only pointed to, moreover, the 
> ohci-omap driver provides bind/unbind opearations.
> 
> BTW, what are those bind/unbind operations intended for in case of a
> driver dedicated to a non-hotplugable SoC hardware exclusively?

If the driver can be built as a module, they allow exercising the
probe/remove paths for drivers which have been built-in.  Moreover,
it allows you to disable a device driver if desired.

For example, I have two platforms which are essentially the same, except
one has a daughterboard attached (which isn't hotpluggable).  The support
for the daughterboard, although it is a platform driver, can't be
modularised at the moment because quite a bit of other stuff needs it
and it contains IRQ chip code.

One has far less idle wakeups than the other.  Using unbind, I can
effectively detach this board by unbinding its platform device, which
results the entire sub-tree of its on-board devices being unregistered
and released in one big go, all the way down to things like USB devices
on the USB host.  I can then rebind it and bring all that hardware back.

That allows me to evaluate whether there's any impact from those drivers.

However, this bind/unbind is not the only issue here: how do you know
whether the driver takes a copy of the platform data, or merely stores a
pointer to it - and may access your platform data at runtime.

Unless you check, and recheck it regularly (it can change) then placing
this stuff into sections which will be discarded is asking for bugs.

> > > -static struct platform_device *ams_delta_devices[] __initdata = {
> > > +static struct platform_device *ams_delta_devices[] __initconst = {
> > 
> > Missing const.  If you can't const it, don't put it in __initconst.
> 
> I gave up trying to use both const and __initconst together after my gcc-4.2.4 
> (and not only mine, see [1], [2]) refused to accept such constructs a few 
> times. Now I see that this false reporting may probably happen in presence of other 
> incorrect uses of __initconst without const or __initdata with const.

I doubt that the compiler was refusing to accept them.  What you were
probably getting were warnings about where these were used not accepting
a const pointer.

If that's the case, more analysis needs to be done to find out whether
those uses can be converted to accept a const pointer before defining
the data with const and optionally __initconst.
