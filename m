From: Pavel Machek <pavel@ucw.cz>
Subject: Re: omap4-droid4: voice call support was Re: [PATCHv5,5/5] ARM: dts:
 omap4-droid4: add soundcard
Date: Fri, 30 Mar 2018 19:50:50 +0200
Message-ID: <20180330175050.GA26571@amd>
References: <20180329014507.GM5700@atomide.com>
 <20180329133613.khldv72w3zj63vsk@earth.universe>
 <20180329135904.GN5700@atomide.com>
 <20180329154600.qhels5fqzzg364gj@earth.universe>
 <20180329163716.GA20743@amd>
 <20180329164113.GR5700@atomide.com>
 <20180329184007.GA27688@amd>
 <20180329215612.GS5700@atomide.com>
 <20180330103744.GA17404@amd>
 <a2a7a65c-1794-66c7-0f69-5919d32665fb@wizzup.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a2a7a65c-1794-66c7-0f69-5919d32665fb@wizzup.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Merlijn Wajer <merlijn@wizzup.org>
Cc: Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com, Dan Williams <dcbw@redhat.com>
List-Id: linux-omap@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-03-30 15:07:24, Merlijn Wajer wrote:
> On 30/03/18 12:37, Pavel Machek wrote:
> > On Thu 2018-03-29 14:56:13, Tony Lindgren wrote:
> >> * Pavel Machek <pavel@ucw.cz> [180329 18:41]:
> >>> Thanks. I got call working including outgoing audio: in capture
> >>> settings, right->mic 1, Mic1 + Mic2 in alsamixer -> 100%. But I had
> >>> the other phone muted, so I don't yet know if such call would be of
> >>> usable quality.
> >>
> >> Great, good to hear that :)
> >=20
> > I also got ofonod to work, with rather crazy hacks. But I now have
> > incoming/outgoing calls with GUI :-).
>=20
> Would you mind sharing those hacks - I would like to play around with
> ofonod as well. Maybe I can help with a way forward.

Okay. Here's less hacky version of the hack, but still using AT
commands. You still need to set up udev, as described in the other
mail.

And... it seems I can have a qmi connection, too, but that's topic for
other email.

Good luck,
								Pavel


diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
index 68b89862..3a9f4bc0 100644
--- a/drivers/atmodem/sms.c
+++ b/drivers/atmodem/sms.c
@@ -440,6 +440,8 @@ static void at_cmt_notify(GAtResult *result, gpointer u=
ser_data)
 	if (data->vendor !=3D OFONO_VENDOR_SIMCOM)
 		at_ack_delivery(sms);
=20
+	return;
+
 err:
 	ofono_error("Unable to parse CMT notification");
 }
diff --git a/plugins/udevng.c b/plugins/udevng.c
index ff5d41af..a4b18488 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -233,10 +233,11 @@ static gboolean setup_gobi(struct modem_info *modem)
 		}
 	}
=20
+	DBG("qmi=3D%s net=3D%s mdm=3D%s gps=3D%s diag=3D%s", qmi, net, mdm, gps, =
diag);
+=09
 	if (qmi =3D=3D NULL || mdm =3D=3D NULL || net =3D=3D NULL)
 		return FALSE;
=20
-	DBG("qmi=3D%s net=3D%s mdm=3D%s gps=3D%s diag=3D%s", qmi, net, mdm, gps, =
diag);
=20
 	ofono_modem_set_string(modem->modem, "Device", qmi);
 	ofono_modem_set_string(modem->modem, "Modem", mdm);
@@ -1250,6 +1251,7 @@ static struct {
 	{ "cinterion",	setup_serial_modem	},
 	{ "nokiacdma",	setup_serial_modem	},
 	{ "sim900",	setup_serial_modem	},
+	{ "g1",		setup_serial_modem	},
 	{ "wavecom",	setup_wavecom		},
 	{ "tc65",	setup_tc65		},
 	{ "ehs6",	setup_ehs6		},
@@ -1578,8 +1580,6 @@ static struct {
 	{ "mbm",	"cdc_ether",	"0930"		},
 	{ "mbm",	"cdc_ncm",	"0930"		},
 	{ "hso",	"hso"				},
-	{ "gobi",	"qmi_wwan"			},
-	{ "gobi",	"qcserial"			},
 	{ "sierra",	"qmi_wwan",	"1199"		},
 	{ "sierra",	"qcserial",	"1199"		},
 	{ "sierra",	"sierra"			},
@@ -1602,6 +1602,8 @@ static struct {
 	{ "telit",	"cdc_acm",	"1bc7", "0021"	},
 	{ "telitqmi",	"qmi_wwan",	"1bc7", "1201"	},
 	{ "telitqmi",	"option",	"1bc7", "1201"	},
+	{ "telitqmi",	"qmi_wwan",	"22b8", "2a70"	},
+	{ "telitqmi",	"option",	"22b8", "2a70"	},
 	{ "nokia",	"option",	"0421", "060e"	},
 	{ "nokia",	"option",	"0421", "0623"	},
 	{ "samsung",	"option",	"04e8", "6889"	},
@@ -1717,10 +1719,12 @@ static void check_device(struct udev_device *device)
 			return;
 	}
=20
+#if 0
 	if ((g_str_equal(bus, "usb") =3D=3D TRUE) ||
 			(g_str_equal(bus, "usbmisc") =3D=3D TRUE))
 		check_usb_device(device);
 	else
+#endif
 		add_serial_device(device);
=20
 }
@@ -1749,14 +1753,17 @@ static gboolean create_modem(gpointer key, gpointer=
 value, gpointer user_data)
 		if (g_str_equal(driver_list[i].name, modem->driver) =3D=3D FALSE)
 			continue;
=20
+		DBG("Attempting modem setup, driver %s", modem->driver);
 		if (driver_list[i].setup(modem) =3D=3D TRUE) {
 			ofono_modem_set_string(modem->modem, "SystemPath",
 								syspath);
 			ofono_modem_register(modem->modem);
 			return FALSE;
 		}
+		DBG("Modem setup failed, driver %s", modem->driver);	=09
 	}
=20
+	DBG("Modem setup failed or not in driver_list?");
 	return TRUE;
 }
=20



--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlq+ePoACgkQMOfwapXb+vJKZgCeI0fCULSgCsD0Awxz7p+CVB5m
j1sAnifN/0d4PoPt1B6sFrbGEV3S9tTE
=PmCh
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
