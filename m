From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH 1/3] clocksource: timer-ti-dm: Fix pwm dmtimer usage of
 fck reparenting
Date: Sat, 26 Jan 2019 19:40:44 +0100
Message-ID: <20190126194044.2fad4427@aktux>
References: <20190122175717.13428-1-tony@atomide.com>
 <20190122175717.13428-2-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2678235839763053915=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190122175717.13428-2-tony@atomide.com>
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
Cc: Ladislav Michl <ladis@linux-mips.org>, "H
 . Nikolaus Schaller" <hns@goldelico.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Tero Kristo <t-kristo@ti.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Pavel Machek <pavel@ucw.cz>, Keerthy <j-keerthy@ti.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============2678235839763053915==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/5AbSC/DfyOdNO2cukCydAeE"; protocol="application/pgp-signature"

--Sig_/5AbSC/DfyOdNO2cukCydAeE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Jan 2019 09:57:15 -0800
Tony Lindgren <tony@atomide.com> wrote:

> Commit 84badc5ec5fc ("ARM: dts: omap4: Move l4 child devices to probe
> them with ti-sysc") moved some omap4 timers to probe with ti-sysc
> interconnect target module. Turns out this broke pwm-omap-dmtimer
> where we now try to reparent the clock to itself with the following:
>=20
> omap_dm_timer_of_set_source: failed to set parent
>=20
> With ti-sysc, we can now configure the clock sources in the dts
> with assigned-clocks and assigned-clock-parents. So we should be able
> to remove omap_dm_timer_of_set_source with clean-up patches later on.
> But for now, let's just fix it first by checking if parent and fck
> are the same and bail out of so.
>=20
together with 2/3 it fixes things on pyra

Tested-By: Andreas Kemnade <andreas@kemnade.info>

--Sig_/5AbSC/DfyOdNO2cukCydAeE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlxMqawACgkQfb1qx03i
kyT5yw//ZSntlnj30pDgOix+cgXsXwIjRu8Q4saMMzN18kLHRZv5bdjACIFRbGdl
H8i4SvDjILrspfjRpH8e4TJcVqETdO3WO9SiulldBnU0nOYFcMBEPlqVKh2KZnwV
GCJkHntwIwb+1HvoqYnteeBRQNhozFC+oDFv2XT/kAtCImgyc9LqUdw4fBKK9Smv
+8AS83jBLcOix2okDitGoZ/R2bz+Z9G1XwbrH2/3ovh5APa4taHkrGnhqtnX/npW
C4FlrOCJhOCpRk7JCY/gxdWBXUFhEHPUBIgV4UaS1A12nQXQnpUzKpFFJcBx1CFI
zSmE/ph7sutbg5rM8jGwy6PYeEBBwp0G+WkG6zKoyr2nVQQ0CpjsXW8wak8f7QZ7
lqEe0iEfEkBdN0BMy+gNXbJhKf53b2WrTeKx2c8N4UWj/n16ETMNB24pZEJyC6z1
eHp60FABXxSluyBTAGdNBgM9rqVQTQRWG/Pelgi2i0yovnFWhrKZJLcung+GuFUR
YCqAbDtKtRHd+Nt8bKdc6VbsUVNhZArFm3op8uszQsAG43XYDjsCT+Yf3ikjL0Wo
dDf4txq4V19WC4Kutvk23M65SbeWlVK5H5fx1NhIsnO2owZsJ+R+slLeZQ4/qiS5
vIkmaDch2gZXtA41bVpEl2bV8xOPkGbwvUlA02iRY93bYtnTKZU=
=YJJJ
-----END PGP SIGNATURE-----

--Sig_/5AbSC/DfyOdNO2cukCydAeE--


--===============2678235839763053915==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2678235839763053915==--
