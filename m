From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v9 0/8] Generic PHY Framework
Date: Tue, 9 Jul 2013 20:34:29 +0300
Message-ID: <20130709173429.GE10776@arwen.pp.htv.fi>
References: <51D3F773.9000209@ti.com> <20130703132038.GI15056@arwen.pp.htv.fi>
 <780E789C2E067A4BB8F69D0BB9EC4F253E975D6E@DBDE04.ent.ti.com>
 <51D54694.20203@ti.com> <20130704101216.GD4830@arwen.pp.htv.fi>
 <780E789C2E067A4BB8F69D0BB9EC4F253E9764D5@DBDE04.ent.ti.com>
 <51DAADD1.3060302@ti.com>
 <780E789C2E067A4BB8F69D0BB9EC4F253E976575@DBDE04.ent.ti.com>
 <20130709114416.GL5552@arwen.pp.htv.fi>
 <780E789C2E067A4BB8F69D0BB9EC4F253E97670D@DBDE04.ent.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8143874215676963164=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <780E789C2E067A4BB8F69D0BB9EC4F253E97670D@DBDE04.ent.ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Patel, Satish" <satish.patel@ti.com>
Cc: "mchehab@redhat.com" <mchehab@redhat.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Nori, Sekhar" <nsekhar@ti.com>, "Mankad, Maulik Ojas" <maulik@ti.com>, "swarren@nvidia.com" <swarren@nvidia.com>, "ABRAHAM,
 KISHON VIJAY" <kishon@ti.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "cesarb@cesarb.net" <cesarb@cesarb.net>, "Cherian,
 George" <george.cherian@ti.com>, "arnd@arndb.de" <arnd@arndb.de>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "Nayak, Rajendra" <rnayak@ti.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "sylvester.nawrocki@gmail.com" <sylvester.nawrocki@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--===============8143874215676963164==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uCPdOCrL+PnN2Vxy"
Content-Disposition: inline

--uCPdOCrL+PnN2Vxy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 09, 2013 at 02:33:58PM +0200, Patel, Satish wrote:
> > > Operation:
> > >
> > > Once the card gets inserted into the slot, user application can
> > > initiate activate sequence anytime, it is not mandatory that
> > > activation has to be called Immediately. It all depends whether
> > other
> > > connections ( network, printer) are proper.  User application can do
> > > some checks and then dynamically activate the card
> >=20
> > The card or the phy ? Who actually activates ? Is the activation
> > handling part of the PHY or part of the smartcard controller ?
> >=20
>=20
> It=E2=80=99s a activation of smart card which is inserted into the phy sl=
ot.=20
> Smart card activation will by done phy but initiated by user application
> Handling of activation should be done at both the side - controller as we=
ll
> As phy. Phy will raise certain signals and check timeout while activation
> , while controller will store data coming from smart card to FIFO. Its
> Controller which will give command to phy to initiate activation sequence=
 when it
> is ready.=20
>=20
> Which means, both controller and phy has role to play while activation.
> Also it is applicable while deactivation.

right, so when the smartcard device is opened, you want to powerup the
PHY, powerup the smartcard controller and get things going, which means
that all your activation logic can, and should, be hidden by
phy_power_on() and phy_power_off()

Perhaps you also want to delay phy_init() and phy_shutdown() to that
very time, which would mean that we wouldn't even need
phy_power_{on,off}() calls whatsoever.

> > > There are 2 sequence of activation - normal activation and warm
> > reset.
> > > If first fails then warm reset should be executed, if card does not
> > > response to both then deactivation will be carried out
> >=20
> > ret =3D phy_resume(phy);
> > if (ret =3D=3D -EINVAL) { /* perhaps there's a better error code */
> > 	ret =3D phy_reset(phy);
> > 	if (ret)
> > 		phy_suspend(phy);
> > }
> >
>=20
> Its not like this. There are the cases, when during normal activation
> card respond With some characters, but they might not be valid or
> error prone - This check will be done by user application as only
> application knows how to decode characters as per protocol.

sure, and if the characters are invalid, the application needs to tell
the kernel, perhaps it would be enough to send and IOCTL or, even
easier, close the device and reopen it.

> It there is any error in characters/timeout paratmeters, user
> application will ask to initiate Warm reset.

and for that we can use an IOCTL which is implemented by smart card
layer. I mean, I'm assuming the smartcard would be seen as a char dev by
userland so it would be something like this:

ret =3D read(fd, buf, SIZE);
if (ret < 0)
	boom();

ret =3D process_buffer(buf, ret);
if (ret =3D=3D -EINVAL) { /* we have received invalid characters */
	ret =3D ioctl(fd, IOCTL_SMARTCARD_WARM_RESET);
	if (ret < 0)
		handle_error();
}

in kernel space we would have an ioctl handler like so:

static int smart_card_ioctl(struct file *fd, unsigned code, usigned long v)
{
	struct smart_card *sc =3D fd->private_data;
	unsigned long flags;
	int ret;

	spin_lock_irqsave(&sc->lock, flags);
	switch (v)
	case SMART_CARD_WARM_RESET:
		ret =3D phy_shutdown(sc->phy);
		if (ret < 0)
			boom();

		ret =3D smart_card_reset(sc);
		if (ret < 0)
			boom();

		ret =3D phy_init(sc->phy);
		if (ret < 0)
			boom();
		break;
	[ ... ]
	}

	spin_unlock_irqrestore(&sc->lock, flags);

	return ret;
}

see, we don't need to add a bunch of stuff in the PHY framework, because
you shouldn't expose the PHY directly to userland. You *must* have an
abstraction to userland with an in-kernel usage of the PHY layer.

> > > - on activation card will respond with some initial characters
> > (ATR),
> > > which will be verified by application, in case of error user
> > > application will de-activate the card not the phy module
> > >
> > > - After activation, use application initiate normal tx/rx
> > >
> > > - Once tx/rx is done, it will initiate deactivation of card not the
> > > phy module.
> >=20
> > then that has nothing to do with the PHY framework, right ?
>=20
> But all such sequence will be initiated by PHY by raising certain
> signals and only controller can give the push when to start.

sure, that's fair. But you don't need to expose every single detail of
the PHY. You need to use abstractions to make accesses to the PHY easy
to maintain. See the example above.

> > > > > Smartcard_set_c4/c8/rst/io -> phy_set_pin
> > > >
> > > > Whats should be exactly done here? Looks to me like it should be
> > > > part of init. Does these pin settings need to be changed
> > dynamically?
> > >
> > > These are all phy pins which will be physically come in contact with
> > > smart card When inserted. In case of synchronous card, these pins
> > will
> > > be toggled manually by s/w bit bang algorithm
> >=20
> > is that a requirement or just something that everybody does ?
> >
>=20
> Its requirement for synchronous card. At present there is no open driver
> Which does this thing.

alright, so you need to tell the PHY in which mode it should work and
the PHY driver needs to be smart enough to choose proper callbacks
depending on the mode.

> > In any case, you can hide that under some gpio calls, or something
> > similar.
>=20
> Can't be done using GPIO as pin can be toggled only which i2c read/write
> to the phy.

so ? look at the numerous I2C GPIO expanders we have in the kernel ;-)

> > > > > Smartcard_get_version -> phy_get_version
> > > >
> > > > Again why? Why would the smartcard need the version of the PHY?
> > > >
> > >
> > > Can be omitted. This is for the test suite reference.
> >=20
> > if it's for testsuite, it sounds like something that should be done
> > through userland and, as such, should be implemented by a set of
> > debugfs
> > files which expose the necessary information. That has nothing to do
> > with the PHY framework.
> >=20
> Agree.. can be omitted.
>=20
>=20
> I am ok to give internal webex presentation (TI team) to brief=20
> on phy and smart card controller interface.

let's try to cut down on internal agreements and let the community help
defining a proper way to handle the PHY :-)

Still, if you want to point me and Kishon (privately) to some internal
documentation, we can certainly read through it :-)

cheers

--=20
balbi

--uCPdOCrL+PnN2Vxy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR3EmlAAoJEIaOsuA1yqRE+CcP/jaatw9OdYSNmyR2dRK3RX65
00/84x8VseE077m0OvE3E5TDdglxJWDHQH+E/ggTmYGpYiYlzw/e6tLwJqZQpu8P
q6QM+Cz4TABCHw7HSHllsSmxevdQkgrTVw5u7iAxQfLoA6rMx2AHrH+hKgjM54IK
kQi/ot6SjtJl7aEoUxqt0fcPzq1AKmJDgGsyEFzU06y1CdG4YOPzIxf6njECQh9h
0TI/kD2kQeArCxQNRz+kpWNa9XtQ3AfUtQm20JRo9ufcEnotzzwBMJKuF3+VrQSG
WMI2ZWUhhZ4g5m8VNfRU/8X3+V4k11pAm6o+wPIEMy05TakFEuzV02Kfr1gyCwxY
Ctb1Zn/ECyiykEXTkIOh7rn0HTnyZOqiDg8PGJDTtN2rTdS57lKyvbMwVFFTx04k
Xb728j+xTW9bh+rc9JkVlpqJYefnoMeW9bdrvyGb0SQwf2ygko8USjNZ5Bcr9nlp
wyXJ0VTjBFv0ULTzUezkjAWVdsCgVyr5AzSCGJffrLYG9a4tDw2wcYFcCxzy+4ku
5zCGylSQ2Mso+QnWK0elTZIOQVOIjDp+1gTRuPyrau/RCXTdXBJDD4uK68o4K7KJ
BGnI8bDAirzuJmJZHDmCAbWN7rCzC+eGapZa7eUe+//5zT8Nw7klp6a2lAl+L89C
tFeDhp5/CM/6vD0vm5sR
=Hwcx
-----END PGP SIGNATURE-----

--uCPdOCrL+PnN2Vxy--


--===============8143874215676963164==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8143874215676963164==--
