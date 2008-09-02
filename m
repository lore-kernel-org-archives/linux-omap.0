From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 0/2] twl4030-usb patches
Date: Tue, 2 Sep 2008 12:37:56 -0700
Message-ID: <200809021237.56825.david-b@pacbell.net>
References: <1220358712-25737-1-git-send-email-felipe.balbi@nokia.com> <200809020839.28372.david-b@pacbell.net> <20080902185804.GD6814@frodo>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp118.sbc.mail.sp1.yahoo.com ([69.147.64.91]:35913 "HELO
	smtp118.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751390AbYIBTh7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Sep 2008 15:37:59 -0400
In-Reply-To: <20080902185804.GD6814@frodo>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

On Tuesday 02 September 2008, Felipe Balbi wrote:
> On Tue, Sep 02, 2008 at 08:39:28AM -0700, David Brownell wrote:
> > On Tuesday 02 September 2008, Felipe Balbi wrote:
> > > 
> > > The following patches convert twl4030-usb to a platform_device
> > > in order to set the usb mode via platform_data and get
> > > rid of the Kconfig entry for that.
> > 
> > Shouldn't twl4030 first be converted to be a "new style"
> > I2C driver?  Then if this approach is to be used, its
> > probe() would create those platform devices as children
> > of the I2C device node, and with relevant platform_data.
> 
> In that case, how would handle the case where more than one twl client
> sits in the same i2c address ?

Same way it does now ...

What's BROKEN with the current scheme is that the driver
model tree looks something like

	/sys/devices/platform/omap_i2c.X/X-00{N0,N1,N2,N3}
	/sys/devices/platform/{twl-gpio,twl-rtc,twl-foo,...}

That is, these devices are in the wrong place.  Now, I don't
really care much if they're all parented by the N0 node;
that's basically just a strange artifact of that chip.  All
that I suggested was making sure those platform devices
are properly parented:  by N0/N1/whatever.


> USB is alone on one id, but vibrator, pwm and others (sorry, at home
> without docs) shares the same id. How would you pass the proper
> platform_data to different drivers ?

Pass it through twl4030 platform data.  It's all board-specific,
and if you don't pass platform data for e.g. vibrator or LEDs
then you'd know this board doesn't have that hardware ... so
don't create those platform devices (even if the driver does
happen to be configured into this multi-board kernel).


> I'd say a good approach, would be to let twl4030-core.c handle all the i2c
> communication and the other twl modules become a platform_device using
> the read/write functions exported from twl4030-core.c

How is that different from what I said?

I was only highlighting particular brokenness of how this
driver currently initializes, with a straightforward fix
that's fully attuned to what's done upstream.

 
> > The platform_data for all those child devices should be
> > provided as part of the platform_data for the "main" TWL
> > driver, so everything can be properly board-specific.
> 
> let me get it straight. You mean something like:
> 
> struct twl4030_core_platform_data {
> 	struct twl4030_usb_platform_data *usb_data;
> 	struct twl4030_rtc_platform_data *rtc_data;

... gpio_platform_data, LED config, etc ...

> 	[...]
> };

Basically.  It may be that some of that stuff doesn't need
to be board-specific though.  At any rate there should be
a pointer to a "struct twl4030_core_platform_data" holding
board-specific stuff in the "struct i2c_board_info" that
each board provides when it does I2C initialization.


> Hmm... yeah, maybe that could work. But I'd have to see how you're
> thinking of letting twl4030-core.c create all the platform_devices for
> all the other modules.

static int twl4030_probe(struct i2c_client *c, const struct i2c_device_id *id)
{
	struct twl4030_core_platform_data *pdata = c->platform_data;
	struct platform_device *pdev;
	int status;

	...
	if (have_twl_rtc_driver() && pdata->rtc_data) {
		pdev = platform_device_alloc("twl4030_rtc", -1);
		... nullcheck ...
		status = platform_add_data(pdev, pdata->rtc_data,
				sizeof(*pdata->rtc_data));
		... status check ...
		status = platform_device_add_resources(pdev, ... the irq ... );
		... status_check ...
		pdev->dev.parent = &c->dev;
		status = platform_device_add(pdev);
		... status check ...
	}
	... etc
}

Or I suppose you could statically allocate the device data; not
particularly encouraged where pdev->dev.parent is non-null though.

 
> One thing we might say, Jean Delvare won't accept twl4030 the way it is
> now. Old style i2c drivers will be dropped soon. We have to get twl4030
> properly done otherwise it'll be a pain later.

He's also not keen on growing drivers/i2c/chips ...
So this driver should probably move to drivers/mfd too.

(When it starts moving upstream, I suspect some folk will
ask why it doesn't support the drivers/regulator calls;
that's still new, I'd not worry much.)

- Dave

 
> > Also, since it seems twl4030 docs won't become public
> > but docs for its catalog versions[0] will, it'd be good
> > to update file headers and Kconfig to mention tps659x0
> > parts so that folk without twl4030 NDA's can eventually
> > work with this code...
> 
> Good idea. I'm sure we should do it at some point. Thanks for the link.
> 
> -- 
> balbi
> 


