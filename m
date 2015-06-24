From: Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v2] usb: dwc3: pci: make better use of gpiod API
Date: Wed, 24 Jun 2015 13:30:50 +0300
Message-ID: <20150624103050.GA8861@kuha.fi.intel.com>
References: <20150623100116.GB1296@kuha.fi.intel.com>
 <1435062306-2591-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1435062306-2591-1-git-send-email-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Jun 23, 2015 at 02:25:06PM +0200, Uwe Kleine-K=F6nig wrote:
> Since 39b2bbe3d715 (gpio: add flags argument to gpiod_get*() function=
s)
> which appeared in v3.17-rc1, the gpiod_get* functions take an additio=
nal
> parameter that allows to specify direction and initial value for outp=
ut.
>=20
> Use this additional parameter and the _optional variant to simplify t=
he
> driver and improve error handling. Also expand the comment to explain
> why it's not sensible to switch to devm_gpiod_get and why the gpiod_p=
ut
> is also necessary.
>=20
> Furthermore this is one caller less that stops us making the flags
> argument to gpiod_get*() mandatory.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Tested-by: Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>


Thanks,

--=20
heikki
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
