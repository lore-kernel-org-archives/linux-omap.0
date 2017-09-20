From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] i2c-omap: Trigger bus recovery in lockup case
Date: Wed, 20 Sep 2017 17:02:16 +0200
Message-ID: <20170920150215.fw7dcru6m234pp56@earth>
References: <1505403549-12992-1-git-send-email-claudio.foellmi@ergon.ch>
 <9d3e3029-f775-a9aa-8025-badccb699ed8@ti.com>
 <48ddc9bc-2b83-97c9-fbd7-90d4da9f2687@ti.com>
 <0a506277-6c9b-1407-dea3-f9895fdc3e63@ergon.ch>
 <cbb3aaa2-44d1-8a7d-1d8e-1433b0a7b9d3@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5ipqkxngmbtuhqfc"
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cbb3aaa2-44d1-8a7d-1d8e-1433b0a7b9d3@ti.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Claudio Foellmi <claudio.foellmi@ergon.ch>, "Strashko, Grygorii" <grygorii.strashko@ti.com>, Tony Lindgren <tony@atomide.com>, "Nori, Sekhar" <nsekhar@ti.com>, "Cooper Jr., Franklin" <fcooper@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Wolfram Sang <wsa@the-dreams.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


--5ipqkxngmbtuhqfc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, Sep 19, 2017 at 04:20:49PM +0530, Vignesh R wrote:
> I hit a situation where when communicating with a faulty i2c device, the
> last transaction on the bus does not end with proper STOP condition on
> the i2c bus.

Yeah, omap-i2c seems to have big issues with a device not acking a
transaction properly. It can be easily triggered on N950 (OMAP3 based):

https://patchwork.kernel.org/patch/9914785/

Please Cc me when sending a patch, so that I can test it on N950.

-- Sebastian

--5ipqkxngmbtuhqfc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlnCgvUACgkQ2O7X88g7
+prmXg//XJjVPFwJzoJYVC9Vjs0R6rcrrjkzvYlZ6d7LYzKZfomBKVhwC7XFpLVB
TooCf5ir9sSYU5I+UmB6xI1w79BY3scUYMn+YzNU48S7HN5tgXDrB+ohMXTsnbi6
RlS1QoKxh0edraToiQfRq50mlpSKGmGW3v3XXu0wHy/eM4dSTN/j5IwHJqsjWv9e
TKSHnpl6fRHde8KJxa7b6T3WbQkKgUN8J46WVVb0E9sP5++IIcaN0JAi1NwS+Van
4voAGpbnoF6iXf71WfN9tNPfrm9NKXKqW0Wwtw1CFYsTFKiQVXP4h52JGDcFp7Zq
bLV76i9clcv8kTWnLCiewnF8Y/B3td6hPjOV8k8fXga4c/ac9U1jgN7B2RUKOBG4
QVA6jVFuc7yphuj2hFyUkbKKd01RmhjY1QirtkUAJ+iQjZrlEE/e8X364O3Wr/mh
A+hf8uTBXjyezrf1NGehGeRLlgLm30uW5a4UAXp+0UwHE9mJ5PR3Va5WVKOVnTVv
fH1vUz9PxGWPDVrmiHnp2lKtozcemwFzT6fdEFpw/6syBYSDdi5GGdRixD3uAaQp
JddlTcu2bBQMjgANZCozNYLoEmj17AiNMV0Uzm9iwV4ThsQMq5G9786ka8clvFSW
wpTb3FPGgif7C/Ujcy/6FbYkqWVm61f1J41JL3RbFKKbCSwDFJk=
=+srL
-----END PGP SIGNATURE-----

--5ipqkxngmbtuhqfc--
