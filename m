From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding names, pre-calibration, flipping and rotation
Date: Sat, 18 Feb 2017 12:33:42 +0100
Message-ID: <61F3C580-4BF2-4EE6-9DEC-FB8634434EC0@goldelico.com>
References: <cover.1482936802.git.hns@goldelico.com> <9830dd21e6425e3a866fac6ed4cc73ddd58b719f.1482936802.git.hns@goldelico.com> <20170128193342.GB38136@dtor-ws> <1F6355E1-A5E3-41A6-908F-619A15581BEF@goldelico.com> <20170217204041.GE13050@dtor-ws> <20170218091526.GC8937@amd>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_60AA252B-712D-4C70-B92B-95CD25A02105"; protocol="application/pgp-signature"; micalg=pgp-sha256
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170218091526.GC8937@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Michael Welling <mwelling@ieee.org>, =?utf-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Igor Grinberg <grinberg@compulab.co.il>, "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, Alexander Stein <alexander.stein@systec-electronic.com>, Eric Engestrom <eric@engestrom.ch>, Hans de Goede <hdegoede@redhat.com>, Benjamin Tissoires <benjam>
List-Id: linux-omap@vger.kernel.org


--Apple-Mail=_60AA252B-712D-4C70-B92B-95CD25A02105
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi Pavel,

> Am 18.02.2017 um 10:15 schrieb Pavel Machek <pavel@ucw.cz>:
>=20
> Hi!
>=20
>>> Well, there is some historic confusion wether this driver reports =
resistance
>>> or pressure.
>>>=20
>>> The unpatched tsc2007 driver does it wrong (please test!) and we fix =
it on
>>> the fly (because a separate patch is much more complex than doing it =
right
>>> immediately).
>>>=20
>>> This ti,report-resistance property is a means to get the old (wrong) =
meaning back
>>> in case someone urgently needs it and can't fix the user-space =
workaround which
>>> he must be using.
>>>=20
>>>=20
>>> AFAIK there is no mainline board using the DT except ours (and the =
upcoming
>>> OMAP5-Pyra), so we shouldn't care too much. If you prefer, you can =
remove this
>>> compatibility property. We don't need it for our devices.
>=20
> N900 is mainline and uses DT.

Yes, but it does not use the tsc2007 and will not be influenced at all =
by this patch.

>=20
>>> That the function name is wrong is a second issue and this double =
negation might
>>> confuse a litte.
>>>=20
>>> Please test on a real device if the patched driver reports pressure =
now (unless
>>> ti,report-resistance is specified).
>>=20
>> I unfortunately can not test this driver as I do not have the =
hardware.
>> So all my observations are from code and data sheets.
>>=20
>> That said, what is the values emitted as ABS_PRESSURE when finger is =
not
>> touching the device, barely touching the device, or pressing firmly?
>> It seems that between TSC2007, TSC2004, TSC2005, and ADS7846, we have
>> confusion as to what is being reported.
>>=20
>> I am adding a few more folks to the CC so we can try and soft this =
out.
>> Sebastian, Pali, Pavel, any input here?
>=20
> X work ok on N900. Nikolaus wrote rather long email, but I'm not what
> the meaning is and what is supposed to be broken there.

IMHO it is broken that you have to do a subtle calibration step in =
user-space
and repeat it for different GUI toolkits.

>=20
> I do this on X startup:
>=20
> xinput --set-prop --type=3Dfloat "TSC200X touchscreen" "Coordinate =
Transformation Matrix"  1.10 0.00 -0.05  0.00 1.18 -0.10  0.00 0.00 1.00
> xinput --set-prop --type=3Dint "TSC200X touchscreen" "Evdev Axis =
Inversion" 0 1
> xinput --set-prop --type=3Dfloat "TSC2005 touchscreen" "Coordinate =
Transformation Matrix"  1\
> .10 0.00 -0.05  0.00 1.18 -0.10  0.00 0.00 1.00
> xinput --set-prop --type=3Dint "TSC2005 touchscreen" "Evdev Axis =
Inversion" 0 1

Wouldn't  it be nice to get rid of this completely, because the =
DT/kernel knows these
factors? Especially since they are well defined by the hardware?

>=20
> And I agree that kernel should _not_ attempt rescaling itself, as it
> would lose precision.

With an almost 1:1 mapping you won't loose precision.

> Providing default calibration info is ok.

IMHO it is missing one step of automation.

BR and thanks,
Nikolaus


--Apple-Mail=_60AA252B-712D-4C70-B92B-95CD25A02105
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYqDEWAAoJEIl79TGLgAm6BxkQALa1Vx5764oOSK/GGmnIDGR9
2X4lsqQQTO1zAC/0iF/Klgp0n1nL92ygdv/6xh7inwFq5OSp/gEzTf0rdWgSRmk2
pMPicns5hmOXudPOE1tNKCBpXJY3XtjPk3NhN84gF2i3+bKD5JqYa2Zo1PBTA4Wz
xG9d+NBCmoxXLmejA6ot7gYCld2Mg/ZPjnKkdCi/BCPp0ZyIK9LWB1YspqcTNRYn
fhJHqaBqKZgEFeCWeesLrAMhOvDBDpHfXKT2ckbrSu0LNdOrXZUOuUzqO+SFPtHu
Buob2uun8bbz324e6AafWuw6RDoLIg7dDaEBFJP99QVXbewN1dmqSUm0/JZJDlpm
5xy1QuLe5QYxqk2MwJwBOqxpC0tZgPAPrNoqotPP5rygJ90QLOkTDkTGhZt+JEtH
n+YrPBvuG31cjcUWzf/VmO13sNnU0CrKkcNbrDPUt+X3uIFYhue+MSgx7kkQnd71
aXDXL3450KVFZ+0xrIrk292dkC1s8AU5CyXDHuMFX3YIp1mgi+g3xJSPA8S8AlLq
DsfDpbMedFR+/ZWMImstg91UCab7q7wyhK6N+s4c6soeQfMtK6vW/0t9FqrHsf44
AHfhz0SBRhqyzDLsPpTZGRBnCMKIShdHUlH56wD3rdHgfPLuLillV4q+BfxZjBcv
gvTXRiWDhhAf/jDQo7iK
=VezH
-----END PGP SIGNATURE-----

--Apple-Mail=_60AA252B-712D-4C70-B92B-95CD25A02105--
