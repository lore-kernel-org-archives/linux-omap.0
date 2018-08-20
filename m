From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4] pwm: pwm-omap-dmtimer: return -EPROBE_DEFER if no
 dmtimer platform data
Date: Mon, 20 Aug 2018 11:25:36 +0200
Message-ID: <20180820092536.GA8242@ulmo>
References: <20180801141729.2840-1-drivshin@awxrd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4816942555559470808=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180801141729.2840-1-drivshin@awxrd.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: David Rivshin <drivshin@awxrd.com>
Cc: linux-pwm@vger.kernel.org, Ladislav Michl <ladis@linux-mips.org>, Neil Armstrong <narmstrong@baylibre.com>, Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>, Andreas Kemnade <andreas@kemnade.info>, Pavel Machek <pavel@ucw.cz>, "H. Nikolaus Schaller" <hns@goldelico.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============4816942555559470808==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 01, 2018 at 10:17:29AM -0400, David Rivshin wrote:
> From: David Rivshin <DRivshin@allworx.com>
>=20
> If a pwm-omap-dmtimer is probed before the dmtimer it uses, the platform
> data won't be set yet.
>=20
> Fixes: ac30751df953 ("ARM: OMAP: pdata-quirks: Remove unused timer pdata")
> Cc: <stable@vger.kernel.org> # 4.17+
> Signed-off-by: David Rivshin <drivshin@allworx.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Tested-by: Pavel Machek <pavel@ucw.cz>
> Acked-by: Ladislav Michl <ladis@linux-mips.org>
> Tested-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> Changes in v4:
> * Added Ladislav's Acked-by [2]
> * Added Andreas's Tested-by [3]
> Changes in v3:
> * Changed dev_info to dev_dbg
> Changes in v2:
> * Added Pavel's Acked-by/Tested-by [1]
>=20
> [1] https://lkml.org/lkml/2018/7/16/346
> [2] https://www.spinics.net/lists/arm-kernel/msg668768.html
> [3] https://www.spinics.net/lists/arm-kernel/msg669302.html
>=20
> drivers/pwm/pwm-omap-dmtimer.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied, thanks.

Thierry

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlt6iQ4ACgkQ3SOs138+
s6ESmg//a7C9p9ALbR54YfGZ22/QjVsXBP+h1uK6seo/ifIAA1B7DBEgaHY1g23n
UnE+9eRCCP73a2pyZhW46fUb1TDfAwWSZiE0d44qstfBWApxEs0A0d5PavaTDvsL
znCuip+2B7yX6goU8238wwzYxPkO+In/Fp7uvTeV3iEKpboRacPxgsDHVWVgbJ/B
bwGDk/CAkvu6vyJNYLJAcTMYFKChi90/TXei5dT0m4EEGhT46bSb4QhJnALomEf3
DPSv8GgqOfLul+vsZe+mcqM3rFRRLHNxREoFv+kVXSpjXaOiGILJP44aLjvwx2im
YeoHqmkPasVVz+BeLbl8f1LUqovh41mAwSWXh+BFItZQwZSbidXc1rc4L1lbvFZA
vr5bW6ITbrbo5DuHOEZTSyxpUEYaiRTeYxOMroA4R8Esnhge9UIdwDPBthjb5kga
mBoRziTZfoj84xOFoXOlNctPSuMhuBssoCoaGECWUBnFV4BLcrJ8i5YsTwjYRo9L
cFf4G83aN7vm1E8j5K8NINYj8c3OGeoyRIMu7W9pC7vnaoQ0o2wftnXtBTQSyrq2
uT/beC0G43RzXxMafjsnel2ls2mcJKyOi3haKq3/kOhUJe06vOTc/aq1vujWPp4K
LX+WAOPlmiG1Ooi3ZF/Wp9jYuJUnnDRBDfNyEDz9oiItgOiiGvE=
=o+u/
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--


--===============4816942555559470808==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4816942555559470808==--
