From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [patch 2.6.29-rc3-git 2/2] USB: disable twl4030 USB regulators
 when cable unplugged
Date: Fri, 27 Feb 2009 12:29:08 +0000
Message-ID: <1235737748.31223.114.camel@vega.slimlogic.co.uk>
References: <200902081053.00255.david-b@pacbell.net>
	 <1235686596.31223.106.camel@vega.slimlogic.co.uk>
	 <200902261440.04129.david-b@pacbell.net>  <1235715573.7408.89.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from slimlogic.co.uk ([89.16.172.20]:58512 "EHLO slimlogic.co.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753541AbZB0M3N (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Feb 2009 07:29:13 -0500
In-Reply-To: <1235715573.7408.89.camel@ubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Cc: David Brownell <david-b@pacbell.net>, Mark Brown <broonie@sirena.org.uk>, lkml <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org, OMAP <linux-omap@vger.kernel.org>

On Fri, 2009-02-27 at 08:19 +0200, Kalle Jokiniemi wrote:
> On Thu, 2009-02-26 at 14:40 -0800, David Brownell wrote:
> > On Thursday 26 February 2009, Liam Girdwood wrote:
> > > On Sun, 2009-02-08 at 10:52 -0800, David Brownell wrote:
> > > > From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
> > > > 
> > > > This patch disables LDO regulators VUSB1V5, VUSB1V8, and VUSB3V1
> > > > when the USB cable is unplugged, to eliminate that source of power
> > > > waste.  (Enabled LDOs consume power at all times.)
> > > > 
> > > > Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
> > > > Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> > > > ---
> > > > Depends on the twl4030 regulator driver, so I'm suggesting this
> > > > be merged (with that driver) through the regulator patch queue
> > > > to simplify things.
> > > > 
> > > >  drivers/usb/otg/twl4030-usb.c |   30 ++++++++++++++++++++++++------
> > > >  1 file changed, 24 insertions(+), 6 deletions(-)
> > > 
> > > Applied.
> > 
> > Better suggestion:  grab Kalle's updated patch from Greg's USB
> > queue:
> > 
> >   http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-04-usb/
> > 
> > patch name usb-twl-disable-vusb-regulators-when-cable-unplugged.patch
> 
> 
> Yep, this previous one lacked some error checks and a build dependency
> to TWL_REGULATOR. 

I've now removed this patch from the regulator tree. I guess Greg will
take care of it via the USB tree now.

Thanks

Liam

