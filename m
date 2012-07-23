From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH 1/2] PWM: ECAP: PWM driver support for ECAP APWM.
Date: Mon, 23 Jul 2012 15:37:04 +0200
Message-ID: <20120723133704.GB21254@avionic-0098.mockup.avionic-design.de>
References: <1342172102-30363-1-git-send-email-avinashphilip@ti.com>
 <1342172102-30363-2-git-send-email-avinashphilip@ti.com>
 <20120723065235.GA23797@avionic-0098.mockup.avionic-design.de>
 <518397C60809E147AF5323E0420B992E3E971530@DBDE01.ent.ti.com>
 <20120723092204.GA8607@avionic-0098.mockup.avionic-design.de>
 <518397C60809E147AF5323E0420B992E3E971887@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:55653 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325Ab2GWNhQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Jul 2012 09:37:16 -0400
Content-Disposition: inline
In-Reply-To: <518397C60809E147AF5323E0420B992E3E971887@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Philip, Avinash" <avinashphilip@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 23, 2012 at 12:44:38PM +0000, Philip, Avinash wrote:
> On Mon, Jul 23, 2012 at 14:52:04, Thierry Reding wrote:
> > On Mon, Jul 23, 2012 at 09:10:09AM +0000, Philip, Avinash wrote:
> > > On Mon, Jul 23, 2012 at 12:22:35, Thierry Reding wrote:
> > > > On Fri, Jul 13, 2012 at 03:05:01PM +0530, Philip, Avinash wrote:
> > > > > +	/*
> > > > > +	 * Enable 'Free run Time stamp counter mode' to start counter
> > > > > +	 * and  'APWM mode' to enable APWM output
> > > > > +	 */
> > > > > +	reg_val =3D readw(pc->mmio_base + ECCTL2);
> > > > > +	reg_val |=3D ECCTL2_TSCTR_FREERUN | ECCTL2_APWM_MODE;
> > > >=20
> > > > You already set the APWM_MODE bit in .config(), why is it needed he=
re
> > > > again? Seeing that .disable() clears the bit as well, perhaps leavi=
ng it
> > > > clear in .config() is the better option.
> > >=20
> > > Clearing APWM mode in .disable() ensures PWM low output (i.e., PWM pi=
n =3D low=20
> > > in idle state).
> > >=20
> > > The Period & Compare registers are updated from Shadow registers (CAP=
1 & CAP2)
> > > During PWM configuration. To enable loading from Shadow registers, AP=
WM mode=20
> > > should be set.
> > > The same is done in .config().
> >=20
> > My point was that if you do it in .enable(), then why do you still set
> > it in .config()? Since the sequence is typically .config() followed by
> > .enable(), setting the bit in both seems redundant. It should be enough
> > to load the registers during .enable(), right?
>=20
> Consider scenarios where .enable() can be called without calling .config(=
).
> Example I just need to stop the pwm signal momentarily and re-enable.
> In this case, .config() need not be called. So, APWM mode bit needs to be=
=20
> set in .enable()
>=20
> Now, considering .config() followed by .enable().
> Currently in PWM driver, the CAP1 & CAP2 registers is copied to shadow=20
> Registers (CAP3 & CAP4) by hardwaare in .config(). This requires APWM
> mode bit to be set.=20
>=20
> The same can be done in .enable() also. However, we again need to pass=20
> the pwm parameters (period & duty cycle values) to the .enable().=20
> We don't want to duplicate this parameter passing.=20
> To avoid this we enable the APWM mode bit in both .config() & .enable().

That's weird. I assumed that the values written to the shadow registers
would automatically be copied to the active registers on each new PWM
period. If I understand correctly what you're saying, however, the eCAP
requires the APWM bit to be set in order to write the shadow registers
at all.

> > > > > +	pc->chip.dev =3D &pdev->dev;
> > > > > +	pc->chip.ops =3D &ecap_pwm_ops;
> > > > > +	pc->chip.base =3D -1;
> > > > > +	pc->chip.npwm =3D 1;
> > > >=20
> > > > The cover letter mentions that the AM335x has 3 instances of the EC=
AP.
> > > > Is there any chance that they can be unified in one driver instance
> > > > (i.e. .npwm =3D 3?).
> > >=20
> > > No. All instances have separate resources (clocks, memory ..).
> > >=20
> > > >=20
> > > > > +
> > > > > +	r =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "ecap_=
reg");
> > > > > +	if (r =3D=3D NULL) {
> > > >=20
> > > > You use "if (!ptr)" everywhere else, maybe you should make this
> > > > consistent?
> > > Ok
> > > > Also the platform_get_resource_byname() is really only
> > > > useful for devices that have several register regions associated wi=
th
> > > > them. I don't know your hardware in detail, but I doubt that a PWM
> > > > device has more than one register region.
> > >=20
> > > In fact PWM Module has 4 different register space (eCAP, eHRPWM, eQEP=
 &=20
> > > Common Config space). So I need to use platform_get_resource_byname()
> >=20
> > Above you say that all instances have separate resources, so how come
> > you need to specify 4 register spaces? The eCAP registers should clearly
> > be passed to the eCAP device, while the eHRPWM registers should go to
> > the eHRPWM device.
> >=20
> > My point is that if you need to refer to the register region by name,
> > then the driver should clearly be using more than a single region.
> > Neither the eCAP nor eHRPWM do that.
>=20
> On AM335x SoC, this common config space is shared by the other 3=20
> modules (eCAP, eHRPWM, eQEP).
> However, on Davinci platform don't have any common config space.
>=20
> So from driver reusability view, usage of platform_get_resource_byname()=
=20
> is better choice.

I don't quite see how you would be able to reuse the driver in that
case. The driver that you posted uses only one memory region, so the
platform device that you instantiate for the driver to bind to only
gets the one region through the .resource and .num_resources fields.

How is that going to work?

Thierry

--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQDVOAAAoJEN0jrNd/PrOhtkIP/AiQ5IyOdYgDfCkp/i5avmFs
U8GxTUp8q26tN1dp4TJ2LpVR0CeQ6vqnJZf73OfK3qx5sw7bXJE6dJ+1t2qO8Ceu
1A8yY7aLeRAZoereFMLLiccfBd+96x6M1gahmTeIfXt+eeMrC1X7oSXtbZ0Nz0KN
z/pcWJrH4wk1SqwdD3H1Aps2+ZQ7hZrZKFdzYCMOtREoIrYQJ6oQOeVEA+HU46Pk
Q1RB29iPUNuq7H4qk2Gbvt9eLn4Ic58OtTXJMQtWayawlBLvCUqhwmNPNCWlz+Zo
5ddwfSSy9rLB5cJy0EfDhoxFcJbdaPSUoCPf3PbVWuqHABEyTv8jEvwUE0bkXEPH
mhKCUCTZh9ckeaBmXW9XCxRFoQJhWOoo1X6gzjfeQ7R8b/BsyqoKD0E+aLnWOCGU
YDef2K1i4LP8Rdd0YPiJryTWNwdFZkN6ZGGzcxEPvE8S7vqZHJ3xIHwU02zzVDcf
545qE1AMY3VDBTP7IUvVod8nIdzIuz734YWTZDmYcGbnYMrUBG9fbc8BFDjJq1CZ
RIsVSIMX1FMpmYCshoiJ+Gsr+GVgkkWA+6sNWm4g7RrmFryU2wiWdH8BG9TLlq/6
DqpfCXNNUfTDmzBNbIJEu+kBW2p2FpMvG7PFl6j8aj6mOZzFfcqSZoUv60c1LR9g
A6DZBXSiFTV0NkCuv9OC
=Iusr
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--
