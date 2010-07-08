From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH 3/8] musb: fix compilation warning in host only mode
Date: Thu, 8 Jul 2010 07:23:44 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044EB95AE0@dbde02.ent.ti.com>
References: <1276771242-5201-1-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-2-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-3-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-4-git-send-email-ajay.gupta@ti.com>
 <20100624060338.GF8078@nokia.com>
 <19F8576C6E063C45BE387C64729E7394044E9E38CA@dbde02.ent.ti.com>
 <20100706091314.GG3035@nokia.com> <20100707220129.GA5884@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59805 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757335Ab0GHByH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jul 2010 21:54:07 -0400
In-Reply-To: <20100707220129.GA5884@kroah.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>, Felipe Balbi <felipe.balbi@nokia.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "gregkh@suse.de" <gregkh@suse.de>

Hi,
> > On Thu, Jun 24, 2010 at 01:17:54PM +0200, ext Gupta, Ajay Kumar wrote:
> > >Fixes below compilation warning when host only configuration is
> > >selected.
> > >drivers/usb/musb/musb_core.c: In function 'musb_stage0_irq':
> > >drivers/usb/musb/musb_core.c:711: warning: unused variable 'mbase'
> > >
> > >Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> >
> > Acked-by: Felipe Balbi <felipe.balbi@nokia.com>
> 
> You've acked a random ammount of patches recently, are you going to be
> resending them to me?  I have a hard time going back and digging through
> the archives to pick out the ones that you acked vs. the ones you
> didn't.

Greg,

There are 2 musb and 1 ehci-omap bug fix patches which are acked.
Another related one is on ULPI and is trivial.

Apart from these, 2 musb patches for v2.6.36 window are also acked.

I will prepare the set and send you after sanity testing.

Thanks,
Ajay 
> 
> thanks,
> 
> greg k
