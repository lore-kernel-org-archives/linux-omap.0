From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 3/8] musb: fix compilation warning in host only mode
Date: Wed, 7 Jul 2010 15:01:29 -0700
Message-ID: <20100707220129.GA5884@kroah.com>
References: <1276771242-5201-1-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-2-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-3-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-4-git-send-email-ajay.gupta@ti.com>
 <20100624060338.GF8078@nokia.com>
 <19F8576C6E063C45BE387C64729E7394044E9E38CA@dbde02.ent.ti.com>
 <20100706091314.GG3035@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:35299 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752924Ab0GGWEE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Jul 2010 18:04:04 -0400
Content-Disposition: inline
In-Reply-To: <20100706091314.GG3035@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: "ext Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "gregkh@suse.de" <gregkh@suse.de>

On Tue, Jul 06, 2010 at 12:13:14PM +0300, Felipe Balbi wrote:
> Hi,
> 
> On Thu, Jun 24, 2010 at 01:17:54PM +0200, ext Gupta, Ajay Kumar wrote:
> >Fixes below compilation warning when host only configuration is
> >selected.
> >drivers/usb/musb/musb_core.c: In function 'musb_stage0_irq':
> >drivers/usb/musb/musb_core.c:711: warning: unused variable 'mbase'
> >
> >Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> 
> Acked-by: Felipe Balbi <felipe.balbi@nokia.com>

You've acked a random ammount of patches recently, are you going to be
resending them to me?  I have a hard time going back and digging through
the archives to pick out the ones that you acked vs. the ones you
didn't.

thanks,

greg k-h
