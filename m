From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP display subsystem - does it work?
Date: Fri, 20 Dec 2013 08:04:33 -0800
Message-ID: <20131220160432.GZ27438@atomide.com>
References: <20131218120023.GG4360@n2100.arm.linux.org.uk>
 <52B1A922.6020901@ti.com>
 <20131218180240.GG27438@atomide.com>
 <20131219175644.GE32243@n2100.arm.linux.org.uk>
 <20131219182252.GP27438@atomide.com>
 <20131220112700.GF32243@n2100.arm.linux.org.uk>
 <20131220114837.GH32243@n2100.arm.linux.org.uk>
 <52B44982.4020501@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:28702 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752730Ab3LTQEj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Dec 2013 11:04:39 -0500
Content-Disposition: inline
In-Reply-To: <52B44982.4020501@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [131220 05:45]:
> On 2013-12-20 13:48, Russell King - ARM Linux wrote:
> > On Fri, Dec 20, 2013 at 11:27:01AM +0000, Russell King - ARM Linux wrote:
> >> Maybe, but that's the problem - finding out what is missing.  This is the
> >> endless problem where things keep changing - it's very difficult to keep
> >> a "working configuration" working because the config symbols keep changing.
> >>
> >> Also, bear in mind that there's many different variants of the LDP hardware
> >> with stuff connected up in different ways (I'm aware that the keypad is
> >> just randomly allocated).  I wouldn't be surprised if this also applied
> >> to how the backlight on the LCD was done.
> 
> I need to cook up a patch for the gpio active-low problem. I tried to
> figure out how to do it with the old GPIO API, but as far as I
> understand, I have to do it manually in the driver (as it was done in
> the old driver).
> 
> > Or maybe this is getting buggered by the idiotic deferred probing...  It
> > seems that the GPIOs for controlling the LCD and backlight aren't even
> > getting claimed if the DSS modules are built in:
> > 
> > # cat /sys/kernel/debug/gpio
> > ...
> > GPIOs 238-255, platform/twl4030_gpio, twl4030, can sleep:
> > # echo panel-dpi.0 > /sys/bus/platform/drivers/panel-dpi/unbind
> > # echo panel-dpi.0 > /sys/bus/platform/drivers/panel-dpi/bind
> > # cat /sys/kernel/debug/gpio
> > ...
> > GPIOs 238-255, platform/twl4030_gpio, twl4030, can sleep:
> >  gpio-245 (panel enable        ) out lo
> >  gpio-253 (panel backlight     ) out lo
> 
> This looks odd... Presuming the panel device was probed successfully, it
> should always get the gpios or return an error. Only if gpio_is_valid()
> returns false for the gpio, it skips it and continues. But in this case,
> the gpio number comes from the platform data, so it should always be valid.
> 
> And if it wasn't probed successfully, then there shouldn't be a fb0.

I bet that's it though. If the display is probed before twl4030 GPIO
is initialized, the GPIO numbers will be 0. I'm using omap2plus_defconfig
which has DSS built as modules.

Regards,

Tony
