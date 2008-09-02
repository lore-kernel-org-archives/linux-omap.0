From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 0/2] twl4030-usb patches
Date: Tue, 2 Sep 2008 12:52:18 -0700
Message-ID: <200809021252.18537.david-b@pacbell.net>
References: <1220358712-25737-1-git-send-email-felipe.balbi@nokia.com> <200809020843.56874.david-b@pacbell.net> <20080902184830.GC6814@frodo>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:29967 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755011AbYIBTwV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Sep 2008 15:52:21 -0400
In-Reply-To: <20080902184830.GC6814@frodo>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: felipe.balbi@nokia.com, linux-omap@vger.kernel.org

On Tuesday 02 September 2008, Felipe Balbi wrote:
> On Tue, Sep 02, 2008 at 08:43:56AM -0700, David Brownell wrote:
> > Snapshot of what's in my tree ... 
> 
> Great, a few comments below.
> 
> > # should have the base GPIO set up better; minimally
> > # in a system header, ideally platform data ...
> 
> Could you describe this a bit more ? What do you mean by "base GPIO" ?
> If you mean the first gpio number for passing to struct gpio_chip we
> could use a platform_data if we make this one also a platform_driver,
> right ?

Right.  See for example <linux/i2c/pca953x.h> which holds just
such data.  Note the setup()/teardown() stuff, which various OMAP
boards would be using to pass GPIO numbers to the HSMMC code ...
ensuring that the HSMMC driver isn't set up before its card detect
and writeprotect logic can work.

(Once the HSMMC board-specific init starts to look sane that is...)


 
> > # the whole twl driver should be "new style".
> 
> maybe only twl4030-core.c should hold the whole i2c new style thingy,
> all the other drivers (usb, vibrators, keypad, rtc, etc) should/could
> be a platform_driver.

That's "whole"!  :)

Thing is, this is a Multi-Function Device (MFD) and whoever did
this code decided to factor it as drivers around a core.  I'm
not proposing that be changed ... just that the parts should be
glued together properly.  Where "properly" includes not just
getting the driver model tree correct, but also passing in the
board-specific data from the board-*.c files instead of hard
wiring everything to mach the first available hardware.  (Today,
it's all hard-wired.)

 
> >  static struct irq_chip twl4030_gpio_irq_chip = {
> > -	.name	= "twl4030-gpio",
> > +	.name	= "twl4030",
> 
> twl4030-core.c already uses this name. Wouldn't it be odd when cat
> /proc/interrupts ? I'd like to see which are gpio interrupts and which
> aren't

They're all from the TWL4030 though.  :)

/proc/interrupts is misformatted with the long name though...

 
> >  	down(&gpio_sem);
> >  	if (gpio_usage_count & (0x1 << gpio))
> >  		ret = -EBUSY;
> 
> how about also putting the brackets for the if(), maybe in a cleanup
> patch before this one ?
> 
> >  	if ((gpio_usage_count & (0x1 << gpio)) == 0)
> >  		ret = -EPERM;
> 
> missing brackets.

Fixed. 
