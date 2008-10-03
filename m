From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: OMAP support in mainline?
Date: Fri, 3 Oct 2008 10:52:24 +0300
Message-ID: <20081003075220.GD10743@frodo>
References: <e5e6ade50810030020q62e2a305tf9111f626c1eb42f@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:54697 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752864AbYJCHwm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 03:52:42 -0400
Content-Disposition: inline
In-Reply-To: <e5e6ade50810030020q62e2a305tf9111f626c1eb42f@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nathan Monson <nmonson@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, david-b@pacbell.net

On Fri, Oct 03, 2008 at 12:20:56AM -0700, Nathan Monson wrote:
> On Thu, Sep 18, 2008 at 3:26PM, Felipe Balbi wrote:
> > Yeah, we lost some musb history when it went to mainline. I didn't test
> > this patch yet cuz I've been quite busy at work, but it should make
> > beagle work. Could you tell me if makes it work ?
> 
> This patch has been working for me until the latest round of twl4030 changes.
> 
> Commit fde13f8fc7de977e71304fd500fed029b41ceb19/"move twl4030-usb to
> platform-device" changed subsys_initcall to module_init in
> twl4030-usb.
> 
> Now, twl4030-usb is initialized after musb.  This means
> otg_set_transceiver is called later in boot, so the patch below gets
> null back from otg_get_transceiver and oopses on *xceiv.
> 
> Unfortunately, without the patch, USB host doesn't work on the BeagleBoard.
> 
> Other than this, the new kernel seems to work pretty well for me.

Dave, this will be fixed when i2c with your patch initializing i2c
earlier on boot. Right ?

For now, let's keep subsys_initcall() on twl4030_usb. I'll prepare a
patch and send it really soon.

Thanks for notifying me Nathan.

-- 
balbi
