From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 11/9] move twl4030-gpio to drivers/gpio
Date: Sat, 27 Sep 2008 22:16:14 -0700
Message-ID: <200809272216.14672.david-b@pacbell.net>
References: <1222427996-7018-1-git-send-email-felipe.balbi@nokia.com> <200809271645.20782.david-b@pacbell.net> <20080928031411.GF8468@frodo>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp126.sbc.mail.sp1.yahoo.com ([69.147.65.185]:40629 "HELO
	smtp126.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750818AbYI1FQQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 28 Sep 2008 01:16:16 -0400
In-Reply-To: <20080928031411.GF8468@frodo>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Jean Delvare <khali@linux-fr.org>

On Saturday 27 September 2008, Felipe Balbi wrote:
> On Sat, Sep 27, 2008 at 04:45:20PM -0700, David Brownell wrote:
> > On Saturday 27 September 2008, Felipe Balbi wrote:
> > > We need something like the patch below (I can't find a substitute
> > > to twl4030_set_gpio_edge_ctrl and twl4030_set_gpio_debounce):
> > 
> > Something like that, yes.  I have other patches queued up though.
> > 
> > And meanwhile, your build seems goofed ... fix that first.
> 
> Yeah, it only happens when both mmc and twl4030-gpio are built as
> modules. Still sounds weird since we have EXPORT_SYMBOL() for those
> twl-specific crap.

Don't yet build twl4030 as a module.  The vmlinux object can't
link against symbols in other objects.  ;)

As I noted, the modular option is for build testing; when this
goes to mainline, this code should be able to build on most any
platform.  (Not just OMAP; not just ARM.)  I don't think any of
the OMAP boards which actually use this code will be able to use
that as a module, though.

When hsmmc.c behaves again, I've got patches to get rid of its
use of those twl-specific symbols.  Then that linkage issue
will go away.


> > For debouncing, see this LKML RFC:
> > 
> >   http://marc.info/?l=linux-kernel&m=122228602206108&w=2
> 
> the debouncing mechanism looks really good :-)

Kind of brainless ... except for the observation that
we pretty much need one of those.  ;)


> That's true. Didn't got that at first look. We should use something
> like:
> 
> return gpio_get_value_cansleep(irq_to_gpio(irq));
> 
> right ??

I want to avoid the irq_to_gpio() bit.   Eventually the whole
MMC/SD initialization needs reworking ... I doubt Overo will be
the only board using one SD for storage, and an SDIO for WLAN.


> it's good that you've been playing with twl4030-gpio. You've written
> gpiolib anyways, so you might better than I do where stuff should go.

Or in some cases:  where it's about time to add mechanisms
to gpiolib.  ;)

- dave

