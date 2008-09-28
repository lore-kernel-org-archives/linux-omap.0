From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 5/9] i2c: move twl4030-usb to platform_device
Date: Sun, 28 Sep 2008 06:03:20 +0300
Message-ID: <20080928030319.GE8468@frodo>
References: <1222427996-7018-1-git-send-email-felipe.balbi@nokia.com> <1222427996-7018-5-git-send-email-felipe.balbi@nokia.com> <1222427996-7018-6-git-send-email-felipe.balbi@nokia.com> <200809271801.14267.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:40860 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751062AbYI1DDa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 27 Sep 2008 23:03:30 -0400
Content-Disposition: inline
In-Reply-To: <200809271801.14267.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Sat, Sep 27, 2008 at 06:01:13PM -0700, David Brownell wrote:
> On Friday 26 Septemb.er 2008, Felipe Balbi wrote:
> > +=A0=A0=A0=A0=A0=A0=A0if (twl_has_usb() && pdata->usb) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0pdev =3D platform_dev=
ice_alloc("twl4030_usb", -1);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (pdev) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0twl =3D &twl4030_modules[TWL4030_SLAVENUM_NUM0];
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0pdev->dev.parent =3D &twl->client->dev;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0device_init_wakeup(&pdev->dev, 1);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0status =3D platform_device_add_data(pdev, pdata->usb,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0sizeof(*pdata->usb))=
;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0if (status < 0) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0platform_device_put(pdev);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0goto err;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0}
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0status =3D platform_device_add(pdev);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0if (status < 0)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0platform_device_put(pdev);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0} else {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0status =3D -ENOMEM;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0goto err;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > +=A0=A0=A0=A0=A0=A0=A0}
>=20
> I notice that here -- and elsewhere! -- you're not adding an IRQ
> resource.  We should get rid of the TWL4030_MODIRQ_* and *_PWRIRQ_*
> symbols ... I think you'll observe that the twl_has_gpio() branch
> is a slightly better model than the original twl_has_rtc() code,
> in terms of how to add each child that uses interrupts.
>=20
> In this case you can add an IRQ resource 4 more than the base IRQ
> (GPIO using 0 more), switch the relevant USB code over so that it's
> using platform_get_irq(), and comment out TWL4030_MODIRQ_USB in
> the header (now that nobody's using it).
>=20
> I'll send a small IRQ cleanup patch doing that for the RTC in a
> bit, after I sanity check it.

Sure, I'll update soonish, I'll mail for you only a new series so you
can work on top of that. I changed a few bits, but i'm not keen to floo=
d
linux-omap with unfinished patches again :-p

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
