From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v9 0/8] Generic PHY Framework
Date: Tue, 9 Jul 2013 14:44:16 +0300
Message-ID: <20130709114416.GL5552@arwen.pp.htv.fi>
References: <1372247257-30186-1-git-send-email-kishon@ti.com>
 <780E789C2E067A4BB8F69D0BB9EC4F253E975B5E@DBDE04.ent.ti.com>
 <51D3F773.9000209@ti.com> <20130703132038.GI15056@arwen.pp.htv.fi>
 <780E789C2E067A4BB8F69D0BB9EC4F253E975D6E@DBDE04.ent.ti.com>
 <51D54694.20203@ti.com> <20130704101216.GD4830@arwen.pp.htv.fi>
 <780E789C2E067A4BB8F69D0BB9EC4F253E9764D5@DBDE04.ent.ti.com>
 <51DAADD1.3060302@ti.com>
 <780E789C2E067A4BB8F69D0BB9EC4F253E976575@DBDE04.ent.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8823732262316004296=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <780E789C2E067A4BB8F69D0BB9EC4F253E976575@DBDE04.ent.ti.com>
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

--===============8823732262316004296==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/ZYM6PqDyfNytx60"
Content-Disposition: inline

--/ZYM6PqDyfNytx60
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 09, 2013 at 04:23:29AM +0200, Patel, Satish wrote:
> > > We have two options over here
> > >
> > > Option 1:
> > >
> > > Defining generic api to which can be mapped over multiple phys
> > > For smartcard case, I have can thought of following mapping with new
> > > generic apis as suggested.
> > >
> > > Smartcard_poweron -> power_on
> > > Smartcard_powerdown -> power_off
> > > Smartcard_set_voltage -> phy_set_voltage
> > > Smartcard_activate_card -> phy_activate_slot
> > > Smartcard_deactivate_card -> phy_deactivate_slot
> >=20
> > how is activate/deactivate different from poweron/poweroff in this
> > use case?
>=20
> power on/off normal power sequence. While activate/de-activate will be=20
> called during card transaction.

why can't you implement activate/deactivate with suspend/resume ?

> Brief on how it works:
> - when system start, execute power on for phy
> - smartcard controller and phy is connected through i2c, clock lines and=
=20
> i/o lines
> - clock will be supplied by controller to phy to get data sync on i/o lin=
es

fair enough.

> Operation:
>
> Once the card gets inserted into the slot, user application can
> initiate activate sequence anytime, it is not mandatory that
> activation has to be called Immediately. It all depends whether other
> connections ( network, printer) are proper.  User application can do
> some checks and then dynamically activate the card

The card or the phy ? Who actually activates ? Is the activation
handling part of the PHY or part of the smartcard controller ?

> There are 2 sequence of activation - normal activation and warm reset.
> If first fails then warm reset should be executed, if card does not
> response to both then deactivation will be carried out

ret =3D phy_resume(phy);
if (ret =3D=3D -EINVAL) { /* perhaps there's a better error code */
	ret =3D phy_reset(phy);
	if (ret)
		phy_suspend(phy);
}

????

> - For activation there are some timing parameters ( called ATR -
> Answer to reset timings) Has to be set to the phy

does that change in runtime or is it something which is set during probe
and never touched again ?

> - on activation card will respond with some initial characters (ATR),
> which will be verified by application, in case of error user
> application will de-activate the card not the phy module
>=20
> - After activation, use application initiate normal tx/rx
>=20
> - Once tx/rx is done, it will initiate deactivation of card not the
> phy module.

then that has nothing to do with the PHY framework, right ?

> > > Smartcard_set_c4/c8/rst/io -> phy_set_pin
> >=20
> > Whats should be exactly done here? Looks to me like it should be
> > part of init. Does these pin settings need to be changed dynamically?
>=20
> These are all phy pins which will be physically come in contact with
> smart card When inserted. In case of synchronous card, these pins will
> be toggled manually by s/w bit bang algorithm

is that a requirement or just something that everybody does ?

In any case, you can hide that under some gpio calls, or something
similar.

> > Why? Is it like the detection of an external event? Then the PHY
> > driver should use *extcon* for event detection and passing.
> >
>=20
> Smartcard controller need a way to ready isr status ( like card presence,
> Card inserted in to which slot, removed from which slot ) to maintain its
> Internal state machine.

register an interrupt handler with devm_request_threaded_irq(), what's
the problem ?

> > > Smartcard_get_version -> phy_get_version
> >=20
> > Again why? Why would the smartcard need the version of the PHY?
> >=20
>=20
> Can be omitted. This is for the test suite reference.

if it's for testsuite, it sounds like something that should be done
through userland and, as such, should be implemented by a set of debugfs
files which expose the necessary information. That has nothing to do
with the PHY framework.

--=20
balbi

--/ZYM6PqDyfNytx60
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR2/eQAAoJEIaOsuA1yqREdBgP/RjkSFigzXGse8Vc4XDQG7i6
b7zrnmC8XyEaSQ3r//k7FsrHwwmP1B/OOuQJ+Am+lpIA/lg0JodidKaZ3MV2Jh+D
cQY4pmcfFjKSPo6hEQs6lxHGY1P9VSqbSIcQ1F4Bv+3DiLoyjzyIfy+Yw/RzeVcH
Bw7wYKxuccNosyqksusyBqgnih4WfKs+Oc4MinSD5VK0nPeeY7rNS6eFFSv9xwwS
+Lbp/rcaUklwYfzQOov+lX6OUwaWeK0hSisejrswrvkHN3gETftvBboe2Po4D6Lb
6qcQIJ6Y11imNgZR/B+KpDUTwMXgu+lnwRiMN3Jv16HniEm7k9EklgQq6Fb0vF2R
7FbeFacFrmuug6aOKz5NhTe+yTp2FoDKNNwDuor6P48Lyl8p6asng01e9q03y2iS
X8H9MKoyIxaVP58zg4X+4QpsdHAY5FOdVl+glRkddX59XKQAw0aLr0VbYNW76T2d
u61aw1kPcdc/8OVuflONMy8CleXnxs3BxDw0YtkgDYyTKmZ2mnbNbBtNzkSn2syv
t+PUOyrwsWmGsMgUAiQiGfQ/Rmm0W4wYGELfJctAOQkWdPf1Nrse8b3WUZTg7XuF
GAs69xtR8Yn/wy0JkNd3XVDH8obk5/sk6Q/OmtB7qdZJXbc+nkj0ZWJBynlTC8Iz
Yct1fHyAnTO9qi4UQhMo
=fGUK
-----END PGP SIGNATURE-----

--/ZYM6PqDyfNytx60--


--===============8823732262316004296==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8823732262316004296==--
