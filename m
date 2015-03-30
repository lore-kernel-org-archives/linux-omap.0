From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] genirq: provide dummy set_irq_wake()
Date: Mon, 30 Mar 2015 13:06:45 -0500
Message-ID: <20150330180645.GC9513@saruman.tx.rr.com>
References: <1427721345-6402-1-git-send-email-rogerq@ti.com>
 <20150330180624.GB9513@saruman.tx.rr.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WChQLJJJfbwij+9x"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150330180624.GB9513@saruman.tx.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Roger Quadros <rogerq@ti.com>, tglx@linutronix.de, cw00.choi@samsung.com, tony@atomide.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--WChQLJJJfbwij+9x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2015 at 01:06:24PM -0500, Felipe Balbi wrote:
> On Mon, Mar 30, 2015 at 04:15:45PM +0300, Roger Quadros wrote:
> > Without this system suspend is broken on systems that have
> > drivers calling enable/disable_irq_wake() for interrupts based off
> > the dummy irq hook.
> > (e.g. drivers/gpio/gpio-pcf857x.c)
> >=20
> > http://article.gmane.org/gmane.linux.kernel/1879035
> >=20
> > Signed-off-by: Roger Quadros <rogerq@ti.com>
> > ---
> >  kernel/irq/dummychip.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >=20
> > diff --git a/kernel/irq/dummychip.c b/kernel/irq/dummychip.c
> > index 988dc58..2405d7a 100644
> > --- a/kernel/irq/dummychip.c
> > +++ b/kernel/irq/dummychip.c
> > @@ -32,6 +32,11 @@ static unsigned int noop_ret(struct irq_data *data)
> >  	return 0;
> >  }
> > =20
> > +static int noop_int_ret(struct irq_data *data, unsigned int val)
> > +{
> > +	return 0;
> > +}
> > +
>=20
> isn't this the same as noop_ret ?

oh no, unsigned versus signed.

--=20
balbi

--WChQLJJJfbwij+9x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVGZC1AAoJEIaOsuA1yqRETfoP/0Ngs0hp78QEP9JY8ziDYbfx
hqW4Tcx/oOVedpRrIn9Xdb/h7fXADNxv/SEO6s6HEmViRu9XqgmzffPt/n6jkGnZ
l4KQPeFlPuvLcSMGo5rohbbCIEJBzD6YIZpVA3oyVyWY6uirsE6UJIGgVg8svxFp
YIlrMhqvOvNEecdVaX8UB33JZmwZmY4HDW4jBdD0CV9qgT066/1LwyE4r7Fsezk7
H/ndneRPBKt1q8+SXRC51dGrlcbzaf3alab4BMfrWHttSRHOf1XWceKa7M5Zgtkc
YidZyxzdJAz0z+N61WOP/KXLcbICwMMm0XkHyecXo926bIYmF+WHQpOWf9bwb8nY
sCwTgvSXAKCs6VUu9KUNLGu9SmolLoVuelieP1RKtpEWJwNBxOWdXV4KVCMf0fOe
HsCvD3SK7VPSJfOyUSgBv+8HetuRHhqBbSobPSD0/P1wXWY/8NiQ8VWLFNKJR8t7
eYAAlrter5xx5ia7BbxvMZUBQ2ZnOBl+Jn1MEwdDIEyeBZlxtSPE5K1QULssNXhF
C4o9RQMDxDbOYd4XKlyLNqdrD3deEpfYkSBbEkscjnuq54pfwwFkUcu2DWuFkrHK
RHGY7ApOkfEY83WyBxJZ6dEgp4HJNXCu0Vm9UaT6a3Kg+5JTJhkPpxJdIYBFB9To
6XJHuo/UgH+i+l9LGj+J
=4SHz
-----END PGP SIGNATURE-----

--WChQLJJJfbwij+9x--
