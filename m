From: David Brownell <david-b@pacbell.net>
Subject: Re: OMAP support in mainline?
Date: Fri, 3 Oct 2008 01:36:33 -0700
Message-ID: <200810030136.33838.david-b@pacbell.net>
References: <e5e6ade50810030020q62e2a305tf9111f626c1eb42f@mail.gmail.com> <20081003075220.GD10743@frodo>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:44199 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752811AbYJCIgg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 04:36:36 -0400
In-Reply-To: <20081003075220.GD10743@frodo>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: Nathan Monson <nmonson@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Friday 03 October 2008, Felipe Balbi wrote:
> On Fri, Oct 03, 2008 at 12:20:56AM -0700, Nathan Monson wrote:
> > On Thu, Sep 18, 2008 at 3:26PM, Felipe Balbi wrote:
> > > Yeah, we lost some musb history when it went to mainline. I didn't test
> > > this patch yet cuz I've been quite busy at work, but it should make
> > > beagle work. Could you tell me if makes it work ?
> > 
> > This patch has been working for me until the latest round of twl4030 changes.
> > 
> > Commit fde13f8fc7de977e71304fd500fed029b41ceb19/"move twl4030-usb to
> > platform-device" changed subsys_initcall to module_init in
> > twl4030-usb.
> > 
> > Now, twl4030-usb is initialized after musb.  This means
> > otg_set_transceiver is called later in boot, so the patch below gets
> > null back from otg_get_transceiver and oopses on *xceiv.
> > 
> > Unfortunately, without the patch, USB host doesn't work on the BeagleBoard.

I see it working ... there's a bit of oddness in a host-only config,
devices have to be plugged in after boot, but "doesn't work" seems
pretty wrong.

 
> > Other than this, the new kernel seems to work pretty well for me.
> 
> Dave, this will be fixed when i2c with your patch initializing i2c
> earlier on boot. Right ?

That's just driver model init, allowing i2c drivers to register
earlier, so subsys initcalls can rely on i2c to already have been
initialized ... so, no.

Within a given initcall level -- like subsys, or (later) driver -- the
initialization sequence is controlled by kernel link order, which is
a function of location in the source tree. 


> For now, let's keep subsys_initcall() on twl4030_usb. I'll prepare a
> patch and send it really soon.

That's the right longer-term answer, I think.

- Dave


> 
> Thanks for notifying me Nathan.
> 
> -- 
> balbi
> 
> 


