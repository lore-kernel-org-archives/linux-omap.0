From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2+: fix dpll round_rate() to actually round
Date: Tue, 29 Apr 2014 10:51:11 -0500
Message-ID: <20140429155111.GC633@saruman.home>
References: <1389944699-27962-1-git-send-email-tomi.valkeinen@ti.com>
 <1389944699-27962-3-git-send-email-tomi.valkeinen@ti.com>
 <20140424182914.GD4659@saruman.home>
 <20140424184457.GH22987@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6zdv2QT/q3FMhpsV"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60571 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757804AbaD2Pvm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Apr 2014 11:51:42 -0400
Content-Disposition: inline
In-Reply-To: <20140424184457.GH22987@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Mike Turquette <mturquette@linaro.org>, Paul Walmsley <paul@pwsan.com>

--6zdv2QT/q3FMhpsV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2014 at 11:44:58AM -0700, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [140424 11:29]:
> > Hi,
> >=20
> > On Fri, Jan 17, 2014 at 09:44:59AM +0200, Tomi Valkeinen wrote:
> > > omap2_dpll_round_rate() doesn't actually round the given rate, even if
> > > the name and the description so hints. Instead it only tries to find =
an
> > > exact rate match, or if that fails, return ~0 as an error.
> > >=20
> > > What this basically means is that the user of the clock needs to know
> > > what rates the dpll can support, which obviously isn't right.
> > >=20
> > > This patch adds a simple method of rounding: during the iteration, the
> > > code keeps track of the closest rate match. If no exact match is foun=
d,
> > > the closest is returned.
> > >=20
> > > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> >=20
> > Tony, looks like this patch was lost. Are you taking it during the -rc ?
>=20
> Would like to hear what Paul thinks of the updated patch suggested
> by Tomi first.

Paul, any chance you can review Tomi's v2 ? It'd be very nice to get
display working on BBB.

cheers

--=20
balbi

--6zdv2QT/q3FMhpsV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTX8pvAAoJEIaOsuA1yqREvX0QAKfL3tKMgi25AIE1AEWn90Y+
0Q0CSP55aUVPtDIX27fO23MtDZm4+YfzGJ4fiYA0QlCnEO/VC/mEOFfYh/fdr7m8
+lFptzUa9Sej/1sBwhF4D0zLpZ4wxUr7ZJoiYN06EcXTaGkp7UWdWvBXZH0SZYdG
s8Qwxv57pM7/2WtpVMEL++440UB7fVvOoJHuXtXyPDtWBkssNZuVRTDoaXesykH9
zzosOVWAge+pkeIKuTfcpUiueWtrd/UKq1e9BlGD4JkYzL+3Zn6J8hrVygDQGnnt
W99MNjptwbOkeDzFg4JjwwkGS6tZJOc8ZuPOZWPpCxoymV+mZin2a6bpd1R/Ct2H
kBKmhjF82Gf/0cMT4sxeW/elmwMLHrrhtXl07LDpiwJ/LwgjXsvQ1AwjaehRCBcb
BXmLOjPtfZuH/7HnVmbVwd+TKuIrV0Jq9pusnpQCZS9UKqe5LSaD2+D6eh+t1cee
TvO5GcOeHTSZRUtDd73P7q2+KKoJrYMIDmrClfYOxOsrwKl3eM1OgmqveQs5a4AL
OcmuUSXS/la0LaFpq58yaw0qzhvVJqFTCFrbW0s17Z4sBYO+f8E+iLoSWV+F+Aqj
AS8lz1WeLCa6BZ8pdC8o9CkH1D9EBiaqXEVoRLp7cUn6uDuPv+BX55XW/uRmvk1N
/GMEqWxrcVJjcivifoVn
=SoLc
-----END PGP SIGNATURE-----

--6zdv2QT/q3FMhpsV--
