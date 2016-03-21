From: Sebastian Reichel <sre@kernel.org>
Subject: Re: Nokia N900 - audio TPA6130A2 problems
Date: Mon, 21 Mar 2016 02:40:50 +0100
Message-ID: <20160321014050.GA25916@earth>
References: <56EAE8C3.1080301@gmail.com>
 <56EBD96A.8090505@ti.com>
 <1458306829.11841.2.camel@Nokia-N900>
 <20160318133641.GB16747@earth>
 <56EC0676.3000509@gmail.com>
 <20160318150404.GA30829@earth>
 <56ED12B5.9000103@gmail.com>
 <20160320051704.GA12934@earth>
 <56EEFD4F.4030705@gmail.com>
 <20160321000417.GA21902@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160321000417.GA21902@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 21, 2016 at 01:04:18AM +0100, Sebastian Reichel wrote:
> On Sun, Mar 20, 2016 at 09:43:11PM +0200, Ivaylo Dimitrov wrote:
> > On 20.03.2016 07:17, Sebastian Reichel wrote:
> > >On Sat, Mar 19, 2016 at 10:49:57AM +0200, Ivaylo Dimitrov wrote:
> > >>On 18.03.2016 17:04, Sebastian Reichel wrote:
> > >>>On Fri, Mar 18, 2016 at 03:45:26PM +0200, Ivaylo Dimitrov wrote:
> > >>>>On 18.03.2016 15:36, Sebastian Reichel wrote:
> > >>>>Regulator is V28_A, which is always-on, so it is enabled no matter =
what
> > >>>>probe does. Anyway, I added a various delays after regulator_enable=
(), to no
> > >>>>success.
> > >>
> > >>I guess we're getting closer - I put some printks in various function=
s in
> > >>the twl-regulator.c, here is the result:
> > >>
> > >>on power-up:
> > >>
> > >>[    2.378601] twl4030ldo_get_voltage_sel VMMC2 vsel 0x00000008
> > >>[    2.384948] twl4030reg_enable VMMC2 grp 0x00000020
> > >>[    2.408416] twl4030ldo_get_voltage_sel VMMC2 vsel 0x00000008
> > >>[    7.196685] twl4030reg_is_enabled VMMC2 state 0x0000002e
> > >>[    7.202819] twl4030reg_is_enabled VMMC2 state 0x0000002e
> > >>[    7.209777] twl4030reg_is_enabled VMMC2 state 0x0000002e
> > >>[    7.215728] twl4030reg_is_enabled VMMC2 state 0x0000002e
> > >>[    7.223205] twl4030reg_is_enabled VMMC2 state 0x0000002e
> > >
> > >Ok, so normal power up results in running VMMC2 (always-on works),
> > >but voltage is not configured correctly. 2.6V is default according
> > >to the TRM. I think this is a "bug" in the regulator framework. It
> > >should setup the minimum allowed voltage before enabling the
> > >always-on regulator.
> > >
> >=20
> > /sys/kernel/debug/regulator/regulator_summary shows 2850mV for V28_A, s=
o I
> > would remove the quotes. Also, always-on is because if V28_A regulator =
is
> > turned off, there is a leakage through tlv320aic34 VIO. BTW one of the
> > things I did while trying to find the problem, was to remove that alway=
s-on
> > property from the DTS - it didn't help.
>=20
> Right thinking about it, the voltage must also be configured for the
> non always-on cases. So it's not a problem with the regulator
> framework, but with twl-regulator's probe function, that should take
> care of this.
>=20
> > >In case of the tpa6130a2/tpa6140a2 driver it may also be nice to add
> > >something like this to the driver (Vdd may be between 2.5V and 5.5V
> > >according to both datasheets):
> > >
> > >if (regulator_can_change_voltage(data->supply))
> > >     regulator_set_voltage(data->supply, 2500000, 5500000);
> > >
> >=20
> > and add DT property for that voltage range, as max output power and
> > harmonics depend on the supply voltage.
>=20
> I guess that's 2nd step.
>=20
> > >>after restart from stock kernel:
> > >>
> > >>[    2.388610] twl4030ldo_get_voltage_sel VMMC2 vsel 0x0000000a
> > >>[    2.394958] twl4030reg_enable VMMC2 grp 0x00000028
> > >
> > >I had a quick glance at this. I think stock kernel put VMMC2
> > >into sleep mode. Mainline kernel does not expect sleep mode
> > >being set and does not disable it.
> > >
> >=20
> > Well, one would think that kernel should not have expectations on what =
would
> > be the state of the hardware by the time it takes control over it, but =
setup
> > everything needed instead.
>=20
> I thought it's obvious, that this is not the desired behaviour :)
>=20
> > >>[    2.418426] twl4030ldo_get_voltage_sel VMMC2 vsel 0x0000000a
> > >>[    7.186645] twl4030reg_is_enabled VMMC2 state 0x00000020
> > >>[    7.192718] twl4030reg_is_enabled VMMC2 state 0x00000020
> > >>[    7.199615] twl4030reg_is_enabled VMMC2 state 0x00000020
> > >>[    7.205535] twl4030reg_is_enabled VMMC2 state 0x00000020
> > >>[    7.212951] twl4030reg_is_enabled VMMC2 state 0x00000020
> > >>
> > >>I don't see twl4030ldo_set_voltage_sel() for VMMC2(V28_A) regulator, =
though
> > >>there are calls for VMMC1 and VAUX3.
> > >
> > >I guess that's because the voltage is only configured if at least
> > >one regulator consumer requests anything specific.
> > >
> >=20
> > But then the board DTS is simply ignored. Doesn't look good :)
> >
> > >>So, it seems to me that V28_A is not enabled or correctly set-up
> > >>and all devices connected to it does not function. And it looks
> > >>like even after power-on VMMC2 is not correctly set-up - it is
> > >>supposed to have voltage of 2.85V (10) but kernel leaves it to
> > >>2.60V (8). However my twl-fu ends here so any help is appreciated.
> > >
> > >So in case of reboot from stock kernel voltage is already configured
> > >to 2.8V, but it does not work, because of the sleep mode.
> > >
> >=20
> > Yeah, that sleep is pretty clear, I was rather asking - "any idea how t=
o fix
> > that?". Or it is someone else expected to fix it?
>=20
> You may have noticed, that I included Mark and Liam. I hope they
> can give some feedback. I think there are two bugs:
>=20
> 1. twl_probe() should setup a default voltage based on DT
>    information.

I just had a look at the regulator core code. I think the voltage
should be set automatically during regulator_register():

regulator_register()
-> set_machine_constraints()
--> machine_constraints_voltage()
---> _regulator_do_set_voltage()
----> _regulator_call_set_voltage()
-----> ops->set_voltage()

Looks like this currently only works automatically, if DT specifies
min-voltage =3D max-voltage. Adding this to twl-regulator's probe
function before devm_regulator_register()) should enable the voltage
setting:

init_data->constraints.apply_uV =3D 1;

I hope Mark can tell us why this only done, when the voltage is fixed.

> 2. if regulator is in sleep mode, regulator enable should
>    disable sleep mode.

Stroke that. It should be disabled in probe of course, since
it can be modified later using regulator_set_mode(). Actually
it is already supported by adding this to the omap3-n900.dts:

&vmmc2 {
    regulator-initial-mode =3D <2>;
};

Ivo, Can you try if this fixes your problems with tpa6130a2 after
rebooting from Nokia kernel?

-- Sebastian

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJW71EfAAoJENju1/PIO/qac1cP/iIQwxznNQr2cq3VMJBb3ZpE
7/N+2rNDwi13602EkE7ajjc0azzx32osE8QTt2sKDgEmkPq00SMUStZP8+8pSlVo
cLUtji7Bk9DiygthMiLG5H/sxf86OorkXSmeaVq0sRpud46+Ty29HFA9QDVbVz88
dNF7dTjRbY3uaFq39wEHqtVZ1CLZXYKK9wEmM742voknQp2dKnZgmRNrPT2BT2WB
eC15XvHfexvfzRhb3pehOoGiE62EbHLZDOc9kEoCRzxJD75cbOHv7o9Qkn4HpiHl
KJaz0IFxazdH+sVjkYbzICfc3JWWeC3R5xEjr3f85JWbHdCXJznStzoVxj2OEpHV
RwbFT6zjqtwc/v3GbyDZK0dfDkcbx2dUWtdr7Z765Qcl8pGHQbsgiJ0sasJkKwhT
IlnRAiR4GzRTrjcZRlXTQ4IOjmRK1a16zkuwFnpe9O9g2pB75BZgqHdDdtTPQfhq
pydaXagv+LEq02c10LR1nKwiZi19c13BsKrhh/ttjmv9WT9LAc/KE5Y4PJVzdPA6
UMtQQcRILmHSCGj3KW1fd6511Ddqs5TMdbZIsODzZTzZc1maVQXh1gnLNUnqS9W5
U4MoSwn8zwI0U40Jov4ApT0n5cuVLcXLfR3Wd+WvCFZMam5uG6Gir8EGOgp51PkM
UC1YcDsBI14fRY71RTGz
=KZ4q
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
