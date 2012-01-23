From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: PM(?) problems on v3.3-rc1 on OMAP3
Date: Mon, 23 Jan 2012 10:25:43 +0200
Message-ID: <1327307143.1916.19.camel@deskari>
References: <1327055619.1921.57.camel@deskari>
	 <alpine.DEB.2.00.1201210042030.28153@utopia.booyaka.com>
	 <1327161427.1863.5.camel@lappy>  <20120122074620.2715ce7f@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-Hb4dJPQDeTVDpzjalhIM"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:58790 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750695Ab2AWIZt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Jan 2012 03:25:49 -0500
Received: by lahg1 with SMTP id g1so263965lah.15
        for <linux-omap@vger.kernel.org>; Mon, 23 Jan 2012 00:25:46 -0800 (PST)
In-Reply-To: <20120122074620.2715ce7f@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, t-kristo@ti.com, linux-omap mailing list <linux-omap@vger.kernel.org>, Joe Woodward <jw@terrafix.co.uk>


--=-Hb4dJPQDeTVDpzjalhIM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2012-01-22 at 07:46 +1100, NeilBrown wrote:
> On Sat, 21 Jan 2012 17:57:07 +0200 Tomi Valkeinen <tomi.valkeinen@ti.com>
> wrote:

> > In this case something is affecting the DSS (clocks? powers?), or the
> > memory, or the process of reading the pixels. I really don't see the MP=
U
> > or IRQs affecting this problem, except indirectly.
>=20
> Which clocks, exactly, are important?
>=20
> I collected some clock.c tracing while dss was repeatedly complaining abo=
ut
> losing SYNC, and notice that omap_96m_fck was being enabled and disabled =
in
> hardware.
> omap_96m_fck is upstream for dss_96m_fck which provides the tv_dac_clk.
>=20
> Could it be this clock turning on and off which causes the problem?

I don't think 96m clock is important. At least I'm testing with plain
DPI, not tv-out. And I think missing 96m clock would just lead to a
missing image on the tv, not sync losts.

For OMAP3 DSS when using DPI the following clocks are important:

DPLL4_ALWON_FCLKOUTM4X2 (i.e. DSS1_ALWON_FCLK) (dss func clock)
DSS_L3_ICLK (to fetch pixels)
DSS_L4_ICLK (to configure dss registers)

I don't think any other clocks are used.

 Tomi


--=-Hb4dJPQDeTVDpzjalhIM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPHRmHAAoJEPo9qoy8lh71tmMP/2QvhLFjexL8JKBNXBYAMJ85
90GmpD2ivrgH11VAq+q0Q5Ci8/+HKfn0PdvU6HkgQJOBRCj/DQ8JqrGrmRxVmGgo
WyzKv+DYajtpqQNp84P2kp6GXsIqRjRT9mo9sPsIAgeHNGltTC0GU2WqQGNq37vC
fnskwUYREdlBXJQxVwJs1G0FT3FPd9STBt0hGeaOUsCLSS9aRJgMMAjV4Rhw+74N
Us/V+Zti1GVt5PZY6v7wiuCbYYEwFX+oU+eYpdx13kUbY5mlvgCApjocSm++4V0p
2USWEkQNinXkdIAaGSKwsa11DX6KDQMVGuV5/wkDMoUTT5YT46gv4XB2r1ZBwpTM
kU1M1Ed18Ui5ASFVv9/u14gK/OWyGK/ewutCvxSXOdEgRMlPcMZfaKZhCvWiA6W+
qQG4srnlCDjbjsugZFjhZ8vXnaNFdhWYWKDWaa0zwe1sDKBOxZV3nWKI6tXUa22p
g0FYXEyTCfQqMwttO0nLLsZaw8SjnRlhQ6eDDnslFAxTOJaWkNpVoi10La213nvG
t2DjfMIz1a7mr5nvA/9339D5Jcw+7dlHHHWt/4rO4AN/Pv9Ymjqbk4T4XZylgP5M
yXlzXy4ltLMhBVzk0sH0GFlak7FXZj2dmVrqZUYJ1v7BZKoD2ydiQGm+2OdnBDnP
aJVBbwZX3BiiGeuKrnMQ
=c7HE
-----END PGP SIGNATURE-----

--=-Hb4dJPQDeTVDpzjalhIM--

