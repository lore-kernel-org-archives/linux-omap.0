From: Sebastian Reichel <sre@ring0.de>
Subject: Re: N900 board code in 3.14
Date: Sat, 16 Nov 2013 15:50:33 +0000
Message-ID: <20131116155031.GA5104@earth.universe>
References: <1384562167-14725-1-git-send-email-tony@atomide.com>
 <20131116120508.GA22335@earth.universe>
 <20131116141226.GD10317@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:36813 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751837Ab3KPPus (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 16 Nov 2013 10:50:48 -0500
Content-Disposition: inline
In-Reply-To: <20131116141226.GD10317@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2013 at 06:12:26AM -0800, Tony Lindgren wrote:
> [...]
> >  b) I could not get the 32GB eMMC working. For me the chip is not found
> >     and I don't know how to debug it.
>=20
> OK the eMMC issue might be related to the control module PBIAS
> register support missing. If so, that should be fixable with the
> auxdata until we have a minimal control module device driver to
> deal with the PBIAS and expose those features as regulators to
> the omap-hsmmc driver.

I wasn't aware, that PBIAS register support is missing for DT
boot. The existing board code uses a 2.8-3.0V regulator for mmc1,
so missing PBIAS is probably the problem.

> > [...]
> >=20
> > My suggestion would be:
> >  1. Find a better workaround for omapdss to acquire the SDI
> >     regulator. My current hack is obviously not acceptable.
> >  2. Load the panel driver via DT as seen above and reference
> >     the omapdss interface with something like the above
> >     "ti,dss-source".
>=20
> To me it seems that we should be able to add minimal panel entries to DT
> if we stick to existing standard bindings. Then the timings etc can be
> set up based on the compatible flag. So I would leave out the properties
> for ti,sdi-datapairs and ti,dss-source for now, and just set those in
> the driver based on the sony,acx565akm compatible flag. Or maybe it should
> be sony,acx565akm-n900 if there's some board specific configuration info.

So we add reset-gpio and label to the DT data (they are panel
specific and independent of omapdss) and just hardcode "dsi.0"
with 2 data lanes into the driver? That sounds fine for me.

If neither Tomi nor anybody else has better ideas I will cook a
patch for that. I'm not sure how to setup the vdds_sdi regulator for
omapdss, though. Is there an example for a legacy driver using a DT
regulator available?

> [...]

-- Sebastian

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCAAGBQJSh5RHAAoJENju1/PIO/qaEAIP/jX4h7aPw/2MVxQkqAAFEycc
SI8NqH3zWsww/V0p9GLG+8KN9h9hNmqfMj9smQ39K/1182lmQ2mnB0b1OYReg87R
YnNKrheKzd1kPvdPh+n/s19pA8IMDZCE4z81pHe1R05zzHLJTvVbYb4/yt6JCFm2
rjtS8lUUGc4nLouic1SkQ3L3uRydWDTGDBrKwuyjoqO8cCsIA3H0qNL62k1TAO9B
Bq/44Ox2YxdqocWHG7gBMJJWklVk3zqsCOgzQy2PY02lBGny1oODZaHjFLB2Lm6U
S3G+0Ydd0a4MJPpLbnKhbzZVZw2VL/xvpE1cyglouTaPJXUNWp4muFIhqbkvuCE7
sBh1nwVm8baY8Y/FNO9P93a0hza5kT2IVWf2lwJDivapsmNleguAJUOSROBKj5m1
TheN0V7g6MdVd3ZooKeLtGXz7yhEc7E8mw+gAv1dCa5Du6Kc/SrZ3WVNL96sEULY
pQ+JnRnQvdxokvKZJZBjElnuxgu3EQ+w/iILWshFhzTfsgEapLAUExvEAdXPfgS+
k8JfAu5lD1jde7FjvGwNeXyZlGwM4uw8QAng7LUszalmx5ERM0r73L2uFtXLiyz/
i9pzcXjje/ztycB+YM8QzSB0kWC8cFNrQNEHULtMfxQ9XVsr7HOYtQgAN19+mVHb
23el3iudGjdMmK+DkGsU
=hWnJ
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
