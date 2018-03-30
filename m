From: Pavel Machek <pavel@ucw.cz>
Subject: Re: omap4-droid4: voice call support was Re: [PATCHv5,
 5/5] ARM: dts: omap4-droid4: add soundcard
Date: Fri, 30 Mar 2018 17:34:06 +0200
Message-ID: <20180330153406.GA20218@amd>
References: <20180329133613.khldv72w3zj63vsk@earth.universe>
 <20180329135904.GN5700@atomide.com>
 <20180329154600.qhels5fqzzg364gj@earth.universe>
 <20180329163716.GA20743@amd> <20180329164113.GR5700@atomide.com>
 <20180329184007.GA27688@amd> <20180329215612.GS5700@atomide.com>
 <20180330103744.GA17404@amd>
 <a2a7a65c-1794-66c7-0f69-5919d32665fb@wizzup.org>
 <20180330152227.GU5700@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4891076626480120002=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180330152227.GU5700@atomide.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, kernel@collabora.com, Dan Williams <dcbw@redhat.com>, linux-kernel@vger.kernel.org, Merlijn Wajer <merlijn@wizzup.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org


--===============4891076626480120002==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > >> Great, good to hear that :)
> > >=20
> > > I also got ofonod to work, with rather crazy hacks. But I now have
> > > incoming/outgoing calls with GUI :-).
> >=20
> > Would you mind sharing those hacks - I would like to play around with
> > ofonod as well. Maybe I can help with a way forward.
>=20
> Yeah that would be fun to play with :)

Ok, I thought I should clean them up first, but hey...

sudo emacs /etc/udev/rules.d/55-modem.rules
KERNEL=3D=3D"ttyUSB4", ENV{OFONO_DRIVER}=3D"g1"

sudo udevadm trigger

And now, the crazy hack follows. Note I'm using AT interface -- which
is probably not good idea.

Anyway, network/signal strength is detected, and calls seem to work.

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
diff --git a/plugins/g1.c b/plugins/g1.c
index d915a565..dd4e735d 100644
--- a/plugins/g1.c
+++ b/plugins/g1.c
@@ -60,7 +60,8 @@ static void g1_debug(const char *str, void *user_data)
 /* Detect hardware, and initialize if found */
 static int g1_probe(struct ofono_modem *modem)
 {
-	DBG("");
+	DBG("probing G1");
+	DBG("probing G1 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
=20
 	return 0;
 }
@@ -97,14 +98,21 @@ static int g1_enable(struct ofono_modem *modem)
=20
 	DBG("");
=20
+	DBG("enabling G1 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
+=09
 	device =3D ofono_modem_get_string(modem, "Device");
-	if (device =3D=3D NULL)
-		return -EINVAL;
+	//	if (device =3D=3D NULL)
+	//	return -EINVAL;
+	device =3D "/dev/ttyUSB4";
+
+	DBG("");
=20
 	channel =3D g_at_tty_open(device, NULL);
 	if (channel =3D=3D NULL)
 		return -EIO;
=20
+	DBG("");=09
+
 	syntax =3D g_at_syntax_new_gsm_permissive();
 	chat =3D g_at_chat_new(channel, syntax);
 	g_io_channel_unref(channel);
@@ -116,11 +124,14 @@ static int g1_enable(struct ofono_modem *modem)
 	if (getenv("OFONO_AT_DEBUG"))
 		g_at_chat_set_debug(chat, g1_debug, "");
=20
+		DBG("");
 	ofono_modem_set_data(modem, chat);
=20
+	DBG("");=09
 	/* ensure modem is in a known state; verbose on, echo/quiet off */
 	g_at_chat_send(chat, "ATE0Q0V1", NULL, NULL, NULL, NULL);
=20
+		DBG("");
 	/* power up modem */
 	g_at_chat_send(chat, "AT+CFUN=3D1", NULL, cfun_set_on_cb, modem, NULL);
=20
@@ -191,18 +202,56 @@ static void g1_post_sim(struct ofono_modem *modem)
 		ofono_message_waiting_register(mw);
 }
=20
+static void g1_post_online(struct ofono_modem *modem)
+{
+  DBG();
+}
+
+static void set_online_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
+{
+	struct ofono_modem *modem =3D user_data;
+	GAtChat *chat =3D ofono_modem_get_data(modem);
+
+	DBG("");
+
+	g_at_chat_unref(chat);
+	ofono_modem_set_data(modem, NULL);
+=09
+	//	if (ok)
+	//	ofono_modem_set_online(modem, TRUE);
+}
+
+static void g1_set_online(struct ofono_modem *modem, ofono_bool_t online,
+				ofono_modem_online_cb_t cb, void *user_data)
+{
+  	GAtChat *chat =3D ofono_modem_get_data(modem);
+	char const *command =3D online ? "AT+CFUN=3D1" : "AT+CFUN=3D4";
+
+	DBG("modem %p %s", modem, online ? "online" : "offline");
+
+	if (g_at_chat_send(chat, command, NULL,
+					set_online_cb, modem, NULL) > 0)
+		return;
+
+	//CALLBACK_WITH_FAILURE(cb, cbd->data);
+
+}
+
 static struct ofono_modem_driver g1_driver =3D {
 	.name		=3D "g1",
 	.probe		=3D g1_probe,
 	.remove		=3D g1_remove,
 	.enable		=3D g1_enable,
 	.disable	=3D g1_disable,
+	//	.set_online     =3D g1_set_online,
 	.pre_sim	=3D g1_pre_sim,
 	.post_sim	=3D g1_post_sim,
+	.post_online	=3D g1_post_online,
 };
=20
 static int g1_init(void)
 {
+  DBG("g1_init!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!=
\n");
 	return ofono_modem_driver_register(&g1_driver);
 }
=20
diff --git a/plugins/udevng.c b/plugins/udevng.c
index ff5d41af..3e0cdf81 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1250,6 +1250,7 @@ static struct {
 	{ "cinterion",	setup_serial_modem	},
 	{ "nokiacdma",	setup_serial_modem	},
 	{ "sim900",	setup_serial_modem	},
+	{ "g1",		setup_serial_modem	},
 	{ "wavecom",	setup_wavecom		},
 	{ "tc65",	setup_tc65		},
 	{ "ehs6",	setup_ehs6		},
@@ -1407,7 +1408,7 @@ static void add_serial_device(struct udev_device *dev)
=20
 	mdev =3D get_serial_modem_device(dev);
 	if (!mdev) {
-		DBG("Device is missing required OFONO_DRIVER property");
+	  //DBG("Device %s %s is missing required OFONO_DRIVER property", udev_de=
vice_get_devpath(mdev), udev_device_get_syspath(mdev));
 		return;
 	}
=20
@@ -1419,6 +1420,9 @@ static void add_serial_device(struct udev_device *dev)
=20
 	devnode =3D udev_device_get_devnode(dev);
=20
+       	DBG("Got OFONO_DRIVER!!!! driver %s path %s\n", driver, devpath);
+
+
 	if (!syspath || !devpath)
 		return;
=20
@@ -1578,8 +1582,6 @@ static struct {
 	{ "mbm",	"cdc_ether",	"0930"		},
 	{ "mbm",	"cdc_ncm",	"0930"		},
 	{ "hso",	"hso"				},
-	{ "gobi",	"qmi_wwan"			},
-	{ "gobi",	"qcserial"			},
 	{ "sierra",	"qmi_wwan",	"1199"		},
 	{ "sierra",	"qcserial",	"1199"		},
 	{ "sierra",	"sierra"			},
@@ -1602,6 +1604,8 @@ static struct {
 	{ "telit",	"cdc_acm",	"1bc7", "0021"	},
 	{ "telitqmi",	"qmi_wwan",	"1bc7", "1201"	},
 	{ "telitqmi",	"option",	"1bc7", "1201"	},
+	{ "telitqmi",	"qmi_wwan",	"22b8", "2a70"	},
+	{ "telitqmi",	"option",	"22b8", "2a70"	},
 	{ "nokia",	"option",	"0421", "060e"	},
 	{ "nokia",	"option",	"0421", "0623"	},
 	{ "samsung",	"option",	"04e8", "6889"	},
@@ -1717,10 +1721,12 @@ static void check_device(struct udev_device *device)
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
@@ -1746,17 +1752,20 @@ static gboolean create_modem(gpointer key, gpointer=
 value, gpointer user_data)
 		return TRUE;
=20
 	for (i =3D 0; driver_list[i].name; i++) {
+	  DBG("comparing %s %s", driver_list[i].name, modem->driver);
 		if (g_str_equal(driver_list[i].name, modem->driver) =3D=3D FALSE)
 			continue;
=20
-		if (driver_list[i].setup(modem) =3D=3D TRUE) {
+		/* if (driver_list[i].setup(modem) =3D=3D TRUE) */ {
 			ofono_modem_set_string(modem->modem, "SystemPath",
 								syspath);
 			ofono_modem_register(modem->modem);
+			DBG("create modem is okay?");
 			return FALSE;
 		}
 	}
=20
+	DBG("create modem is maybe not okay?");
 	return TRUE;
 }
=20
@@ -1796,6 +1805,7 @@ static void enumerate_devices(struct udev *context)
 	udev_enumerate_unref(enumerate);
=20
 	g_hash_table_foreach_remove(modem_list, create_modem, NULL);
+	DBG("Enumerate devices ok?");
 }
=20
 static struct udev *udev_ctx;
@@ -1811,6 +1821,8 @@ static gboolean check_modem_list(gpointer user_data)
=20
 	g_hash_table_foreach_remove(modem_list, create_modem, NULL);
=20
+	DBG("Check modem list ok?");=09
+
 	return FALSE;
 }
=20
@@ -1820,6 +1832,8 @@ static gboolean udev_event(GIOChannel *channel, GIOCo=
ndition cond,
 	struct udev_device *device;
 	const char *action;
=20
+	DBG("udev event");
+
 	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL)) {
 		ofono_warn("Error with udev monitor channel");
 		udev_watch =3D 0;
@@ -1838,11 +1852,14 @@ static gboolean udev_event(GIOChannel *channel, GIO=
Condition cond,
 		if (udev_delay > 0)
 			g_source_remove(udev_delay);
=20
+		DBG("udev event add -> check");	=09
 		check_device(device);
=20
 		udev_delay =3D g_timeout_add_seconds(1, check_modem_list, NULL);
-	} else if (g_str_equal(action, "remove") =3D=3D TRUE)
+	} else if (g_str_equal(action, "remove") =3D=3D TRUE) {
+	  DBG("udev event remove -> remove");
 		remove_device(device);
+	}
=20
 	udev_device_unref(device);
=20
@@ -1892,8 +1909,10 @@ static int detect_init(void)
 		return -EIO;
 	}
=20
+	ofono_warn("detect_init...");
 	modem_list =3D g_hash_table_new_full(g_str_hash, g_str_equal,
 						NULL, destroy_modem);
+	ofono_warn("detect_init 2...");=09
=20
 	udev_monitor_filter_add_match_subsystem_devtype(udev_mon, "tty", NULL);
 	udev_monitor_filter_add_match_subsystem_devtype(udev_mon, "usb", NULL);
diff --git a/src/modem.c b/src/modem.c
index 0cee861f..d8dde772 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -603,12 +603,14 @@ static gboolean modem_has_sim(struct ofono_modem *mod=
em)
=20
 static gboolean modem_is_always_online(struct ofono_modem *modem)
 {
+  DBG();
 	if (modem->driver->set_online =3D=3D NULL)
 		return TRUE;
=20
 	if (ofono_modem_get_boolean(modem, "AlwaysOnline") =3D=3D TRUE)
 		return TRUE;
=20
+	DBG("not always");
 	return FALSE;
 }
=20
@@ -720,8 +722,10 @@ static void sim_state_watch(enum ofono_sim_state new_s=
tate, void *user)
 		modem_change_state(modem, MODEM_STATE_OFFLINE);
=20
 		/* Modem is always online, proceed to online state. */
-		if (modem_is_always_online(modem) =3D=3D TRUE)
+		if (modem_is_always_online(modem) =3D=3D TRUE) {
 			set_online(modem, TRUE);
+			modem->online =3D TRUE;
+		}
=20
 		if (modem->online =3D=3D TRUE)
 			modem_change_state(modem, MODEM_STATE_ONLINE);
@@ -1882,13 +1886,17 @@ struct ofono_modem *ofono_modem_create(const char *=
name, const char *type)
 	else
 		snprintf(path, sizeof(path), "/%s", name);
=20
-	if (!dbus_validate_path(path, NULL))
+	if (!dbus_validate_path(path, NULL)) {
+	  DBG("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!bad dbus path");
 		return NULL;
+	}
=20
 	modem =3D g_try_new0(struct ofono_modem, 1);
=20
-	if (modem =3D=3D NULL)
+	if (modem =3D=3D NULL) {
+	  DBG("!!!out of memory?!");
 		return modem;
+	}
=20
 	modem->path =3D g_strdup(path);
 	modem->driver_type =3D g_strdup(type);
@@ -1900,6 +1908,7 @@ struct ofono_modem *ofono_modem_create(const char *na=
me, const char *type)
 	if (name =3D=3D NULL)
 		next_modem_id +=3D 1;
=20
+	DBG("Created new modem, path %s", path);
 	return modem;
 }
=20
diff --git a/src/network.c b/src/network.c
index ae3175d4..700183c0 100644
--- a/src/network.c
+++ b/src/network.c
@@ -980,6 +980,7 @@ static DBusMessage *network_scan(DBusConnection *conn,
 {
 	struct ofono_netreg *netreg =3D data;
=20
+	DBG();
 	if (netreg->mode =3D=3D NETWORK_REGISTRATION_MODE_AUTO_ONLY)
 		return __ofono_error_access_denied(msg);
=20
@@ -991,6 +992,7 @@ static DBusMessage *network_scan(DBusConnection *conn,
=20
 	netreg->pending =3D dbus_message_ref(msg);
=20
+	DBG();
 	netreg->driver->list_operators(netreg, operator_list_callback, netreg);
=20
 	return NULL;
diff --git a/src/voicecall.c b/src/voicecall.c
index e4f6a4c0..2c637e58 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -1492,6 +1492,7 @@ static int voicecall_dial(struct ofono_voicecall *vc,=
 const char *number,
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
 	struct ofono_phone_number ph;
=20
+	DBG("");
 	if (g_slist_length(vc->call_list) >=3D MAX_VOICE_CALLS)
 		return -EPERM;
=20





--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlq+WO4ACgkQMOfwapXb+vJ8JQCePv0X9M40idncjhGQbKhwaG3N
y9IAn3c4hZjmOKkjWioFxMst97xqDGUc
=fr4m
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--

--===============4891076626480120002==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4891076626480120002==--
