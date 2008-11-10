From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.28-rc3-omap git 2/2] twl4030-gpio debounce cleanup
Date: Mon, 10 Nov 2008 06:28:30 -0800
Message-ID: <200811100628.31085.david-b@pacbell.net>
References: <200811071159.49679.david-b@pacbell.net> <20081110131130.GS7467@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:40475 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753356AbYKJO2d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Nov 2008 09:28:33 -0500
In-Reply-To: <20081110131130.GS7467@gandalf.research.nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: linux-omap@vger.kernel.org

On Monday 10 November 2008, Felipe Balbi wrote:
>=20
> > Provide a static debounce configuration mechanism for twl4030 GPIOs=
,
> > replacing the previous dynamic one. =A0The single user of that mech=
anism
> > was for MMC card detect debouncing.
> >=20
> > Boards can provide a bitmask saying which GPIOs to debounce (30 mse=
c).
> > It's always enabled for pins with the MMC card-detect/VMMCx link ac=
tive,
> > so most boards won't need to set the debounce mask.
>=20
> Shouldn't you update hsmmc.c as well ??

In some way one of the other patches didn't??
=2E.. I don't understand what you're implying.

(Though the GPIO code might need to support the
other mode -- active high vs low -- for the card
detect-to-VMMCx linkage.)
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
