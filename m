From: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Subject: Re: [PATCH 0/6] i2c: deferred STP
Date: Wed, 23 Jan 2013 22:05:41 +0200
Message-ID: <20130123200540.GE23057@blackmetal.musicnaut.iki.fi>
References: <20130123095813.GG3767@nekote.pengutronix.de>
 <1358936588-16375-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1358936588-16375-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Wed, Jan 23, 2013 at 12:23:02PM +0200, Felipe Balbi wrote:
> Hi folks,
> 
> it's now rebased on today's i2c-embedded/for-next. I boot tested with my
> Blaze board.
> 
> Aaro, if you could verify it doesn't break N900, I'd be glad.

It works, but it still introduces a ~4 second delay during the boot:

[    0.180847] usbcore: registered new device driver usb
[    0.181518] musb-omap2430 musb-omap2430: invalid resource
[    4.289093] twl 1-0048: PIH (irq 23) chaining IRQs 338..346
[    4.289276] twl 1-0048: power (irq 343) chaining IRQs 346..353
[    4.321228] twl4030_gpio twl4030_gpio: gpio (irq 338) chaining IRQs 354..371
[    4.446655] VUSB1V5: 1500 mV normal standby

Without these patches, it's:

[    0.186798] usbcore: registered new device driver usb
[    0.187438] musb-omap2430 musb-omap2430: invalid resource
[    0.213897] twl 1-0048: PIH (irq 23) chaining IRQs 338..346
[    0.214080] twl 1-0048: power (irq 343) chaining IRQs 346..353
[    0.215301] twl4030_gpio twl4030_gpio: gpio (irq 338) chaining IRQs 354..371
[    0.217926] VUSB1V5: 1500 mV normal standby

I'll try to find out what change is causing this.

A.
