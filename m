From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 5/9] i2c: move twl4030-usb to platform_device
Date: Sat, 27 Sep 2008 18:01:13 -0700
Message-ID: <200809271801.14267.david-b@pacbell.net>
References: <1222427996-7018-1-git-send-email-felipe.balbi@nokia.com> <1222427996-7018-5-git-send-email-felipe.balbi@nokia.com> <1222427996-7018-6-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:25162 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751038AbYI1BBQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 27 Sep 2008 21:01:16 -0400
In-Reply-To: <1222427996-7018-6-git-send-email-felipe.balbi@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Friday 26 Septemb.er 2008, Felipe Balbi wrote:
> +=A0=A0=A0=A0=A0=A0=A0if (twl_has_usb() && pdata->usb) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0pdev =3D platform_devic=
e_alloc("twl4030_usb", -1);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (pdev) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
twl =3D &twl4030_modules[TWL4030_SLAVENUM_NUM0];
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
pdev->dev.parent =3D &twl->client->dev;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
device_init_wakeup(&pdev->dev, 1);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
status =3D platform_device_add_data(pdev, pdata->usb,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0sizeof(*pdata->usb));
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
if (status < 0) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0platform_device_put(pdev);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0goto err;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
}
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
status =3D platform_device_add(pdev);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
if (status < 0)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0platform_device_put(pdev);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0} else {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
status =3D -ENOMEM;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
goto err;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> +=A0=A0=A0=A0=A0=A0=A0}

I notice that here -- and elsewhere! -- you're not adding an IRQ
resource.  We should get rid of the TWL4030_MODIRQ_* and *_PWRIRQ_*
symbols ... I think you'll observe that the twl_has_gpio() branch
is a slightly better model than the original twl_has_rtc() code,
in terms of how to add each child that uses interrupts.

In this case you can add an IRQ resource 4 more than the base IRQ
(GPIO using 0 more), switch the relevant USB code over so that it's
using platform_get_irq(), and comment out TWL4030_MODIRQ_USB in
the header (now that nobody's using it).

I'll send a small IRQ cleanup patch doing that for the RTC in a
bit, after I sanity check it.

- Dave


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
