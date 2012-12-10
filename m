From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH 1/5] drivers : introduce device_path api
Date: Mon, 10 Dec 2012 16:36:02 +0200
Message-ID: <20121210143601.GG11038@arwen.pp.htv.fi>
References: <CACVXFVNkp0+WmTyG2+YMjTvzCRi3sQZKmG6sG8diqZZj-hwg6g@mail.gmail.com>
 <Pine.LNX.4.44L0.1211271119380.1489-100000@iolanthe.rowland.org>
 <20121127170223.GB2687@kroah.com>
 <CABb+yY3TC3z+jRU91KGX+FKLtJ3ZXUp55-wM_KjxiYuVZ+LL+Q@mail.gmail.com>
 <50BF55B3.1030205@ti.com>
 <CABb+yY1xVMGFbedq8Wp2Muz13XAxJUKOk_=Z_UCEBkpzrtVz4A@mail.gmail.com>
 <50C5B003.9060904@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c7hkjup166d4FzgN"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <50C5B003.9060904-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, keshava_mgowda-l0cyMroinI0@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--c7hkjup166d4FzgN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 10, 2012 at 11:48:51AM +0200, Roger Quadros wrote:
> >>>  (or in appropriate order if the above isn't)
> >>> That way insmod/rmmod'ing the USB3320C driver would power-up/down the
> >>> whole subsystem.
> >>
> >> Yes, this is where we can think of a generic PHY driver to make sure t=
hy
> >> PHY has necessary resources enabled. In the Panda case it would be the
> >> PHY clock and RESET gpio.
> >>
> > I wonder if ehci-omap should assume, besides regulator, a clock might
> > also be need to setup for the transceiver chip.
> > Maybe "usbhs_bdata" in board-omap4panda.c should have
> > .reset_gpio_port[0]  =3D GPIO_HUB_NRESET ?
> >=20
>=20
> Just like the regulator, reset_gpio_port has nothing to do with OMAP
> EHCI. So we would want to get rid of that too from the OMAP USB driver.

+1 to that.

That's a requirement from the LAN95xx hub controller, not OMAP EHCI ;-)

--=20
balbi

--c7hkjup166d4FzgN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQxfNRAAoJEIaOsuA1yqREOYYQAJ6pkau8RvRXCrH3RCT3hlWu
J4OjjaEPRLyX838Eu+n5rIJpwiGzBGU0ftDxeZtv8kTdex2qteX8s5GI1rHEVLBa
FOCArcPdDVbcxHkGSAzaUKCXUBb/eUKoxXzYA3l9gh2lOodB8q/nRoENSH9ejPNk
JvIKFPEaibMtugpWqyvfzxx7wQc2YGz24I809+AMDUNztGna+13SNdG4M0njAfD4
1qy3P+Xw2L1982bCHCVI0RpYld54izNo1kiJSawkuvuwbo489n0kwRe2UNro8uOL
sHt0OUTuenV7At58QBZ5wv5bbDx5qcxv5/nCoyfiFURYO9Lrs7ypCU1ZL8bqMGRY
MZlNIMSRxKE7ZuakS1q3JB3cOw/xElplKWhrupOXRaBSQ24R816gAyEhUDNEuxDg
oHggG9VvI1qcUwHtiGm2YbHfYvzTBO+2JUUU+GyYrAaEAr8cvomepq75+OxqdXeT
D8Qx6Hq7mXsG8103I1ZlpIMBm3UDhy8ygv4qADs9CfXH8YfJaOYwperr0ovACOgz
nBd/WDe2lntFwaUU6YjX0ielRwlYnxI02S6SfmZTFHdG1UmJIrmhurb9TghWc72g
Kp0xN2L6E4IDmWOd0IhdIPtPKy38J9WW+WZxN1pdsuve1n2+gRaPu+WYkggTGerp
ENBBdhMXascungqbz9nO
=+wk1
-----END PGP SIGNATURE-----

--c7hkjup166d4FzgN--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
