From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv2 1/7] i2c: omap: Fix the revision register read
Date: Mon, 5 Nov 2012 12:45:21 +0200
Message-ID: <20121105104521.GB3752@arwen.pp.htv.fi>
References: <1352025873-27492-1-git-send-email-shubhrajyoti@ti.com>
 <1352025873-27492-2-git-send-email-shubhrajyoti@ti.com>
 <20121105075026.GB32468@arwen.pp.htv.fi>
 <50977A30.6040907@ti.com>
 <20121105090412.GA2913@arwen.pp.htv.fi>
 <CAM=Q2csb_9ryaZfURqv6QgsVuSRiVMDt=x=Adko2HH4GoiHnCQ@mail.gmail.com>
 <20121105100105.GC3327@arwen.pp.htv.fi>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="24zk1gE8NUlDmwG9"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20121105100105.GC3327-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 05, 2012 at 12:01:05PM +0200, Felipe Balbi wrote:
> Hi,
>=20
> On Mon, Nov 05, 2012 at 02:54:32PM +0530, Shubhrajyoti Datta wrote:
> > On Mon, Nov 5, 2012 at 2:34 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> >=20
> > > Hi,
> > >
> > > On Mon, Nov 05, 2012 at 02:04:56PM +0530, Shubhrajyoti wrote:
> > > > >> @@ -1155,7 +1187,7 @@ omap_i2c_probe(struct platform_device *pde=
v)
> > > > >>
> > > > >>            dev->fifo_size =3D (dev->fifo_size / 2);
> > > > >>
> > > > >> -          if (dev->rev < OMAP_I2C_REV_ON_3630_4430)
> > > > >> +          if (dev->rev < OMAP_I2C_REV_ON_3630)
> > > > >>                    dev->b_hw =3D 1; /* Enable hardware fixes */
> > > > > looks like this was applicable to 4430 too, what happened ?
> > > > No actually this can be deleted completely once the
> > > > start -> transaction -> stop sequence recommendation is followed.
> > >
> > > yes, but we're not there just yet and this patch is changing the
> > > behavior of the driver
> >=20
> >=20
> > No , earlier we were truncating the register for omap4 so
> > OMAP_I2C_REV_ON_3630_4430 was there if we read both hi and lo for
> > omap4 then we donot find 3630 and 4430 value to be similar.
> >=20
> > In this case the behavior is same as earlier also it enabled this for
> > lower than 3630 and the same holds good even now.
> >=20
> > So in essence, Earlier  OMAP_I2C_REV_ON_3630_4430 is named to
> > OMAP_I2C_REV_ON_3630 and omap4 rev will have a 32bit value.
>=20
> it's not same behavior because before dev->b_hw was set for omap4430,
> but now it won't be. This is the difference in behavior which I'm
> pointing out.

what I said is nonsense, since b_hw was set for anything older than
3630, so current code is no different.

--=20
balbi

--24zk1gE8NUlDmwG9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQl5jBAAoJEIaOsuA1yqRE/OkQAJcrNN0sPDdIM5UM0AVGfHaU
cDrBkc1dGDOhvmgQKrD8Ibw23dBxqCJTnEOxmuN98RbWSa7xSk8ddU6uU/Mk/6dY
P2XCQUK7jqcm+LD4uj4hNqCVHBGUFKFkYFZVnhIbBQVOlEtaDCqSPlme+/hxXBVE
385qN2M710u+DmwG1FmowZA30rVBEd8V6JumNn9yBsZRym71dRrqIvv+FliR5SbS
fvzj/2n/dUnTAKAF9T205DVaoKBwa1hp3t2Ryluq5BaOgcz7Q5wbEtaVbO5GPnTz
cf1lnpiH03o6wt6zE3RijGwKsFwdaetsO9AvyaDWfLx7NAVMBe8BOHj/riviUG3H
QNf+WdwLdk/K0+B5V43ZLodyhHpKauUwqR78WuuUJTtu98l3q2M29L3gjDOugxjy
ve1gFsLYJJ7pQ6toRnfNy0aOaVU6o1ykiGN7MurTo6NuVoiItJuEtqMDhtPGM2rC
ONqImp4R3q9afpJaxQYbzAuGrFh74tXcxFGsaU0nOwzdbVB6aEDMHELSJTF5EsuJ
x9cFJf2+eq8mNpOkSQ3HydGIpbKNPzgAysGm7w2HQSn05SaoKj2Vy2BZ2pxENt0K
6TJug1d27L5Yf6QNpS5lJTBI1+TCzx9EX7MXJHMi82tDRbvdOOO4C7R/Z9cCOw5j
rkKU4N1N9fM8nLgzCE0+
=/0yg
-----END PGP SIGNATURE-----

--24zk1gE8NUlDmwG9--
