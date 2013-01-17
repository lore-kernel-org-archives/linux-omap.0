From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH v2] pwm: pwm-tiehrpwm: Update the clock handling of
 pwm-tiehrpwm driver
Date: Thu, 17 Jan 2013 16:52:18 +0100
Message-ID: <20130117155218.GA23117@avionic-0098.adnet.avionic-design.de>
References: <1357823126-19333-1-git-send-email-avinashphilip@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1357823126-19333-1-git-send-email-avinashphilip@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Philip Avinash <avinashphilip@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, nsekhar@ti.com, gururaja.hebbar@ti.com
List-Id: linux-omap@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 10, 2013 at 06:35:26PM +0530, Philip Avinash wrote:
> From: "Philip, Avinash" <avinashphilip@ti.com>
>=20
> The clock framework has changed and it's now better to invoke
> clock_prepare_enable() and clk_disable_unprepare() rather than the
> legacy clk_enable() and clk_disable() calls. This patch converts the
> pwm-tiehrpwm driver to the new framework.
>=20
> Signed-off-by: Philip Avinash <avinashphilip@ti.com>
> ---
> Changes Since v1:
> 	- Check the return value of TBCLK enable in .pwm_enable()
>=20
> In 3.8-rc1, common clock frame work support added to AM335x.
>=20
>  drivers/pwm/pwm-tiehrpwm.c |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

I had applied this to my for-next branch, but reading the commit message
again it would seem that this should actually go into 3.8, right?

Thierry

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQ+B4yAAoJEN0jrNd/PrOhrtQQAK5QNNFUEEMpvishrrJh2UpA
eH9A3FThk97IDh0ravOAYQ2fnsl7cDESTg7PHBkd8L3ALWVAADAv+AQVVuKbnCG5
o4+9DzYUqg6yuAM26HifzeOarOh9jIVtvMgMxdzK4GL458jqmOzuewD4QDXPCo7B
8fcThSq//xtWZxiuB6vB23XtpvQzYMJxbofF/w9wTRfV5RIXYfse44ddXRr/0l3c
9cP8lsy+BMUu0Taock8ZLxWwwEQvfwgIVBWSBVnxme9MTx3rB771S+8pyj3oCvDA
Y3sSlS34bS/Tsoh7vEmq/hFt8gMxvyDsOLJ1yaZeTfMqGzTbUOCmoPKmyeQepo+H
qc7P2biTcxjr1glrAqHwTXDW6bDqtltSpP3UR1HzVsOryXc5l4Ab+YjrHn8K44+4
l+SdirVjHLj0S5HlsRQCVpWQsEWsB0rpHaJKr+0bPDG0GdL97S93K/8Zy9g611vJ
PZX5Em68NiN+KTvuverXaPMl3mQg17gVGZ79R2vTXvQbcdftMp9EU2CrxZcahVp9
3pXKqPNtLvEBFOnZ179MnK/NpyyPIlTvB/zxE5rTmLqmcJ0TSp5Gt6oUOz4cPAtj
FKQBL3s2aEKbdq8Eds/aBZ/9gqEFZX+NrUGpc3QTGJuHHFUURhsXVohEDJHCZmou
T338K2ianQcb09QuJp47
=Uh4G
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
