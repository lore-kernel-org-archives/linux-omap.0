From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 0/2] twl4030-usb patches
Date: Tue, 2 Sep 2008 21:58:06 +0300
Message-ID: <20080902185804.GD6814@frodo>
References: <1220358712-25737-1-git-send-email-felipe.balbi@nokia.com> <200809020839.28372.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:48992 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751637AbYIBS6g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Sep 2008 14:58:36 -0400
Content-Disposition: inline
In-Reply-To: <200809020839.28372.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

On Tue, Sep 02, 2008 at 08:39:28AM -0700, David Brownell wrote:
> On Tuesday 02 September 2008, Felipe Balbi wrote:
> > 
> > The following patches convert twl4030-usb to a platform_device
> > in order to set the usb mode via platform_data and get
> > rid of the Kconfig entry for that.
> 
> Shouldn't twl4030 first be converted to be a "new style"
> I2C driver?  Then if this approach is to be used, its
> probe() would create those platform devices as children
> of the I2C device node, and with relevant platform_data.

In that case, how would handle the case where more than one twl client
sits in the same i2c address ?

USB is alone on one id, but vibrator, pwm and others (sorry, at home
without docs) shares the same id. How would you pass the proper
platform_data to different drivers ?

I'd say a good approach, would be to let twl4030-core.c handle all the i2c
communication and the other twl modules become a platform_device using
the read/write functions exported from twl4030-core.c

> The platform_data for all those child devices should be
> provided as part of the platform_data for the "main" TWL
> driver, so everything can be properly board-specific.

let me get it straight. You mean something like:

struct twl4030_core_platform_data {
	struct twl4030_usb_platform_data *usb_data;
	struct twl4030_rtc_platform_data *rtc_data;
	[...]
};

Hmm... yeah, maybe that could work. But I'd have to see how you're
thinking of letting twl4030-core.c create all the platform_devices for
all the other modules.

One thing we might say, Jean Delvare won't accept twl4030 the way it is
now. Old style i2c drivers will be dropped soon. We have to get twl4030
properly done otherwise it'll be a pain later.

> Also, since it seems twl4030 docs won't become public
> but docs for its catalog versions[0] will, it'd be good
> to update file headers and Kconfig to mention tps659x0
> parts so that folk without twl4030 NDA's can eventually
> work with this code...

Good idea. I'm sure we should do it at some point. Thanks for the link.

-- 
balbi
