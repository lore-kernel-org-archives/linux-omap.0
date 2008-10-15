From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 2/7] input: tsc2005: move to gpiolib
Date: Wed, 15 Oct 2008 10:43:55 +0300
Message-ID: <20081015074354.GD31842@frodo>
References: <1224020397-2842-1-git-send-email-me@felipebalbi.com> <1224020397-2842-2-git-send-email-me@felipebalbi.com> <1224020397-2842-3-git-send-email-me@felipebalbi.com> <200810141620.04834.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:51497 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751598AbYJOHoP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2008 03:44:15 -0400
Content-Disposition: inline
In-Reply-To: <200810141620.04834.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Felipe Balbi <me@felipebalbi.com>, linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Tue, Oct 14, 2008 at 04:20:04PM -0700, David Brownell wrote:
> On Tuesday 14 October 2008, Felipe Balbi wrote:
> > -=A0=A0=A0=A0=A0=A0=A0omap_set_gpio_direction(dav_gpio, 1);
> > +=A0=A0=A0=A0=A0=A0=A0gpio_direction_input(dav_gpio);
> > =A0=A0=A0=A0=A0=A0=A0=A0ts->irq =3D OMAP_GPIO_IRQ(dav_gpio);
>=20
> That should be ts->irq =3D gpio_to_irq(dav_gpio) ...

good catch :-)
will resend soon.

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
