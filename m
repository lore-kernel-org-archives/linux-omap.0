From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 0/2] Add definition for GPIO direction
Date: Wed, 6 Nov 2019 13:08:46 +0100
Message-ID: <20191106120846.5bunrqj3uz4khih5@earth.universe>
References: <cover.1573029228.git.matti.vaittinen@fi.rohmeurope.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7642342686517139322=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1573029228.git.matti.vaittinen@fi.rohmeurope.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: alsa-devel@alsa-project.org, linux-aspeed@lists.ozlabs.org, David Daney <david.daney@cavium.com>, Linus Walleij <linus.walleij@linaro.org>, Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Peter Tyser <ptyser@xes-inc.com>, Thierry Reding <thierry.reding@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Marek Behun <marek.behun@nic.cz>, Fabio Estevam <festevam@gmail.com>, linux-stm32@st-md-mailman.stormreply.com, Marek Vasut <marek.vasut+renesas@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Kevin Hilman <khilman@kernel.org>, Michal Simek <michal.simek@xilinx.com>, Jonathan Hunter <jonathanh@nvidia.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, Bamvor Jian Zhang <bamv2005@gmail.com>, Joel Stanley <joel@jms.id.au>, Uwe
List-Id: linux-omap@vger.kernel.org


--===============7642342686517139322==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bnpwomoqjjihlwgi"
Content-Disposition: inline


--bnpwomoqjjihlwgi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 06, 2019 at 10:51:06AM +0200, Matti Vaittinen wrote:
> The patch series adds definitions for GPIO line directions.
>=20
> For occasional GPIO contributor like me it is always a pain to remember
> whether 1 or 0 was used for GPIO direction INPUT/OUTPUT. Judging the
> fact that I removed few comments like:
>=20
> /* Return 0 if output, 1 if input */
> /* This means "out" */
> return 1; /* input */
> return 0; /* output */
>=20
> it seems at least some others may find it hard to remember too. Adding
> defines for these values helps us who really have good - but short
> duration - memory :]
>=20
> This idea comes from RFC series for ROHM BD71828 PMIC and was initially
> discussed with Linus Walleij here:
> https://lore.kernel.org/lkml/c06725c3dd34118a324907137758d8b85b3d4043.cam=
el@fi.rohmeurope.com/
> but as this has no dependencies to BD71828 work (which probably takes a
> while) I decided to make it independent series.
>=20
> Patches are compile-tested only. I have no HW to really test them. Thus I=
'd
> appreciate carefull review. This work is mainly about converting zeros
> and ones to the new defines but it wouldn't be first time I get it
> wrong.
>=20
> Changelog v2:
>  - squashed patches 2-61 into patch 2.
>  - dropped patch 62 (can be applied later)
>  - rebased (cherry-picked) changes on top of GPIO devel branch.
>=20
> Patch 1:
>  - adds the defines
> Patch 2:
>  - convert drivers to use new defines
>=20
> This patch series is based on GPIO tree devel branch.
>=20
> ---
>=20
> Matti Vaittinen (2):
>   gpio: Add definition for GPIO direction
>   gpio: Use new GPIO_LINE_DIRECTION
>=20
>  drivers/gpio/*
>  include/linux/gpio/driver.h         |  3 +++
>  61 files changed, 214 insertions(+), 102 deletions(-)

Maybe also update the GPIO drivers in pinctrl?

$ git grep -l gpio_get_direction drivers/pinctrl
drivers/pinctrl/bcm/pinctrl-bcm2835.c
drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
drivers/pinctrl/intel/pinctrl-baytrail.c
drivers/pinctrl/intel/pinctrl-cherryview.c
drivers/pinctrl/intel/pinctrl-intel.c
drivers/pinctrl/mediatek/pinctrl-mtk-common.c
drivers/pinctrl/mediatek/pinctrl-paris.c
drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
drivers/pinctrl/pinctrl-amd.c
drivers/pinctrl/pinctrl-at91.c
drivers/pinctrl/pinctrl-axp209.c
drivers/pinctrl/pinctrl-ingenic.c
drivers/pinctrl/pinctrl-ocelot.c
drivers/pinctrl/pinctrl-oxnas.c
drivers/pinctrl/pinctrl-pic32.c
drivers/pinctrl/pinctrl-pistachio.c
drivers/pinctrl/pinctrl-rk805.c
drivers/pinctrl/pinctrl-rockchip.c
drivers/pinctrl/pinctrl-rza1.c
drivers/pinctrl/pinctrl-st.c
drivers/pinctrl/pinctrl-stmfx.c
drivers/pinctrl/pinctrl-sx150x.c
drivers/pinctrl/qcom/pinctrl-msm.c
drivers/pinctrl/stm32/pinctrl-stm32.c
drivers/pinctrl/vt8500/pinctrl-wmt.c

-- Sebastian

--bnpwomoqjjihlwgi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl3Ct78ACgkQ2O7X88g7
+pr6lA//Yq6zLlwHT2xTPxnqqdH7KC4/5hR3D1iXhM7jA1kF2R0rHNpxyfHAeqYg
0FRg7OCExPRbZpdOiT3Yk6Aup+DdXeSoVa7t6XJ85SR4Yc7IGRG6cmJOC9sblqSQ
Xf9mksV1lOqF0CWtlHzClPDPjU9R5VbkdxvjWoAAKgAajcCdezKNsTOqRM1yCXNa
9/qfr4XZIwYVE82pwk3UIYyGs9/eFPim+5NWDCqr1q1r2nCNhAHhscKAdIPBzWLj
FvxBya93zcYmWzagPz8wuczqUAhKVNkG0CXuGExcQmu07SzU/6VC3rIMqRJa5TkK
cZ3G9+oKyLrWPK18NSgbIXkXKp1pI/zJREWECs5hfkmhCZRU5PRQrxVrIlZ5DkGd
wfovOq9PQmajQyPmesZ8wmpqYFQ7owiGLa0ipIA4See0J2n7ql2lHKxWTQ04Ly+E
dWRbOUuh/CZggvzd2XUU6JXKJ1NEtM1J+QRZrgtCyufaOTmBgVjH0fqQD13knqCE
FDyOfEoaVelPcayHVgQIRnGfgteZq/5pqG0+mv7Hfu5BTkLOTssaZcRX1QLXrMMX
aKMSHAAOPq9WrIrtwQ1ntVCKy6EORT7inYndTO1Q4z3HegssO4HsFdEvltYrGvSl
xsG+UCmxQIAvAtZM2IO5J4juX8hdUCQ9l1PcvxB2dK0awRH9DVM=
=mpHP
-----END PGP SIGNATURE-----

--bnpwomoqjjihlwgi--


--===============7642342686517139322==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7642342686517139322==--
