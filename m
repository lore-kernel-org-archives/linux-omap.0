From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: Question regarding MUSB and dynamic fifo sizing
Date: Mon, 10 Aug 2009 19:16:06 +0300
Message-ID: <20090810161605.GA4357@gandalf>
References: <1249589441.10885.75.camel@blitz>
 <5A47E75E594F054BAF48C5E4FC4B92AB0305398DE4@dbde02.ent.ti.com>
 <1249665817.11736.21.camel@blitz>
 <FCCFB4CDC6E5564B9182F639FC35608702F5988E89@dbde02.ent.ti.com>
 <1249672953.11736.76.camel@blitz>
 <20090807201712.GB9780@nokia.com>
 <20090808064313.GA11613@nokia.com>
 <20090808071705.GA11844@nokia.com>
 <1249914799.25044.4.camel@blitz>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:54465 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755438AbZHJQQZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Aug 2009 12:16:25 -0400
Content-Disposition: inline
In-Reply-To: <1249914799.25044.4.camel@blitz>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Barada <peterb@logicpd.com>
Cc: felipe.balbi@nokia.com, "Pandita, Vikram" <vikram.pandita@ti.com>, "Gadiyar, Anand" <gadiyar@ti.com>, linux-omap <linux-omap@vger.kernel.org>

Hi,

On Mon, Aug 10, 2009 at 10:33:19AM -0400, Peter Barada wrote:
> On Sat, 2009-08-08 at 10:17 +0300, Felipe Balbi wrote:
> > Hi,
> > 
> > On Sat, Aug 08, 2009 at 09:43:13AM +0300, Felipe Balbi wrote:
> > > On Fri, Aug 07, 2009 at 10:17:12PM +0200, Balbi Felipe (Nokia-D/Helsinki) wrote:
> > > > On Fri, Aug 07, 2009 at 09:22:33PM +0200, ext Peter Barada wrote:
> > > > > Someting strange is going on.  If I boot with the MUSB->OTG adapter ->
> > > > > thumbdrive plugged in, and then modprobe the driver, it finds the
> > > > > thumbdrive.  I can then remove/reinsert the OTG adapter -> thumbdrive
> > > > > multiple times, and each time it is enumerated.
> > > > > 
> > > > > If I boot w/o the OTG adapter -> thumbdrive plugged in, modprobe the
> > > > > musb driver, and then plug in the OTG adaptor ->thumbdrive, it is not
> > > > > enumerated.
> > > > > 
> > > > > Any idea why I need the OTG adapter -> thumbdrive plugged in at kernel
> > > > > boot for it to enumerate the thumbdrive?
> > > > 
> > > > which board are you using ?
> > > 
> > > ok, got you. it's 35xx-based with twl4030.
> > > 
> > > when you plug the micro-a cable, see on drivers/usb/otg/twl4030-usb.c
> > > what happens. You should have a print about the link status, see if that
> > > is ID.
> > > 
> > > Then try something like this patch:
> > > 
> > > diff --git a/drivers/usb/otg/twl4030-usb.c b/drivers/usb/otg/twl4030-usb.c
> > > index 9e3e7a5..4bc5b7f 100644
> > > --- a/drivers/usb/otg/twl4030-usb.c
> > > +++ b/drivers/usb/otg/twl4030-usb.c
> 
> Felipe,
> 
> Thanks for the patch.  With the following modified patch (to fit my tree
> as my pull was from the Kevin's PM tree, commit
> 7c5cb7862d32cb344be7831d466535d5255e35ac) it worked like a charm:

Great, I'll clean it up and send it to Greg for mainline integration.

-- 
balbi
