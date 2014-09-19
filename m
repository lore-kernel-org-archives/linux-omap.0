From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v3 1/5] clk: ti: add "ti,gpio-gate-clock" controlled clock
Date: Fri, 19 Sep 2014 16:07:03 +0300
Message-ID: <541C2A77.9070406@ti.com>
References: <cover.1410898073.git.jsarha@ti.com> <71e8bdf16f8a3bff5db6ba80dcab9d21de05e939.1410898073.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="1uXkGQadUj5AAmolLFvO8fMQ1WbffHaIn"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56216 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754085AbaISNHT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Sep 2014 09:07:19 -0400
In-Reply-To: <71e8bdf16f8a3bff5db6ba80dcab9d21de05e939.1410898073.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>, dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, alsa-devel@alsa-project.org, Mike Turquette <mturquette@linaro.org>
Cc: tony@atomide.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, peter.ujfalusi@ti.com, detheridge@ti.com, t-kristo@ti.com

--1uXkGQadUj5AAmolLFvO8fMQ1WbffHaIn
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 16/09/14 23:40, Jyri Sarha wrote:
> The added ti,gpio-gate-clock is a basic clock that can be enabled and
> disabled trough a gpio output. The DT binding document for the clock
> is also added. For EPROBE_DEFER handling the registering of the clock
> has to be delayed until of_clk_get() call time.
>=20
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
>  .../bindings/clock/ti/gpio-gate-clock.txt          |   21 ++
>  drivers/clk/ti/Makefile                            |    2 +-
>  drivers/clk/ti/gpio.c                              |  202 ++++++++++++=
++++++++
>  3 files changed, 224 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/ti/gpio-gat=
e-clock.txt
>  create mode 100644 drivers/clk/ti/gpio.c

Why is this a TI clock? Sounds like a generic one to me.

In any case, this should go through Mike.

 Tomi



--1uXkGQadUj5AAmolLFvO8fMQ1WbffHaIn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUHCp3AAoJEPo9qoy8lh71nhEQAJO46f7xMmo3VjBWVDtoNo64
+PIeMqqNAOUeGbxiQ6Ac0EyMTSI6wuKr2L/Nc99SYMpCD6Svm0zXzcpY3+xtJ8Kc
4dHoC+S9nwRwA0AFR7d9C5drwYCQv+NgKTPyR35gKCKyDnuDTnLh9JD2nxy2Qut5
YjfDX/kw/V4qFouZJr/l4EUrqp6UN1hE1EVuapQWa+RwyUjbhXTzVC+j+I0MqLD8
VE7q22+O8Cp4zb+JDeGgtqkZjoUFWNWfJP5etcAh/T4dsl/K5RQX46ZzC8CoVmzM
TvBPgow1oJmvXulRtHdU3Es5AAqzICzmz3GEm3djBd5u0D1Ksle9TzQsl0E1BM8p
43jBIeGVJ4raLbSYWAyZF9oY+G9bn50VN2YFQYsFCh5KxeFzdW0XQVJoSgLUlpA1
mo1eyA1+vFnwdHxh9hijmzwZudDjdnrLmZHPNN8K++kN1pDvZrrFSc89J9wlayDg
kpz+O+ErTnppulRbLwiYpEUwTD1Hrr75pnB2oORN0kufD2o9oBMrJTn6xDEvIpmq
bn29qI8mB9CNmxeyo3f1UeodvUPWSFR5gtW8o1xBt2qhX7K+FHXFLxVPzD5HOZWe
WU6J2qXO72MfV3ZMttKfU+ngdKBFBLFVCSG0C6BBYuhamAZQG3ZJ8uLC4JXBFf8G
r1D2KMAgLMiHGj4/Yl1b
=UN+w
-----END PGP SIGNATURE-----

--1uXkGQadUj5AAmolLFvO8fMQ1WbffHaIn--
