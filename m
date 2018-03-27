From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 4/6] pwm: pwm-omap-dmtimer: Fix frequency when using
 prescaler
Date: Tue, 27 Mar 2018 23:53:33 +0200
Message-ID: <20180327215332.GC28163@mithrandir>
References: <20180223101254.GA5746@lenoch>
 <20180223101553.GE5746@lenoch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6528709137835124542=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180223101553.GE5746@lenoch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: linux-pwm@vger.kernel.org, aaro.koskinen@iki.fi, tony@atomide.com, Keerthy <j-keerthy@ti.com>, daniel.lezcano@linaro.org, t-kristo@ti.com, narmstrong@baylibre.com, robh+dt@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Brecht Neyrinck <brechtneyrinck@gmail.com>, sebastian.reichel@collabora.co.uk, grygorii.strashko@ti.com, linux-omap@vger.kernel.org, Claudiu.Beznea@microchip.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============6528709137835124542==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Pk6IbRAofICFmK5e"
Content-Disposition: inline


--Pk6IbRAofICFmK5e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2018 at 11:15:53AM +0100, Ladislav Michl wrote:
> Prescaler setting is currently not taken into account.
> Fix that by introducing freq member variable and initialize
> it at device probe time. This also avoids frequency
> recomputing at each pwm configure time.
>=20
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> ---
>  drivers/pwm/pwm-omap-dmtimer.c | 93 +++++++++++++++++++++++++-----------=
------
>  1 file changed, 55 insertions(+), 38 deletions(-)

Applied, thanks.

Thierry

--Pk6IbRAofICFmK5e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlq6vVwACgkQ3SOs138+
s6FdXg/9EBL7e4MJTa/26aQOdVIWEb75ipcj78+rxHc1g1IX5DooLrooKdvz7Tti
ezC68Onl6OCcGG4VgTaVcXj5gu3dc5yb9bKTZYwGzOvrpgUvyc0/9AwCFS3AJcy9
QV3iiytHupGRSDBLklJTdbPLCUQXRp5xHJ1S48YAyOch8AUqu+o/ONbWGdIgIXgk
09OTGy4J2ztQr+rq10tKqO1ACH//EEd+oJbH1+znkukuSV4n1zPTSah27hp4qBNB
zvhrbP5cjxuHC2b05fvQofhxtuy/dFgf5wm0Ck9cV3Hm3Nr49NoyDBehxMOfpMOm
vqYgXAe46LFn5xnG+zCXUcQ0tK+kkLJMI7suMYBQQqJ7bvTGikfRFpiDSs5fSsxG
ZqzaofaUqBKuKkjC1paNmdMRHYdoXGVL4YijftnWbFc03/5LWIkGD5tJmfEToiiW
Acp6g3R6UrEjvLurxaKlWd1U/2X3e98NKaDAaDnM/T5T6jIYAO4vVBVlf5ICJVMq
DeCJmOwL9xGTebyFBy6PWXxcx8xLjr5b6HDBAg2SmzlyJx2djY7bdbUri8YSzg7k
H/TDRblT6mUar/Bp/58ZyWzqUEJgcoQrpWkIUzeow6IKtAxcPUF3CfM8nfwXiUSl
eww4TAL+Eo/sRXyBfUDjVDSThVkCjG63x5Vxox7ghK9Dqddffjw=
=Tnlt
-----END PGP SIGNATURE-----

--Pk6IbRAofICFmK5e--


--===============6528709137835124542==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6528709137835124542==--
