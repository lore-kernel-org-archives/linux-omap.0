From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/PATCH-v4.2-rc6 4/5] arm: omap2: timer: simplify
 omap4_local_timer_init()
Date: Wed, 12 Aug 2015 09:53:28 -0500
Message-ID: <20150812145328.GC13884@saruman.tx.rr.com>
References: <1439242911-715-1-git-send-email-balbi@ti.com>
 <1439242911-715-5-git-send-email-balbi@ti.com>
 <20150812071424.GO4215@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6391985382216144006=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150812071424.GO4215@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

--===============6391985382216144006==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9l24NVCWtSuIVIod"
Content-Disposition: inline

--9l24NVCWtSuIVIod
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2015 at 12:14:24AM -0700, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [150810 14:44]:
> > all users of omap4_local_timer_init() are already
> > DT-only, so we can remove the check for having
> > DTB or not.
> >=20
> > While at that, fix a typo in comment.
>=20
> We already have d1dabab2841d ("ARM: OMAP2+: Clean up
> omap4_local_timer_init") in Linux next reviewed-by you :)

hehe, I had forgotten about that sorry. I'll rebase this on today's
next and resend the series. I'll also test $subject without the other
patches.

--=20
balbi

--9l24NVCWtSuIVIod
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVy13oAAoJEIaOsuA1yqRE4y4QAI4ny5hG8nTmPKtgs139BAV5
APRcyQ/ysR+YZC7ltSNfYul+QC6XVOo+0+OCSVM4E2+RO5gjvg4xAolKex2MJPaU
6ix0++xOIYcSH0osPX98qHJtv9e+zihRD+hxnFreUZKu0lBVpu8ERb+kvAnMpMmK
12jNqey/V+xaBJLbmaOuT8P40ulidmLtrnU6vSUmjSR8rHjmuTG14Q5pH6UVUJ1z
OBNOp+Qzvplj25n2waPBHODbSnUIRupX1ced9k+aU5oxCS/XJGqqjem+iw7Axmoj
T8zrXHSysuaqgrVXim9DgT2tZm3598G1YO0NU+Eh0+q+OOuzLp9eoViblH9IOlvL
KCcpPz4FFIGHz0qx3tA6nWI5GPmZ7bX9rQKpGx61ydypp5txH7j2sur+2mtEA6gj
PfBIXm2iNDSwDP41aTDNgqU3uYlyEiH9T4hxRyxknqHwBuZaTu2bY9ggFeBJ0cMq
RxgG7aT5wrJi1Uk7e4hnE6Z4Bd17FrryBtPpDaWca4E0cEwVrLhXzOZqMAvfdrKF
VveevHvy0mzFVHJVEf4vNfQvLP7YiSnPkpGthAG6p+OTI/qJ6ru2aklxndUpt7ZD
h+O/kO7tBsmgEYoK/21HUoWVnH4H7TD61xSG2K+hmr1T/2GYiXb16nFMZ1UgO0fM
1jIyOcmfaTqZu5PokJt5
=aVkk
-----END PGP SIGNATURE-----

--9l24NVCWtSuIVIod--


--===============6391985382216144006==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6391985382216144006==--
