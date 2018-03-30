From: Pavel Machek <pavel@ucw.cz>
Subject: Re: omap4-droid4: voice call support was Re: [PATCHv5,
 5/5] ARM: dts: omap4-droid4: add soundcard
Date: Fri, 30 Mar 2018 20:01:51 +0200
Message-ID: <20180330180151.GA27494@amd>
References: <20180329133613.khldv72w3zj63vsk@earth.universe>
 <20180329135904.GN5700@atomide.com>
 <20180329154600.qhels5fqzzg364gj@earth.universe>
 <20180329163716.GA20743@amd> <20180329164113.GR5700@atomide.com>
 <20180329184007.GA27688@amd> <20180329215612.GS5700@atomide.com>
 <20180330103744.GA17404@amd>
 <a2a7a65c-1794-66c7-0f69-5919d32665fb@wizzup.org>
 <20180330175050.GA26571@amd>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2790295862458686231=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180330175050.GA26571@amd>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Merlijn Wajer <merlijn@wizzup.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, kernel@collabora.com, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Dan Williams <dcbw@redhat.com>, Mark Brown <broonie@kernel.org>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org


--===============2790295862458686231==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-03-30 19:50:50, Pavel Machek wrote:
> On Fri 2018-03-30 15:07:24, Merlijn Wajer wrote:
> > On 30/03/18 12:37, Pavel Machek wrote:
> > > On Thu 2018-03-29 14:56:13, Tony Lindgren wrote:
> > >> * Pavel Machek <pavel@ucw.cz> [180329 18:41]:
> > >>> Thanks. I got call working including outgoing audio: in capture
> > >>> settings, right->mic 1, Mic1 + Mic2 in alsamixer -> 100%. But I had
> > >>> the other phone muted, so I don't yet know if such call would be of
> > >>> usable quality.
> > >>
> > >> Great, good to hear that :)
> > >=20
> > > I also got ofonod to work, with rather crazy hacks. But I now have
> > > incoming/outgoing calls with GUI :-).
> >=20
> > Would you mind sharing those hacks - I would like to play around with
> > ofonod as well. Maybe I can help with a way forward.
>=20
> Okay. Here's less hacky version of the hack, but still using AT
> commands. You still need to set up udev, as described in the other
> mail.
>=20
> And... it seems I can have a qmi connection, too, but that's topic for
> other email.

This, applied on top of previous patch, gives me some kind of qmi
connection, AFAICT. I can enable/online a modem, but nothing else
works.

LocationReporting is advertised but does not work. dial-number does
not work either. But from list-modems, it looks like some kind of
communication works...
								Pavel

user@devuan:/my/ofono/test$ sudo python2 ./list-modems=20
[ /gobi_0 ]
    SystemPath =3D /sys/devices/platform/44000000.ocp/4a064000.usbhshost/4a=
064800.ohci/usb2/2-1
    Features =3D sim gps=20
    Emergency =3D 0
    Powered =3D 1
    Lockdown =3D 0
    Interfaces =3D org.ofono.SimManager org.ofono.LocationReporting org.ofo=
no.VoiceCallManager=20
    Online =3D 1
    Model =3D 196
    Revision =3D M6600A-SCAUHSZ-3.1.3310T  1  [Jun 09 2011 17:00:00]
    Type =3D hardware
    Serial =3D 809DE736
    Manufacturer =3D QUALCOMM INCORPORATED
    [ org.ofono.SimManager ]
        Present =3D 0
    [ org.ofono.LocationReporting ]
        Type =3D nmea
        Enabled =3D 0
    [ org.ofono.VoiceCallManager ]
        EmergencyNumbers =3D 08 000 999 110 112 911 118 119=20

user@devuan:/my/ofono/test$=20




diff --git a/doc/location-reporting-api.txt b/doc/location-reporting-api.txt
index 21e346d4..ff0a35dc 100644
--- a/doc/location-reporting-api.txt
+++ b/doc/location-reporting-api.txt
@@ -13,7 +13,7 @@ Methods		dict GetProperties()
 		filedescriptor Request()
=20
 			Asks to turn ON the NMEA stream and supplies the
-			gps device file descriptor. The external cliend should
+			gps device file descriptor. The external client should
 			use the file descriptor to receive the NMEA data.
=20
 			Possible Errors: [service].Error.InProgress
diff --git a/plugins/udevng.c b/plugins/udevng.c
index a4b18488..1c6a6679 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -234,9 +234,10 @@ static gboolean setup_gobi(struct modem_info *modem)
 	}
=20
 	DBG("qmi=3D%s net=3D%s mdm=3D%s gps=3D%s diag=3D%s", qmi, net, mdm, gps, =
diag);
-=09
+#if 0=09
 	if (qmi =3D=3D NULL || mdm =3D=3D NULL || net =3D=3D NULL)
 		return FALSE;
+#endif
=20
=20
 	ofono_modem_set_string(modem->modem, "Device", qmi);
@@ -1251,7 +1252,7 @@ static struct {
 	{ "cinterion",	setup_serial_modem	},
 	{ "nokiacdma",	setup_serial_modem	},
 	{ "sim900",	setup_serial_modem	},
-	{ "g1",		setup_serial_modem	},
+	//	{ "g1",		setup_serial_modem	},
 	{ "wavecom",	setup_wavecom		},
 	{ "tc65",	setup_tc65		},
 	{ "ehs6",	setup_ehs6		},
@@ -1602,8 +1603,8 @@ static struct {
 	{ "telit",	"cdc_acm",	"1bc7", "0021"	},
 	{ "telitqmi",	"qmi_wwan",	"1bc7", "1201"	},
 	{ "telitqmi",	"option",	"1bc7", "1201"	},
-	{ "telitqmi",	"qmi_wwan",	"22b8", "2a70"	},
-	{ "telitqmi",	"option",	"22b8", "2a70"	},
+	{ "gobi",	"qmi_wwan",	"22b8", "2a70"	},
+	{ "gobi",	"option",	"22b8", "2a70"	},
 	{ "nokia",	"option",	"0421", "060e"	},
 	{ "nokia",	"option",	"0421", "0623"	},
 	{ "samsung",	"option",	"04e8", "6889"	},
@@ -1719,7 +1720,7 @@ static void check_device(struct udev_device *device)
 			return;
 	}
=20
-#if 0
+#if 1
 	if ((g_str_equal(bus, "usb") =3D=3D TRUE) ||
 			(g_str_equal(bus, "usbmisc") =3D=3D TRUE))
 		check_usb_device(device);


									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlq+e48ACgkQMOfwapXb+vJD1gCgxNvt0ofMvzAYh/uqSmUDyQrX
/bYAn0SgUaES+d4ejF2SWAuPL8ZF9pSk
=ErPL
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--

--===============2790295862458686231==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2790295862458686231==--
