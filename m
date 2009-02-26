From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.29-rc3-git 2/2] USB: disable twl4030 USB regulators when cable unplugged
Date: Thu, 26 Feb 2009 14:40:03 -0800
Message-ID: <200902261440.04129.david-b@pacbell.net>
References: <200902081053.00255.david-b@pacbell.net> <1235686596.31223.106.camel@vega.slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1235686596.31223.106.camel-Pyf+wNJ1SdNifHs85vQuMtBc4/FLrbF6@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Liam Girdwood <lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>
Cc: Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, OMAP <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kalle Jokiniemi <kalle.jokiniemi-sMOQStClEysAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thursday 26 February 2009, Liam Girdwood wrote:
> On Sun, 2009-02-08 at 10:52 -0800, David Brownell wrote:
> > From: Kalle Jokiniemi <kalle.jokiniemi-sMOQStClEysAvxtiuMwx3w@public.gmane.org>
> > 
> > This patch disables LDO regulators VUSB1V5, VUSB1V8, and VUSB3V1
> > when the USB cable is unplugged, to eliminate that source of power
> > waste.  (Enabled LDOs consume power at all times.)
> > 
> > Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi-sMOQStClEysAvxtiuMwx3w@public.gmane.org>
> > Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> > ---
> > Depends on the twl4030 regulator driver, so I'm suggesting this
> > be merged (with that driver) through the regulator patch queue
> > to simplify things.
> > 
> >  drivers/usb/otg/twl4030-usb.c |   30 ++++++++++++++++++++++++------
> >  1 file changed, 24 insertions(+), 6 deletions(-)
> 
> Applied.

Better suggestion:  grab Kalle's updated patch from Greg's USB
queue:

  http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-04-usb/

patch name usb-twl-disable-vusb-regulators-when-cable-unplugged.patch

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
