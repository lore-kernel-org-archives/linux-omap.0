From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 4/7] i2c: omap: in case of VERSION_2 read
 IRQSTATUS_RAW but write to IRQSTATUS
Date: Thu, 25 Oct 2012 15:52:49 +0300
Message-ID: <20121025125249.GK21217@arwen.pp.htv.fi>
References: <1350899218-13624-1-git-send-email-balbi@ti.com>
 <1351167915-15079-1-git-send-email-balbi@ti.com>
 <1351167915-15079-5-git-send-email-balbi@ti.com>
 <50893665.60604@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Lg8eXa+brxrbjAbR"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <50893665.60604-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Shubhrajyoti Datta <shubhrajyoti-l0cyMroinI0@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--Lg8eXa+brxrbjAbR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 25, 2012 at 06:23:57PM +0530, Santosh Shilimkar wrote:
> On Thursday 25 October 2012 05:55 PM, Felipe Balbi wrote:
> >on OMAP4+ we want to read IRQSTATUS_RAW register,
> >instead of IRQSTATUS. The reason being that IRQSTATUS
> >will only contain the bits which were enabled on
> >IRQENABLE_SET and that will break when we need to
> >poll for a certain bit which wasn't enabled as an
> >IRQ source.
> >
> >One such case is after we finish converting to
> >deferred stop bit, we will have to poll for ARDY
> >bit before returning control for the client driver
> >in order to prevent us from trying to start a
> >transfer on a bus which is already busy.
> >
> >Note, however, that omap-i2c.c needs a big rework
> >on register definition and register access. Such
> >work will be done in a separate series of patches.
> >
> >Cc: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
> >Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> >---
> >  drivers/i2c/busses/i2c-omap.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >
> >diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap=
=2Ec
> >index b004126..20f9ad6 100644
> >--- a/drivers/i2c/busses/i2c-omap.c
> >+++ b/drivers/i2c/busses/i2c-omap.c
> >@@ -271,8 +271,18 @@ static inline void omap_i2c_write_reg(struct omap_i=
2c_dev *i2c_dev,
> >
> >  static inline u16 omap_i2c_read_reg(struct omap_i2c_dev *i2c_dev, int =
reg)
> >  {
> >-	return __raw_readw(i2c_dev->base +
> >+	/* if we are OMAP_I2C_IP_VERSION_2, we need to read from
> >+	 * IRQSTATUS_RAW, but write to IRQSTATUS
> >+	 */
> >+	if ((i2c_dev->dtrev =3D=3D OMAP_I2C_IP_VERSION_2) &&
> >+			(reg =3D=3D OMAP_I2C_STAT_REG)) {
> Doing this check on every I2C register read seems to
> expensive to me. Can you not sort this in init with some offset
> which can be 0 or non zero ?  Sorry in case this is already dicussed.

could be. I didn't go that route because I'm planning a complete rewrite
of all register accesses. The way it's done today is completely broken
and already expensive (with reg_shift and different map tables and so
on).

If it's really a big of a deal, I can try to find another way, maybe
just adding omap_i2c_read_stat() and limit the version check just to
I2C_STAT reads would do it for now...

--=20
balbi

--Lg8eXa+brxrbjAbR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQiTYhAAoJEIaOsuA1yqREOSIP+gMtbRFMbKTKXs8SeC1UQgyj
IJiY/d7XGQ2z/kdj8PdsqtJ007a1sRZ22LZXzhjhFUgdd3hQ9FRi0nn0ZJ8EpPf/
eoNjHBhOL3v7gAslekWpDGdpF1+Uv5cW4jtypwTZf2/HTQGpn7qG71XHgSmrRRFQ
2+4vjFf4cC7v10FR1XtP+AukkFQSXXb5dJJVn9aHJDgbyzRaCS2nPJ3s9dDKemlE
sT3LNuny+S2kSom1+C2xpoyPtUyhWek5fh+9ImkkOi1EhJaip5I9YmghpImy5zPC
qk/D5ynJdI83ox6dV2bwlUNjOJCJBh/5Aj1ug/pdH8u+SUlcV568J63FdWrBvQEF
HWC9ZqQ6HqRtbMeib/L5kEj5FUbQ7dgV5cG0+R8ZAhs6jzLitYSMdmzNmwn4D1F5
dtc6wVJgVSkPmuH6YSwMALHel3lWbfeQQqXWPLj46UiqLiQaETp6/lO0aC/4uF94
39FmXoCmEcjd7/G+EilD01TEclOWhWasBR0R1xiCJp3HhQnUOqTWMg9T36I/vvcq
mn/2u+Rz1ymVRiRIQOgWM/+3kCYjBaWldNgNzF+X5+vkThDVO4sPvQQ2U2/1L8Xf
sVK6e+9anNtpWcWXQgOH3eUjHitraRlsIolRJVMbgQMEbaQoRUBMOgoKO2OAqmLp
bIqNNQc0pFq9uUnEJOWK
=yAjq
-----END PGP SIGNATURE-----

--Lg8eXa+brxrbjAbR--
