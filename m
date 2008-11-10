From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [patch 2.6.28-rc3-omap git 2/2] twl4030-gpio debounce cleanup
Date: Mon, 10 Nov 2008 17:03:28 +0200
Message-ID: <20081110150328.GY7467@gandalf.research.nokia.com>
References: <200811071159.49679.david-b@pacbell.net> <20081110131130.GS7467@gandalf.research.nokia.com> <200811100628.31085.david-b@pacbell.net>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:28528 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546AbYKJPEV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Nov 2008 10:04:21 -0500
Content-Disposition: inline
In-Reply-To: <200811100628.31085.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext David Brownell <david-b@pacbell.net>
Cc: felipe.balbi@nokia.com, linux-omap@vger.kernel.org

On Mon, Nov 10, 2008 at 06:28:30AM -0800, David Brownell wrote:
> On Monday 10 November 2008, Felipe Balbi wrote:
> >=20
> > > Provide a static debounce configuration mechanism for twl4030 GPI=
Os,
> > > replacing the previous dynamic one. =A0The single user of that me=
chanism
> > > was for MMC card detect debouncing.
> > >=20
> > > Boards can provide a bitmask saying which GPIOs to debounce (30 m=
sec).
> > > It's always enabled for pins with the MMC card-detect/VMMCx link =
active,
> > > so most boards won't need to set the debounce mask.
> >=20
> > Shouldn't you update hsmmc.c as well ??
>=20
> In some way one of the other patches didn't??
> ... I don't understand what you're implying.
>=20
> (Though the GPIO code might need to support the
> other mode -- active high vs low -- for the card
> detect-to-VMMCx linkage.)

I got your patches and build tested them, hsmmc.c still had
twl4030_gpio_debounce call. Maybe I missed one of the patches then.

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
