From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 12/33] Add tsc2005 touchscreen driver
Date: Sun, 7 Sep 2008 11:47:44 -0700
Message-ID: <200809071147.44766.david-b@pacbell.net>
References: <1220116593-862-4-git-send-email-me@felipebalbi.com> <1220116593-862-13-git-send-email-me@felipebalbi.com> <20080902213336.GB32575@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:41116 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754023AbYIGSrr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 7 Sep 2008 14:47:47 -0400
In-Reply-To: <20080902213336.GB32575@flint.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

On Tuesday 02 September 2008, Russell King - ARM Linux wrote:
> > +=A0=A0=A0=A0=A0ts->irq =3D OMAP_GPIO_IRQ(dav_gpio);
>=20
> In fact, this driver requires ARCH_OMAP to set ts->irq, otherwise
> it's uninitialized.

Or  ts->irq =3D gpio_to_irq(dav_gpio) ...

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
