From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] twl4030-usb: rename twl4030_driver to
	twl4030_usb_driver.
Date: Thu, 16 Oct 2008 15:08:37 -0700
Message-ID: <20081016220837.GY15820@atomide.com>
References: <1223964434-5752-1-git-send-email-j-pakaravoor@ti.com> <20081016212334.GV15820@atomide.com> <200810161505.05279.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58551 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756774AbYJPWIl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Oct 2008 18:08:41 -0400
Content-Disposition: inline
In-Reply-To: <200810161505.05279.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org, Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>

* David Brownell <david-b@pacbell.net> [081016 15:05]:
> On Thursday 16 October 2008, Tony Lindgren wrote:
> > * Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com> [081014 11:08]:
> > > The i2c_driver in twl4030-core.c and platform_driver of twl4030-usb.c
> > > both has the name twl4030_driver. This leads to unnecessary confusion.
> > > 
> > > So rename the usb platform_driver appropriately to:
> > > twl4030_usb_driver.
> > 
> > Dave, is this OK with you? I don't want this to get out of sync with
> > mainline..
> 
> Sure, no problem.  This driver isn't yet in the mainline queue.

OK, pushed.

Tony

> 
> 
> > Tony
> > 
> > > 
> > > Signed-off-by: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
> > > Index: linux-omap-git/drivers/i2c/chips/twl4030-usb.c
> > > ===================================================================
> > > --- linux-omap-git.orig/drivers/i2c/chips/twl4030-usb.c	2008-10-10 20:35:15.000000000 +0530
> > > +++ linux-omap-git/drivers/i2c/chips/twl4030-usb.c	2008-10-14 11:01:09.785700607 +0530
> > > @@ -758,7 +758,7 @@ static int __exit twl4030_usb_remove(str
> > >  	return 0;
> > >  }
> > >  
> > > -static struct platform_driver twl4030_driver = {
> > > +static struct platform_driver twl4030_usb_driver = {
> > >  	.probe		= twl4030_usb_probe,
> > >  	.remove		= __exit_p(twl4030_remove),
> > >  	.driver		= {
> > > @@ -769,13 +769,13 @@ static struct platform_driver twl4030_dr
> > >  
> > >  static int __init twl4030_usb_init(void)
> > >  {
> > > -	return platform_driver_register(&twl4030_driver);
> > > +	return platform_driver_register(&twl4030_usb_driver);
> > >  }
> > >  subsys_initcall(twl4030_usb_init);
> > >  
> > >  static void __exit twl4030_usb_exit(void)
> > >  {
> > > -	platform_driver_unregister(&twl4030_driver);
> > > +	platform_driver_unregister(&twl4030_usb_driver);
> > >  }
> > >  module_exit(twl4030_usb_exit);
> > >  
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > 
> 
> 
