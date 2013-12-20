From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP display subsystem - does it work?
Date: Fri, 20 Dec 2013 11:48:37 +0000
Message-ID: <20131220114837.GH32243@n2100.arm.linux.org.uk>
References: <20131218120023.GG4360@n2100.arm.linux.org.uk> <52B1A922.6020901@ti.com> <20131218180240.GG27438@atomide.com> <20131219175644.GE32243@n2100.arm.linux.org.uk> <20131219182252.GP27438@atomide.com> <20131220112700.GF32243@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:55432 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755863Ab3LTLsp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Dec 2013 06:48:45 -0500
Content-Disposition: inline
In-Reply-To: <20131220112700.GF32243@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-arm-kernel@lists.infradead.org

On Fri, Dec 20, 2013 at 11:27:01AM +0000, Russell King - ARM Linux wrote:
> Maybe, but that's the problem - finding out what is missing.  This is the
> endless problem where things keep changing - it's very difficult to keep
> a "working configuration" working because the config symbols keep changing.
> 
> Also, bear in mind that there's many different variants of the LDP hardware
> with stuff connected up in different ways (I'm aware that the keypad is
> just randomly allocated).  I wouldn't be surprised if this also applied
> to how the backlight on the LCD was done.

Or maybe this is getting buggered by the idiotic deferred probing...  It
seems that the GPIOs for controlling the LCD and backlight aren't even
getting claimed if the DSS modules are built in:

# cat /sys/kernel/debug/gpio
...
GPIOs 238-255, platform/twl4030_gpio, twl4030, can sleep:
# echo panel-dpi.0 > /sys/bus/platform/drivers/panel-dpi/unbind
# echo panel-dpi.0 > /sys/bus/platform/drivers/panel-dpi/bind
# cat /sys/kernel/debug/gpio
...
GPIOs 238-255, platform/twl4030_gpio, twl4030, can sleep:
 gpio-245 (panel enable        ) out lo
 gpio-253 (panel backlight     ) out lo

Tony, try this with the stuff not as modules but built-in.
