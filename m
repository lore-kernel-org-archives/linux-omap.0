From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCHv4] phy: mapphone-mdm6600: Add USB PHY driver for MDM6600
 on Droid 4
Date: Thu, 29 Mar 2018 21:44:12 +0200
Message-ID: <20180329194411.GD27688@amd>
References: <20180309023750.108942-1-tony@atomide.com>
 <20180322135553.GA27648@amd>
 <20180322164633.GF5799@atomide.com>
 <20180322192843.GA17189@amd>
 <a88b0c0c06a6977d8f0c329690f5335b5fb5ab36.camel@redhat.com>
 <20180323105455.GB21644@amd>
 <20180323113521.45va72bhzis6ym6m@earth.universe>
 <20180323201343.GC23658@amd>
 <bd79e802944f16b844c1850572928d93f3f2c4b2.camel@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="tEFtbjk+mNEviIIX"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <bd79e802944f16b844c1850572928d93f3f2c4b2.camel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Williams <dcbw@redhat.com>, ofono@ofono.org
Cc: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-omap@vger.kernel.org


--tEFtbjk+mNEviIIX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Does ofonod work for you? I could not get that one to work...
>=20
> Because it's looking for a Gobi modem but the MDM6600 isn't one and
> doesn't expose that layout (and doesn't really need to anyway).  I
> don't think ofono has a generic QMI driver, so you'd either need to for
> ce it to use the telitqmi or quectelqmi drivers, or write your own
> generic QMI one.

You are right, it is detected as gobi now:

user@devuan:/my/ofono$ sudo python2 test/list-modems
[ /gobi_0 ]
    SystemPath =3D
    /sys/devices/platform/44000000.ocp/4a064000.usbhshost/4a064800.ohci/usb=
2/2-1
 Features =3D
 Emergency =3D 0
 Powered =3D 0
 Lockdown =3D 0
 Interfaces =3D
 Online =3D 0
 Type =3D hardware

=2E..and nothing works.

commit db9b292f9290b97c87a8d4b4836af4763c06a39c
Author: Bassem Boubaker <bassem.boubaker@actia.fr>
Date:   Mon Mar 19 17:57:31 2018 +0100

I tried this:

diff --git a/plugins/udevng.c b/plugins/udevng.c
index ff5d41af..6b103254 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1578,8 +1578,6 @@ static struct {
 	{ "mbm",	"cdc_ether",	"0930"		},
 	{ "mbm",	"cdc_ncm",	"0930"		},
 	{ "hso",	"hso"				},
-	{ "gobi",	"qmi_wwan"			},
-	{ "gobi",	"qcserial"			},
 	{ "sierra",	"qmi_wwan",	"1199"		},
 	{ "sierra",	"qcserial",	"1199"		},
 	{ "sierra",	"sierra"			},
@@ -1602,6 +1600,8 @@ static struct {
 	{ "telit",	"cdc_acm",	"1bc7", "0021"	},
 	{ "telitqmi",	"qmi_wwan",	"1bc7", "1201"	},
 	{ "telitqmi",	"option",	"1bc7", "1201"	},
+	{ "telitqmi",	"qmi_wwan",	"22b8", "2a70"	},
+	{ "telitqmi",	"option",	"22b8", "2a70"	},
 	{ "nokia",	"option",	"0421", "060e"	},
 	{ "nokia",	"option",	"0421", "0623"	},
 	{ "samsung",	"option",	"04e8", "6889"	},

But no luck:

ofonod[15879]: plugins/udevng.c:create_modem()
/sys/devices/platform/44000000.ocp/4a064000.usbhshost/4a064800.ohci/usb2/2-1
ofonod[15879]: plugins/udevng.c:create_modem() driver=3Dtelitqmi
ofonod[15879]: src/modem.c:ofono_modem_create() name: (null), type:
telitqmi
ofonod[15879]: plugins/udevng.c:setup_telitqmi()
/sys/devices/platform/44000000.ocp/4a064000.usbhshost/4a064800.ohci/usb2/2-1
ofonod[15879]: plugins/udevng.c:setup_telitqmi() /dev/cdc-wdm0
255/251/255 05 (null) usbmisc
ofonod[15879]: plugins/udevng.c:setup_telitqmi() wwan0 255/251/255 05
(null) net
ofonod[15879]: plugins/udevng.c:setup_telitqmi() /dev/cdc-wdm1
255/251/255 06 (null) usbmisc
ofonod[15879]: plugins/udevng.c:setup_telitqmi() wwan1 255/251/255 06
(null) net
ofonod[15879]: plugins/udevng.c:setup_telitqmi() /dev/cdc-wdm2
255/251/255 07 (null) usbmisc
ofonod[15879]: plugins/udevng.c:setup_telitqmi() wwan2 255/251/255 07
(null) net
ofonod[15879]: plugins/udevng.c:setup_telitqmi() /dev/cdc-wdm3
255/251/255 08 (null) usbmisc
ofonod[15879]: plugins/udevng.c:setup_telitqmi() wwan3 255/251/255 08
(null) net
ofonod[15879]: plugins/udevng.c:destroy_modem()
/sys/devices/platform/44000000.ocp/4a064000.usbhshost/4a064800.ohci/usb2/2-1
ofonod[15879]: src/modem.c:ofono_modem_remove() 0x596480
ofonod[15879]: plugins/udevng.c:destroy_modem() /dev/cdc-wdm0
ofonod[15879]: plugins/udevng.c:destroy_modem() wwan0
ofonod[15879]: plugins/udevng.c:destroy_modem() /dev/cdc-wdm1
ofonod[15879]: plugins/udevng.c:destroy_modem() wwan1
ofonod[15879]: plugins/udevng.c:destroy_modem() /dev/cdc-wdm2
ofonod[15879]: plugins/udevng.c:destroy_modem() wwan2
ofonod[15879]: plugins/udevng.c:destroy_modem() /dev/cdc-wdm3
ofonod[15879]: plugins/udevng.c:destroy_modem() wwan3
ofonod[15879]: plugins/upower.c:upower_connect() upower connect
ofonod[15879]: plugins/hfp_hf_bluez5.c:connect_handler() Registering
External Profile handler ...

With quectelqmi result was similar.

I know there are AT commands available at /dev/ttyUSB4. Is there easy
way to make ofonod connect to that?

Thanks,
								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--tEFtbjk+mNEviIIX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlq9QgsACgkQMOfwapXb+vIYRwCfaMPX3tG2WfokQSGnBgAuPcdh
GMQAoMEtLEciA7AIAasTmqdxmd/lV3Id
=B5XZ
-----END PGP SIGNATURE-----

--tEFtbjk+mNEviIIX--
