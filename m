From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH 1/2] PWM: ECAP: PWM driver support for ECAP APWM.
Date: Mon, 23 Jul 2012 11:22:04 +0200
Message-ID: <20120723092204.GA8607@avionic-0098.mockup.avionic-design.de>
References: <1342172102-30363-1-git-send-email-avinashphilip@ti.com>
 <1342172102-30363-2-git-send-email-avinashphilip@ti.com>
 <20120723065235.GA23797@avionic-0098.mockup.avionic-design.de>
 <518397C60809E147AF5323E0420B992E3E971530@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:62403 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402Ab2GWJW2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Jul 2012 05:22:28 -0400
Content-Disposition: inline
In-Reply-To: <518397C60809E147AF5323E0420B992E3E971530@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Philip, Avinash" <avinashphilip@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 23, 2012 at 09:10:09AM +0000, Philip, Avinash wrote:
> On Mon, Jul 23, 2012 at 12:22:35, Thierry Reding wrote:
> > On Fri, Jul 13, 2012 at 03:05:01PM +0530, Philip, Avinash wrote:
> > > +	/*
> > > +	 * Enable 'Free run Time stamp counter mode' to start counter
> > > +	 * and  'APWM mode' to enable APWM output
> > > +	 */
> > > +	reg_val =3D readw(pc->mmio_base + ECCTL2);
> > > +	reg_val |=3D ECCTL2_TSCTR_FREERUN | ECCTL2_APWM_MODE;
> >=20
> > You already set the APWM_MODE bit in .config(), why is it needed here
> > again? Seeing that .disable() clears the bit as well, perhaps leaving it
> > clear in .config() is the better option.
>=20
> Clearing APWM mode in .disable() ensures PWM low output (i.e., PWM pin =
=3D low=20
> in idle state).
>=20
> The Period & Compare registers are updated from Shadow registers (CAP1 & =
CAP2)
> During PWM configuration. To enable loading from Shadow registers, APWM m=
ode=20
> should be set.
> The same is done in .config().

My point was that if you do it in .enable(), then why do you still set
it in .config()? Since the sequence is typically .config() followed by
=2Eenable(), setting the bit in both seems redundant. It should be enough
to load the registers during .enable(), right?

> > > +	pc->chip.dev =3D &pdev->dev;
> > > +	pc->chip.ops =3D &ecap_pwm_ops;
> > > +	pc->chip.base =3D -1;
> > > +	pc->chip.npwm =3D 1;
> >=20
> > The cover letter mentions that the AM335x has 3 instances of the ECAP.
> > Is there any chance that they can be unified in one driver instance
> > (i.e. .npwm =3D 3?).
>=20
> No. All instances have separate resources (clocks, memory ..).
>=20
> >=20
> > > +
> > > +	r =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "ecap_reg"=
);
> > > +	if (r =3D=3D NULL) {
> >=20
> > You use "if (!ptr)" everywhere else, maybe you should make this
> > consistent?
> Ok
> > Also the platform_get_resource_byname() is really only
> > useful for devices that have several register regions associated with
> > them. I don't know your hardware in detail, but I doubt that a PWM
> > device has more than one register region.
>=20
> In fact PWM Module has 4 different register space (eCAP, eHRPWM, eQEP &=
=20
> Common Config space). So I need to use platform_get_resource_byname()

Above you say that all instances have separate resources, so how come
you need to specify 4 register spaces? The eCAP registers should clearly
be passed to the eCAP device, while the eHRPWM registers should go to
the eHRPWM device.

My point is that if you need to refer to the register region by name,
then the driver should clearly be using more than a single region.
Neither the eCAP nor eHRPWM do that.

Thierry

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQDRe8AAoJEN0jrNd/PrOhtOoQALsRK0esIco96Qd5+jZdeCe+
DBGRXOjo8MJ4sTawx6FZvP9CloC6Mqf9qNAxrY9840gFFem3krDqcR/AzOinFjfY
sOZUCGinneWMRjy7gBstnzTiiPpoLDIOlENsjWtDVlWzDIpi/ZACWyWUmD06DWUv
YxJR3UnWjQ2fBN4e4XY78lBXTqBM4jNPrwCtEQjCT3ZKv3AqR6t8YdA+WpKjRRRp
0/z1bpVQDpQlTNHUo8g16q2v9GqA+8PTNvD6sgAxZGyIfewFWZF4+BW38Cdd583z
6Egy/CME1N4HDU+EFGgF5K+mEZz4A6uoEnNtCwNdo52EhoGB8KtVy4JQhmMyGbz2
QT2UY835Xgt0eQVYpolbnSE1iNO70ypleoUe2C9y7q3VnI73iBckN9/sTytODoKm
UN+Ewak7tpKXNg5nO3tSuwujl/3nF5zRaEd07+Nq+JuydgUaULMj5PQCCQi0WdOb
n0umrWZJ1klMCUp5x1pTKlQWDqqI3mTkEPZ5eRZnO9P6bCgY10V02H8a4aXugRpL
FZXAp2MbCoOi9+QlR/WrrHSdSEp54eI7+2syJZ4qky+1ACAs21EVq4/tEbXdzadO
iSyGJn5t3QLUQtg9EWhdnS1LRPHEvQzRbYJT/sXIn9mxZ7Z2l9KNuzKo/AdHC5j/
Jd9h1AY6c1KIdwFflp1Q
=w6me
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
