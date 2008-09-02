From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 0/2] twl4030-usb patches
Date: Tue, 2 Sep 2008 22:49:34 +0300
Message-ID: <20080902194917.GF6814@frodo>
References: <1220358712-25737-1-git-send-email-felipe.balbi@nokia.com> <200809020839.28372.david-b@pacbell.net> <20080902185804.GD6814@frodo> <200809021237.56825.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:57879 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752556AbYIBTuH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Sep 2008 15:50:07 -0400
Content-Disposition: inline
In-Reply-To: <200809021237.56825.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: me@felipebalbi.com, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

On Tue, Sep 02, 2008 at 12:37:56PM -0700, David Brownell wrote:
> Same way it does now ...
> 
> What's BROKEN with the current scheme is that the driver
> model tree looks something like
> 
> 	/sys/devices/platform/omap_i2c.X/X-00{N0,N1,N2,N3}
> 	/sys/devices/platform/{twl-gpio,twl-rtc,twl-foo,...}
> 
> That is, these devices are in the wrong place.  Now, I don't
> really care much if they're all parented by the N0 node;
> that's basically just a strange artifact of that chip.  All
> that I suggested was making sure those platform devices
> are properly parented:  by N0/N1/whatever.

Agreed... it sure looks odd.

> Pass it through twl4030 platform data.  It's all board-specific,
> and if you don't pass platform data for e.g. vibrator or LEDs
> then you'd know this board doesn't have that hardware ... so
> don't create those platform devices (even if the driver does
> happen to be configured into this multi-board kernel).

got it.

> static int twl4030_probe(struct i2c_client *c, const struct i2c_device_id *id)
> {
> 	struct twl4030_core_platform_data *pdata = c->platform_data;
> 	struct platform_device *pdev;
> 	int status;
> 
> 	...
> 	if (have_twl_rtc_driver() && pdata->rtc_data) {
> 		pdev = platform_device_alloc("twl4030_rtc", -1);
> 		... nullcheck ...
> 		status = platform_add_data(pdev, pdata->rtc_data,
> 				sizeof(*pdata->rtc_data));
> 		... status check ...
> 		status = platform_device_add_resources(pdev, ... the irq ... );
> 		... status_check ...
> 		pdev->dev.parent = &c->dev;
> 		status = platform_device_add(pdev);
> 		... status check ...
> 	}
> 	... etc
> }
> 
> Or I suppose you could statically allocate the device data; not
> particularly encouraged where pdev->dev.parent is non-null though.

hmm... that looks good. Gotta dig more into the platform_driver stuff.
Thanks for the point.

> > One thing we might say, Jean Delvare won't accept twl4030 the way it is
> > now. Old style i2c drivers will be dropped soon. We have to get twl4030
> > properly done otherwise it'll be a pain later.
> 
> He's also not keen on growing drivers/i2c/chips ...
> So this driver should probably move to drivers/mfd too.

Sure... it should really be there since it really is a multifunction
device. In that case it would be merged through Samuel Ortiz, right ?
Most likely Cc:ing i2c@lm-sensors.org so i2c people could comment on the
code as well.

> (When it starts moving upstream, I suspect some folk will
> ask why it doesn't support the drivers/regulator calls;
> that's still new, I'd not worry much.)

Well, but if we have proper APIs for doing stuff, we should really start
using them, don't you think ?

I'll postpone my twl4030-usb patch and try to work on twl4030-core.c.
It'll be a huge task moving all of that to new style i2c driver.

-- 
balbi
