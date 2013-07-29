From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 0/4] Add PWM polarity flag macro for DT
Date: Mon, 29 Jul 2013 14:30:16 +0200
Message-ID: <20130729123015.GF23152@manwe>
References: <1374101664-21112-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WlEyl6ow+jlIgNUh"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f42.google.com ([209.85.214.42]:38594 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755199Ab3G2MaU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jul 2013 08:30:20 -0400
Content-Disposition: inline
In-Reply-To: <1374101664-21112-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Boris BREZILLON <linux-arm@overkiz.com>, Shawn Guo <shawn.guo@linaro.org>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Stephen Warren <swarren@wwwdotorg.org>, Tomasz Figa <t.figa@samsung.com>


--WlEyl6ow+jlIgNUh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2013 at 12:54:20AM +0200, Laurent Pinchart wrote:
> Hello,
>=20
> Here's a small patch set that replaces PWM polarity numerical constants w=
ith
> macros in DT.
>=20
> The series is the result of splitting the original patch into four patches
> that
>=20
> - add the flag macro (both in a header file and in the PWM DT binding core
>   documentation)
> - use the macro in the PWM core code
> - update existing DT bindings to refer to the PWM DT bindings core
>   documentation
> - update existing DT sources to use the new macro
>=20
> I believe I've taken all comments received so far into account. Most nota=
ble
> changes include
>=20
> - splitting the original patch
> - removing the PWM_POLARITY_NORMAL flag, which wasn't a flag but was defi=
ned
>   as 0
> - renaming the PWM_POLARITY_INVERSED DT flag to PWM_POLARITY_INVERTED
> - not relying on DT flags and PWM C flags having identical names and valu=
es
>=20
> Laurent Pinchart (4):
>   pwm: Add PWM polarity flag macro for DT
>   pwm: Use the DT macro directly when parsing PWM DT flags
>   pwm: Update DT bindings to reference pwm.txt for cells documentation
>   ARM: dts: Use the PWM polarity flags
>=20
>  Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt    |  8 +++-----
>  Documentation/devicetree/bindings/pwm/imx-pwm.txt          |  4 ++--
>  Documentation/devicetree/bindings/pwm/mxs-pwm.txt          |  4 ++--
>  .../devicetree/bindings/pwm/nvidia,tegra20-pwm.txt         |  5 ++---
>  Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.txt  |  4 ++--
>  Documentation/devicetree/bindings/pwm/pwm-samsung.txt      | 10 +++-----=
--
>  Documentation/devicetree/bindings/pwm/pwm-tiecap.txt       |  8 +++-----
>  Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt     |  8 +++-----
>  Documentation/devicetree/bindings/pwm/pwm.txt              |  7 ++++---
>  Documentation/devicetree/bindings/pwm/spear-pwm.txt        |  5 ++---
>  Documentation/devicetree/bindings/pwm/ti,twl-pwm.txt       |  4 ++--
>  Documentation/devicetree/bindings/pwm/ti,twl-pwmled.txt    |  4 ++--
>  Documentation/devicetree/bindings/pwm/vt8500-pwm.txt       |  8 +++-----
>  arch/arm/boot/dts/am335x-evmsk.dts                         |  3 ++-
>  arch/arm/boot/dts/wm8850-w70v2.dts                         |  3 ++-
>  drivers/pwm/core.c                                         |  7 +++----
>  include/dt-bindings/pwm/pwm.h                              | 14 ++++++++=
++++++
>  17 files changed, 54 insertions(+), 52 deletions(-)
>  create mode 100644 include/dt-bindings/pwm/pwm.h

Applied, thanks.

Thierry

--WlEyl6ow+jlIgNUh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR9mBXAAoJEN0jrNd/PrOhCDAP/1+M1mPj5C9mvfurPK96v+0+
4btGxrFvJfjpMKweqI3sb7gZ+ulgm/KLVOxzwWu/aFr5TtDjgprQXN9vCEIqsAcU
MpbP2hQlhSMY7tZ7YYGG/MI+BZ1Lhg31S7mwagP4WJXKwyigD1ruiirAMoYHWunH
Iy99C4m/pW0of5fdUiQhabJWh7Pg03ePokiCUyk4xqXRWCRPee4Z1HB61CtNtvIg
vSij3OrtwST9NhQIBUqgxLZGxFSyGveJ4BCTIKzT5b5058ufqirjXgG618SP9UYf
oM6NBMx8ac/S2hBlnPFSysT3nGQbt8+EEpPyksLA1nZHKG0iYvkQRmEhWXrrfeyL
Idd2bl/EmNefwS9Hd4RQz7Ssy+/6So5mnpPIAPX6YvSeN00U+Y6RqwdUp5QoPA/G
bOCtESEfZUsPWSwIm9Rk6+hIy4NY2mfHu+1val9ARS340n7TI9MwW8zZxWF280ZT
JDNVaIIk5OEd07HMLvoWQ6pnaEPu5HZxXxPpmL7i1gca9bZ5KPW7N3S3PREmA3bd
asX3qsQ9rh6WJm/n+LjK0bWtMDU4XE8ROXqUXQuxtHC1yMKTBA58FwwFVtu6pWsb
mq34saCUJ+aULBa1vOb59ULnZLnPPgcVG6Ywnh2wEZ4k1KHRGE3mEJ9DUdLy34a8
kvP1YK68KgQm0wZ5XLCI
=09CY
-----END PGP SIGNATURE-----

--WlEyl6ow+jlIgNUh--
