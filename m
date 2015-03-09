From: Sebastian Reichel <sre@kernel.org>
Subject: Re: twl4030_charger: need changes to get probed?
Date: Mon, 9 Mar 2015 12:14:10 +0100
Message-ID: <20150309111410.GB3914@earth>
References: <20150224043341.4243.23291.stgit@notabene.brown>
 <20150224043352.4243.11227.stgit@notabene.brown>
 <20150302210926.GP13270@amd>
 <20150305173350.50502b95@notabene.brown>
 <20150306212417.GA24169@amd>
 <20150307210102.GL5233@earth>
 <20150309110653.7532613c@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1LKvkjL3sHcu1TtY"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150309110653.7532613c@notabene.brown>
Sender: linux-pm-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, GTA04 owners <gta04-owner@goldelico.com>, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 09, 2015 at 11:06:53AM +1100, NeilBrown wrote:
> On Sat, 7 Mar 2015 22:01:02 +0100 Sebastian Reichel <sre@debian.org> wrot=
e:
> > platform_driver_probe() does not support deferred probing.
> >=20
> > Neil, can you take this patch into your series for the next round?
>=20
> I could, but I do wonder if it is the right thing to do.
>=20
> Shouldn't we fix platform_driver_probe() to support deferred probing.

well most drivers use platform_driver_register anyways. Other
subsystems, like e.g. i2c have converted all drivers already.
In drivers/power/ there are only three drivers using
platform_driver_probe:

drivers/power/avs/smartreflex.c - ok here
drivers/power/reset/brcmstb-reboot.c - looks ok, too
drivers/power/twl4030_charger.c - should probably be converted

> As I understand it, it refused to retry a probe if there is an error, and=
 the
> comments suggest that such retrying is avoided because it would be a waste
> of time:
>=20
> 	/*
> 	 * Prevent driver from requesting probe deferral to avoid further
> 	 * futile probe attempts.
> 	 */
>=20
> In this case, it isn't futile.

All drivers would benefit of being probed again if they returned
EPROBEDEFER, but their probe function can't be called again if
they use driver_platform_probe, since the probe function will be
unloaded when it should be called again. Apart from that the
=2Eprobe function pointer is not set. Thus trying to probe the
driver again at a later point is "a waste of time" and "futile",
since it will definitely fail.

> Earlier there is a comment saying:
>=20
>  * Use this instead of platform_driver_register() when you know the device
>  * is not hotpluggable and has already been registered, and you want to
>  * remove its run-once probe() infrastructure from memory after the driver
>  * has bound to the device.
>=20
> I presume all this applies.  I assume that the only problem is a probe-or=
der
> thing.  So maybe we should fix platform_driver_probe() to do the right th=
ing
> with -EPROBEDEFER??
>=20
> Trouble is, I really don't understand the  point or mechanism for
> platform_driver_probe(), so I cannot suggest anything.
> But I have been annoyed before that platform_driver_probe doesn't cope wi=
th
> EPROBEDEFER, so I would like it fixed.

platform_driver_probe is not about probe-order, but about not having
the probe function in memory once the driver is loaded. So the probe
function cannot be called again. If you don't want this use
platform_driver_register, as most drivers actually do.

I guess we should add some coccinelle scripts for detection of
potentially broken drivers (e.g. everything requesting gpios/pinctrl
together with platform_driver_register).

-- Sebastian

--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU/YB/AAoJENju1/PIO/qaW88P/ig40368TO4XO7Tk+tN9f8t8
FTmjysb5RVkWZApJwFE/chA9/jkUvH1xhcM1HkHR0LmI2wfn5irGHBfOp4UHBtRT
+XHxR17aDLO2QNQ4tBbtelswWPgvsMB+LnixhmhPjFVZVVIlqCUkLVMFN508ZRmX
1XXST5Ksr8yjjFvRyoDSN6p+EVjnt0hq07+2WSS2IjjRjhTKf2bmpWUCqd7hPxxg
wUsywuyyHBFo4QXpmdDT3qwX07sGv4bJbTB848vXKEjJtquCxuuMus7JMevlMtbm
5gfaiEiZzxvj12Zvm/wTVUq2M1m91r7YzhptC4uDacGf1aLri45HrjA2BysOh2SA
S7sTDpk0hedYEO+nGez3qsc3MNyLzRNBA6qNAlkFETfP0h8TMSvv1cGeGWhbYL5/
95YuMEpjOOQsnKy3sUAUYRZduAJW/Xpz8n8JLrMOZOG7l3740xBMHzyx/BsLtNro
hIcmutXZxVtYyrsemNTty7zFEefCoFOO6bz8o95jZKyVt1/CXpAwjL7c5YY6YtcO
xURoGfLc4ZgRCb9j1mZJFJ5fygVgdNmK7yauFKEVr7wlillNkv7cFyoIIbepPpLP
dpr6/xreEMh8izu/AWF2FO987FZxT8BBhgwXBrd+DSoFp5DEfegEA7ZVGWnmKBSL
icNJtGDaA+G7HRDi3JXB
=OpG1
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--
