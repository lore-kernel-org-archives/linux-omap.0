From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/NOT FOR MERGING 1/5] arm: omap: fix up _od_suspend_noirq
 and _od_resume_noirq
Date: Thu, 18 Oct 2012 19:55:25 +0300
Message-ID: <20121018165525.GA6385@arwen.pp.htv.fi>
References: <1350488043-5053-1-git-send-email-balbi@ti.com>
 <1350488043-5053-2-git-send-email-balbi@ti.com>
 <871ugvivso.fsf@deeprootsystems.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37226 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752992Ab2JRRCs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Oct 2012 13:02:48 -0400
Content-Disposition: inline
In-Reply-To: <871ugvivso.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 18, 2012 at 09:34:15AM -0700, Kevin Hilman wrote:
> Felipe Balbi <balbi@ti.com> writes:
>=20
> > current implementation doesn't take care about
> > drivers which don't provide *_noirq methods=20
>=20
> The generic ops handle this.  See below.
>=20
> > and we could fall into a situation where we would suspend/resume
> > devices even though they haven't asked for it.
>=20
> The following explanation doesn't explain this, so I dont' follow
> the "even though they haven't asked for it" part.
>=20
> > One such case happened with the I2C driver which
> > was getting suspended during suspend_noirq() just
> > to be resume right after by any other device doing
> > an I2C transfer on its suspend method.
>=20
> In order to be I2C to be runtime resumed after its noirq method has been
> called, that means the other device is doing an I2C xfer in its noirq
> method.  That is a bug.
>=20
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >  arch/arm/plat-omap/omap_device.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap=
_device.c
> > index 7a7d1f2..935f416 100644
> > --- a/arch/arm/plat-omap/omap_device.c
> > +++ b/arch/arm/plat-omap/omap_device.c
> > @@ -804,8 +804,12 @@ static int _od_suspend_noirq(struct device *dev)
> >  {
> >  	struct platform_device *pdev =3D to_platform_device(dev);
> >  	struct omap_device *od =3D to_omap_device(pdev);
> > +	const struct dev_pm_ops *pm =3D dev->driver ? dev->driver->pm : NULL;
> >  	int ret;
> > =20
> > +	if (!pm || !pm->suspend_noirq)
> > +		return 0;
> > +
>=20
> you just re implemented pm_generic_suspend_noirq() (c.f. drivers/base/pow=
er/generic_ops.c)
>=20
> >  	/* Don't attempt late suspend on a driver that is not bound */
> >  	if (od->_driver_status !=3D BUS_NOTIFY_BOUND_DRIVER)
> >  		return 0;
> > @@ -827,6 +831,10 @@ static int _od_resume_noirq(struct device *dev)
> >  {
> >  	struct platform_device *pdev =3D to_platform_device(dev);
> >  	struct omap_device *od =3D to_omap_device(pdev);
> > +	const struct dev_pm_ops *pm =3D dev->driver ? dev->driver->pm : NULL;
> > +
> > +	if (!pm || !pm->resume_noirq)
> > +		return 0;
>=20
> and this is basically pm_generic_resume_noirq()

not true, there is a slight different. Note that you only call
pm_generic_resume_noirq() after calling pm_runtime_resume()ing the
device:

> static int _od_resume_noirq(struct device *dev)
> {
> 	struct platform_device *pdev =3D to_platform_device(dev);
> 	struct omap_device *od =3D to_omap_device(pdev);
>=20
> 	if ((od->flags & OMAP_DEVICE_SUSPENDED) &&
> 	    !pm_runtime_status_suspended(dev)) {
> 		od->flags &=3D ~OMAP_DEVICE_SUSPENDED;
> 		if (!(od->flags & OMAP_DEVICE_NO_IDLE_ON_SUSPEND))
> 			omap_device_enable(pdev);
> 		pm_generic_runtime_resume(dev);

right here. IMHO this is a bug, if the define doesn't implement
resume_noirq, it's telling you that it has nothing to do at that time,
so you shouldn't forcefully resume the device.

If the device dies, then it means that it needs to implement
resume_noirq. What you have here, is a "workaround" for badly written
device drivers IMHO. Note also, that you could runtime resume devices
which don't implement resume_noirq().

the same is valid for suspend_noirq.

> 	}
>=20
> 	return pm_generic_resume_noirq(dev);
> }



--=20
balbi

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQgDR9AAoJEIaOsuA1yqREe2YQAKxHd+DkIGhkr7gwF6SfbvYR
2/85RWcYkzl0MoAQQ60Y7dSmM6sb4fLZ952CG4mHaCLD01r0m23okGaMOBSbX8tf
uP6bI+DxiP0LnHXYjkyqyoz4k8p3oo4o8Qs4DKvIQhaQPMDlLRadV/rT2aDIk0x0
NGS2liXdVIw1smZ14aMHIkIp82kletjhhevZ6rocVtX5G3mvstJaRtTimM15IS5S
AzfED04pxLs6p9AkXIc2gY98S/ZTe14sZlhKiLPNCTQjGziiwW4lBnKqRzI8uW2b
d84wS6VNdMbqOTJZ/jkkulpFjndOMLMiBmcQegl8RLTw+Y7NQkRsRSIetU9xUUlq
MBwJ8uOAXnX04/fZ2VyZTlU0EhVrtQGl8za82u4blMZS1W/LYBLN2RrOG8CCkpEe
9QNdPTrXeTH34nwrmv79/2H1BYWwoZXADTOTfDx3ckrmTHi3/Yf4ijEpRlaWiUmR
/8vk5Vda4B7dZ0d2NQY7FfGdZxLy2ay6s9g+4z6JTIulBRMeIwVyJJamKthcaFck
3ieQaD1gD/teiw1BBKoF2zYBjuiJeEYb7GWbDvuUtZlCcWzZhVXazdLY5zDqIIJU
HvH+9qwB2m8GB83t9zvgruwHN4yLshDTDi/7aMGju2/Vq1eDj1sR0ENNvy6+rn6S
cGfzzqyokgmksrNVLk4I
=jxwZ
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
