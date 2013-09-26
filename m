From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: Add missing dependency on backlight for DSI-CM
 panel drier
Date: Thu, 26 Sep 2013 13:21:31 +0300
Message-ID: <52440AAB.70101@ti.com>
References: <1380108661-22702-1-git-send-email-broonie@kernel.org> <5243F20A.9000707@ti.com> <20130926101247.GB19304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="ULJm6eakE1Ai2LoskuhRSFJ97MXkT4B0D"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46209 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756302Ab3IZKVh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Sep 2013 06:21:37 -0400
In-Reply-To: <20130926101247.GB19304@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linaro-kernel@lists.linaro.org

--ULJm6eakE1Ai2LoskuhRSFJ97MXkT4B0D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 26/09/13 13:12, Mark Brown wrote:
> On Thu, Sep 26, 2013 at 11:36:26AM +0300, Tomi Valkeinen wrote:
>=20
>> I wish we could "select" instead of "depends on"...
>=20
> We probably could.

I'm not so sure.

If we select BACKLIGHT_CLASS_DEVICE, we could end up compiling
backlight.c without fbdev, and backlight.c uses fb's funcs.

The funny thing is, there is FB_BACKLIGHT, which seems to be designed to
be selectable (and is selected). That one depends on FB, but if I'm not
mistaken, that dependency does not do anything if FB_BACKLIGHT is selecte=
d.

FB_BACKLIGHT in turn selects both BACKLIGHT_LCD_SUPPORT and
BACKLIGHT_CLASS_DEVICE, neither of which seem to be designed to be
selectable.

I think that's a bit broken. Anyway, I guess it's better to "depend on"
here, to be on the safe side.

 Tomi



--ULJm6eakE1Ai2LoskuhRSFJ97MXkT4B0D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSRAqrAAoJEPo9qoy8lh717dkP/2OKI315CSH5bFBHMqJjwRpa
+yao8VMVEQnJbe9IH+crHIbcWnwwDzjrB53NDPg+ah98rGVcgAMeI9IaWJmIdzlt
hM9sTou/3Q8Cq8v0LzXNZvlm2ZkO8sqLVUD+P/kuB7DDbdi9CUyxqvOGxTFdK/UV
W7pD5Y26sOW1EgFLsWkjfeud/jzMaLi+Wq5FhDkF0pCU5X5b8mO26l0KnSmeSySp
NOzkV+WodznpZTC24dxy6I1SWyz6pGDS6Y8Uh5faSSUs9Lw74XkZRPSHNQyhmM55
mhApJK2SfOFJnGJ69LupgEp7pD2kNQd9fIf0vTouYbyJX4ykxdcQ2CSkz4Cp+ybW
i2UTjiR4s8SmS0brcqYp2kbN98psp1kV/e/PF2xferMq6+x9eGE/EoayqwjUhLnL
TB9VHD9hI9qWg4BT606n2/RtD4gJJhCM70wNEYhfViTCpeoNejWJJvMSjPWDkhN7
1EaCyQOHDCEXXXBgUdM4P/Qdq7p15VScDUuqfNFUCiysZHZkydEo+zN5uSy1Vzdl
rk5IQAflLuYwhCet01sWIrdROUYhHx5Tc2j3dhNX/3wmoF9fLx57uXgtDq+ZIWde
cQ7poZT5ZH+QtFKuIav1zBbzNBoAlxr5FR0035hN578dtzqpiwqp3zrGtiy1HJ4/
miXSk1lwFTNS1WsUnTFs
=I/0s
-----END PGP SIGNATURE-----

--ULJm6eakE1Ai2LoskuhRSFJ97MXkT4B0D--
