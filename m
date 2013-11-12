From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: dts: AM437x GP EVM support
Date: Tue, 12 Nov 2013 08:22:06 -0600
Message-ID: <20131112142206.GD31721@saruman.home>
References: <1384255468-2453-1-git-send-email-afzal@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jL2BoiuKMElzg3CS"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1384255468-2453-1-git-send-email-afzal@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Lokesh Vutla <lokeshvutla@ti.com>, Sourav Poddar <sourav.poddar@ti.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, Russell King <linux@arm.linux.org.uk>, Benoit Cousson <bcousson@baylibre.com>, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

--jL2BoiuKMElzg3CS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 12, 2013 at 04:54:26PM +0530, Afzal Mohammed wrote:
> From: Lokesh Vutla <lokeshvutla@ti.com>
>=20
> AM437x GP EVM DTS with pinmux information to make I2C on EVM usable.
>=20
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> Signed-off-by: Afzal Mohammed <afzal@ti.com>

could you instead send the much more complete version we already have
at [1] ? It's pointless to repatch all of that in this file if we *know*
those are already working.

[1] http://git.ti.com/cgit/cgit.cgi/ti-linux-kernel/ti-linux-kernel.git/tre=
e/arch/arm/boot/dts/am437x-gp-evm.dts?h=3Dti-linux-3.12.y

--=20
balbi

--jL2BoiuKMElzg3CS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSgjmNAAoJEIaOsuA1yqREYDoQAJGp6UQRvmkH79nCmNoMgCai
ql5c6nUBlfSKakJtvOMmx+AzcGXQroOGDnSVDwxyA+ChRKMYqD/vWQdtvxpbS233
RoiWaafzVL824DQSULgsKzsY7muOYKPf7czW+JFwgNmQIqRKt23DrP3TdqM7SnbM
gs3X7oLZPwg+iiiM78WmYcRkaLjqNTayT5YLd2K6WBsfcnrZ86Ao0GK9pno32LBN
j/Lc4G2frfA7KEOpSQRcyd9aPxp7YiGz4N6EX35t6oaqNbbZDF9kXmOontRgs3UU
cHhOPC8Q9idF1PJSoFUNdmVXN57yOb86pqhAxveCpA2rqyaTPdpXc6cycz1YtIUS
1Xo2+RWj5qEym27f7HcB6wdF4i/Z2IjddkvSX5Dxydmyh3XuKjScpML38OEio97r
TnM1ihbP9p7/eYe5QbzugHkz73QzxLL5WZizML68R75k7XdW2yDxQVAwCrDEn7BW
g5cRAHVdkLck911gHF1C2dL6V7gYMnLRmr/umG7TtCOa4TaDFEo1bZqFuvCK1EDF
G3/W15LJwzQtgYE6zXiumh0lXXMXHxTJKowJAIqNjuOEaTt+VymGsB9ZW93Fm4/t
McjxrU8blwxyTOXowkcKfSpmazVWOfGBhy/+e33XI5goKuONXAce9m4p/K/BY//Q
wJ4kky1ZbSdCNzy65k/a
=thjn
-----END PGP SIGNATURE-----

--jL2BoiuKMElzg3CS--
