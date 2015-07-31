From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v5 02/46] usb: gadget: add endpoint capabilities flags
Date: Fri, 31 Jul 2015 10:58:10 -0500
Message-ID: <20150731155810.GI31041@saruman.tx.rr.com>
References: <1438351258-31578-1-git-send-email-r.baldyga@samsung.com>
 <1438351258-31578-3-git-send-email-r.baldyga@samsung.com>
 <063D6719AE5E284EB5DD2968C1650D6D1CB71091@AcuExch.aculab.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7772284958395875233=="
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1CB71091@AcuExch.aculab.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: David Laight <David.Laight@ACULAB.COM>
Cc: "nicolas.ferre@atmel.com" <nicolas.ferre@atmel.com>, "robert.jarzmik@free.fr" <robert.jarzmik@free.fr>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "cernekee@gmail.com" <cernekee@gmail.com>, "michal.simek@xilinx.com" <michal.simek@xilinx.com>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "Peter.Chen@freescale.com" <Peter.Chen@freescale.com>, "dahlmann.thomas@arcor.de" <dahlmann.thomas@arcor.de>, "johnyoun@synopsys.com" <johnyoun@synopsys.com>, 'Robert Baldyga' <r.baldyga@samsung.com>, "linux-geode@lists.infradead.org" <linux-geode@lists.infradead.org>, "haojian.zhuang@gmail.com" <haojian.zhuang@gmail.com>, "andrzej.p@samsung.com" <andrzej.p@samsung.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "petr.cvek@tul.cz" <petr.cvek@tul.cz>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============7772284958395875233==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GBuTPvBEOL0MYPgd"
Content-Disposition: inline

--GBuTPvBEOL0MYPgd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 31, 2015 at 03:51:52PM +0000, David Laight wrote:
> From: Robert Baldyga
> > Sent: 31 July 2015 15:00
> > Introduce struct usb_ep_caps which contains information about capabilit=
ies
> > of usb endpoints - supported transfer types and directions. This struct=
ure
> > should be filled by UDC driver for each of its endpoints, and will be
> > used in epautoconf in new ep matching mechanism which will replace ugly
> > guessing of endpoint capabilities basing on its name.
> >=20
> > Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
> > ---
> >  include/linux/usb/gadget.h | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >=20
> > diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
> > index 68fb5e8..a9a4959 100644
> > --- a/include/linux/usb/gadget.h
> > +++ b/include/linux/usb/gadget.h
> > @@ -141,10 +141,29 @@ struct usb_ep_ops {
> >  };
> ...
> > +struct usb_ep_caps {
> > +	unsigned type_control:1;
> > +	unsigned type_iso:1;
> > +	unsigned type_bulk:1;
> > +	unsigned type_int:1;
> > +	unsigned dir_in:1;
> > +	unsigned dir_out:1;
> > +};
>=20
> With the way this is used (eg below from 13/46)
>=20
> +
> +		if (i =3D=3D 0) {
> +			ep->ep.caps.type_control =3D true;
> +		} else {
> +			ep->ep.caps.type_iso =3D true;
> +			ep->ep.caps.type_bulk =3D true;
> +			ep->ep.caps.type_int =3D true;
> +		}
> +
> +		ep->ep.caps.dir_in =3D true;
> +		ep->ep.caps.dir_out =3D true;
>=20
> I think it would be more obvious if you used a u8 and explicit bitmasks.
> The initialisation (as above) would the be explicitly assigning 'not supp=
orted'
> to the other fields.
> The compiler will also generate much better code...

compiler should convert single bit flags into u32 just fine. It's all
static data anyway. Besides, single bit flags allow us to have as many
as we need without ending up with stuff like:

u32 flags;
u32 flags1;
u32 flags2;

etc. Just let the compiler do those conversions for us.

--=20
balbi

--GBuTPvBEOL0MYPgd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVu5sRAAoJEIaOsuA1yqREW+UQAJ503AefExQYzPY1uQAxv4m9
Y2YwLdzc3ZAIOeaN5VLEuIOUauYpTyq3cl7CbiB/RYfAyrWBvUqeV82lZAG3fLqs
14jtUu3orfgclX4zrtb0mSmVYv+jvI9pRDJNPysF3Y7zBFCtyJKJ2TO+qn4DQHSL
Rffk8b8UbiMqZeX+fbZt9Hh4a/pv53Fc+7aUNcGHhpOmSkx/cQZAjx+uwgK+0ANo
2K42ufAtEjqB83z0q8c/uuGMApLq5A7BwOxC1cWP+itjDtm7FxBo/CmWLck/M61E
ofUEkHHpoM2PK6nZyghgwgaLleEvC/sNtWWyhn8cJai/iYGNR50udBwmFW6/fY6I
NO0PA24HSTycbnqrAwFs2su4qHKQSCi580pYCAvIEmXBcIh6VxkkIsNkPumnxrEO
D+1s4j2otcbz/rmfvxqOvFi60rzhVZw4ydSBDyWtHAroSW8C9NSaxw5yi/dqmR//
4Ij4YiSxZHkxu3k9aOwXC9T0PdiHZtexY7RLrmdLUMmUbprXzqjfsr+St8Jzcvff
LY0cxJMaqNPX1nSpf4sf+NYoL/RKfOsThHMobIUz5yVKOm/+vhZYPKTehGaX51VR
i0uGuloEzyuYzWyvlUuFy0RNyLEhiAPV47IF/HTIH9v6S1kyJXX42cla6yQRBpBN
Mda/gXkbvixg3W5IEnyG
=M/Kf
-----END PGP SIGNATURE-----

--GBuTPvBEOL0MYPgd--

--===============7772284958395875233==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============7772284958395875233==--
