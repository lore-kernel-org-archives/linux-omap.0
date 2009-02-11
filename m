From: Kalle Jokiniemi <kalle.jokiniemi-sMOQStClEysAvxtiuMwx3w@public.gmane.org>
Subject: Re: [patch 2.6.29-rc3-git 2/2] USB: disable twl4030 USB regulators
	when cable unplugged
Date: Wed, 11 Feb 2009 08:25:12 +0200
Message-ID: <1234333512.17391.31.camel@ubuntu>
References: <200902081053.00255.david-b@pacbell.net>
	 <1234274767.17391.20.camel@ubuntu> <200902101152.59526.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200902101152.59526.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Liam Girdwood <lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>, Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, OMAP <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, =?ISO-8859-1?Q?H=F6gander?= Jouni <jouni.hogander-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, 2009-02-10 at 11:52 -0800, David Brownell wrote:
> On Tuesday 10 February 2009, Kalle Jokiniemi wrote:
> > > This patch disables LDO regulators VUSB1V5, VUSB1V8, and VUSB3V1
> > > when the USB cable is unplugged, to eliminate that source of power
> > > waste.  (Enabled LDOs consume power at all times.)
> > 
> > Please put this on hold for a while. This won't work if we don't have
> > TWL regulator support enabled.
> 
> So Kconfig should have TWL4030_USB depend on REGULATOR_TWL4030?

Yes.

> 
> 
> > Also it's missing error value checking. 
> 
> You mean like in the ldo_init() stuff?  Fair enough.

I mean, if regulator_get fails. 

- Kalle

> 
> - Dave
> 
> 
> > I'll post new patch(es) soon.
> > 
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
