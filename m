From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH] ARM: OMAP1: ams-delta: correct init data section assignments
Date: Fri, 10 Feb 2012 17:31:31 +0100
Message-ID: <1580046.EEGIFOPvyy@vclass>
References: <1328696173-17226-1-git-send-email-grinberg@compulab.co.il> <1328786302-25131-1-git-send-email-jkrzyszt@tis.icnet.pl> <20120209144853.GU1275@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20120209144853.GU1275@n2100.arm.linux.org.uk>
Sender: linux-input-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-fbdev@vger.kernel.org, Artem Bityutskiy <Artem.Bityutskiy@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-mtd@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thursday 09 of February 2012 14:48:53 Russell King - ARM Linux wrote:

> There is no optimisation to adding __refdata to stuff.  That's screaming
> that you have lots of bugs here.

Thanks for your teaching. I find those aspects not very exhaustively documented 
under Documentation/, so any hints are much appreciated.

> > -static struct map_desc ams_delta_io_desc[] __initdata = {
> > +static struct map_desc ams_delta_io_desc[] __initconst = {
> 
> You're not making this comst so don't change it to __initconst.

OK, however, I think there must be a bug in gcc, otherwise it should probably 
never accept such wrong constructs, while sometimes it does (not only mine, 
see [1]).

> > -static struct omap_lcd_config ams_delta_lcd_config = {
> > +static struct omap_lcd_config ams_delta_lcd_config __initconst = {
> 
> This change probably adds a bug.  Are you sure this will never be used
> outside init context?

I may be wrong, but before I've changed this, and now once again, I've verified 
that a copy of this data is made inside __init omap_init_fb() by means of a 
structure assignment operation.

> > -static struct omap_usb_config ams_delta_usb_config __initdata = {
> > +static struct omap_usb_config ams_delta_usb_config __initdata_or_module
> > = {
> Even if you don't have modules enabled, have you checked whether the
> driver can be bound and unbound via
> /sys/bus/platform/driver/<name>/{bind,unbind} ?

No, I didn't even think of it, I am afraid.

> I suspect this is a bug.

Indeed, that data is not copied on init, only pointed to, moreover, the 
ohci-omap driver provides bind/unbind opearations.

BTW, what are those bind/unbind operations intended for in case of a driver 
dedicated to a non-hotplugable SoC hardware exclusively?

> > -static struct resource ams_delta_nand_resources[] = {
> > +static struct resource ams_delta_nand_resources[] __initconst_or_module
> > = {
> This change definitely adds a bug.  The resources are _used_ _all_ _the_
> _time_ _the_ _device_ _is_ _registered_.  Try catting /proc/iomem after
> boot.

Indeed, I didn't think of that. I expected that standard init data of only 
those devices which can be actually found during init should be copied for 
runtime access, then all (found and not found) dropped instead of keeping them 
all in memory for only some of them being actually used.

> > -static struct i2c_board_info ams_delta_camera_board_info[] = {
> > +static struct i2c_board_info __initconst_or_module
> > +ams_delta_camera_board_info[] = {
> 
> No.  It's
> 
> static struct foo blah[] __whatever_init_attribute
> 
> not
> 
> static struct foo __whatever_init_attribute blah[]
> 
> I've no idea where this fucked idea came from but it's something that's
> wasting a lot of review time with complaints like this about it.

My bad, I blindly copied that pattern from another broken example under 
arch/arm instead of examining the docs carefully enough.

> > -static struct soc_camera_link ams_delta_iclink = {
> > +static struct soc_camera_link ams_delta_iclink __initconst_or_module =
> > {
> 
> Probably buggy.

Indeed. Even if the soc-camera-pdrv driver doesn't support 
unbindind/rebinding, it doesn't seem to make a copy of that platform data, 
only stores a pointer to it for runtime access, wich I missed.

> > -static struct platform_device *ams_delta_devices[] __initdata = {
> > +static struct platform_device *ams_delta_devices[] __initconst = {
> 
> Missing const.  If you can't const it, don't put it in __initconst.

I gave up trying to use both const and __initconst together after my gcc-4.2.4 
(and not only mine, see [1], [2]) refused to accept such constructs a few 
times. Now I see that this false reporting may probably happen in presence of other 
incorrect uses of __initconst without const or __initdata with const.

Hopefully better patches will follow.

Thanks,
Janusz

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2011-August/062421.html 
[2] http://permalink.gmane.org/gmane.linux.kernel.commits.head/202285
