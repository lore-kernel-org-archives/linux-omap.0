From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] nokia n900: update dts with camera support
Date: Wed, 16 Aug 2017 22:53:32 +0200
Message-ID: <20170816205332.rqcuenvuxfs5jvuw@earth>
References: <20170810204923.GA18442@amd>
 <20170814201950.sbtyuksn3ntuigyp@valkosipuli.retiisi.org.uk>
 <20170815220349.GA15441@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="manly3vkr375a3su"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170815220349.GA15441@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Sakari Ailus <sakari.ailus@iki.fi>, pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
List-Id: linux-omap@vger.kernel.org


--manly3vkr375a3su
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Wed, Aug 16, 2017 at 12:03:49AM +0200, Pavel Machek wrote:
> diff --git a/Documentation/devicetree/bindings/media/video-interfaces.txt b/Documentation/devicetree/bindings/media/video-interfaces.txt
> index 852041a..aade681 100644
> --- a/Documentation/devicetree/bindings/media/video-interfaces.txt
> +++ b/Documentation/devicetree/bindings/media/video-interfaces.txt
> @@ -119,6 +119,8 @@ Optional endpoint properties
>    as 0 (normal). This property is valid for serial busses only.
>  - strobe: Whether the clock signal is used as clock (0) or strobe (1). Used
>    with CCP2, for instance.
> +- clock-inv: polarity of clock/strobe signal. 0 - not inverted, 1 - inverted
> +- crc: crc is in use

booleans in DT are not done with <0> and <1>, but as properties without
values. True = property exists, False = property does not exist.

-- Sebastian

--manly3vkr375a3su
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlmUsMkACgkQ2O7X88g7
+prFUw/9EWRBF6rHkp7vC6zJ9pt989oDpiddog9s1TuJR+RkAL6ZoEKcG2JqCCFe
S7yajRpK1mPd5vAj4v5ZHaPHqTt6MZdFu35VHLJ6eMXv1Gimb39NHTI6huMNDF5S
WfOvgdi1wfYvGfOSTxzN/Wos56kgisZlRIiITfnnESfwVDIyrJfX5bpq/QoJGiWF
YvJwP2Nv4kmDxsCdVKbm6crffHJSkEXFWMUD1BlXzuuk9Auky954I3tsqd2ePaXp
/qK+HHF9thkN3R1a4NBND+dUXhYkQvLQ1lwyyhl2w3Zgw+gmD56onBcPivE4IKh/
6Th4+5X/UcHQaftkaoXxxdcN8aLsYqq4AXD6OfPsf96kh9IFQpyH5ejCiBP861Qh
DhmMp2tGEvYE2FoG40RkBBK0FKji1OiJLmYgOPOUPgLSyqEyKpM9Eu2CAFc7Z/Td
1F3gWP8ru++DR+pbr4Nmbyh0YG9tXtxaOVNMPSZY9m6Vk58eHBKmaoFu/MdKZruy
msbGCABFWlk6zpMGLnj1OyFdF/p+Yk1XDhPyEKjx1XS2uzAbI2pJeoFRB6YK4h2n
RHyo24Lx5h584ng5m4LDUo2IfEoFsbJVcBovasj0wEeE/norytJ0SzJWv00zdm7L
eRPFhweF7bQRxX7F7pyTJMQ3fHrc38baf6QxixsiG4m0jV529e8=
=b0oD
-----END PGP SIGNATURE-----

--manly3vkr375a3su--
