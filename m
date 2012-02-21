From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: HDMI: hot plug detect fix
Date: Tue, 21 Feb 2012 10:14:36 +0200
Message-ID: <1329812076.2090.0.camel@deskari>
References: <1329771816-21130-1-git-send-email-rob.clark@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-S6lBdBGYnCbp+K8n1m+A"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:39265 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752174Ab2BUIOm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Feb 2012 03:14:42 -0500
Received: by lahc1 with SMTP id c1so10011458lah.34
        for <linux-omap@vger.kernel.org>; Tue, 21 Feb 2012 00:14:39 -0800 (PST)
In-Reply-To: <1329771816-21130-1-git-send-email-rob.clark@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <rob.clark@linaro.org>
Cc: linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, patches@linaro.org, Rob Clark <rob@ti.com>


--=-S6lBdBGYnCbp+K8n1m+A
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-02-20 at 15:03 -0600, Rob Clark wrote:
> From: Rob Clark <rob@ti.com>
>=20
> The "OMAPDSS: HDMI: PHY burnout fix" commit switched the HDMI driver
> over to using a GPIO for plug detect.  Unfortunately the ->detect()
> method was not also updated, causing HDMI to no longer work for the
> omapdrm driver (because it would actually check if a connection was
> detected before attempting to enable display).

Thanks, I totally missed that.

 Tomi


--=-S6lBdBGYnCbp+K8n1m+A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPQ1JnAAoJEPo9qoy8lh71zewQAKovo1fzGbjVyXM8YsO6d18Z
WKubRt7Ca/CUQ0Up5jCE7nDSyACa5GS/Q4E/FWSa7gprE/Gkf4nBDXDa8Ir2MGgh
QBS2i+Ui0DRe2W7Vk1UpEw//iJ5G6RZG3eLvk8qG2MYVw3KZlzWdllm/4NuOCYVG
fklJrqxSMSp3lEZwHZv77j3+v/5z8bFzkXq5lfNNjjt9Nop/vHJ6X5+2WZdx5oNq
nW4wjngq/Hq9lGl3dD1x9f8QFLNakl/ldSMTezCqUDDACQBpE+56jn6lObjt4+GU
D99iFe/cwBj1YA8Bnj5Bu2GC64WpPf/qBMUiknaYp/UH3jWWTOosZMvMnNcZIIdi
qfl5kSdFBbcLxO9BJMBrF3OXjDbbeFzAIBWK3SjQmRuoXshhyYXjIdoBHeyp7wI3
MQoOc+zmsUpmLHoYtqNysgWQPfT9+AQT9GvuqcdyMciVtJKwTKltwXRpvWjPiYVK
TGsM8Wo+6NNRMIrocqqC0KxPZYvgp3EGRl5TaJENVW7bCdtLfniWJimYAJ4NbGZ9
sloT+7HG4ey4mT18NFL6ioQgLI/AkfS4FqZH+zU+w8U8uUhoigbMUBU55HhLS5Na
9gzCalz2XRPketA2tWWxcyBYqJchhIAFOYlF/fJNOq+Q0qLDNhnTDM0nwr9QyaE8
XLTS3Q9ApIMU52dIj9ey
=aXhU
-----END PGP SIGNATURE-----

--=-S6lBdBGYnCbp+K8n1m+A--

