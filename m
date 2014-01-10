From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/2] ARM: DRA7XX/AM43XX: randconfig fixes
Date: Fri, 10 Jan 2014 10:14:22 -0600
Message-ID: <20140110161422.GH6665@saruman.home>
References: <1389347850-22435-1-git-send-email-t-kristo@ti.com>
 <1389347850-22435-2-git-send-email-t-kristo@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QwZB9vYiNIzNXIj"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45167 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756042AbaAJQPo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Jan 2014 11:15:44 -0500
Content-Disposition: inline
In-Reply-To: <1389347850-22435-2-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org

--+QwZB9vYiNIzNXIj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2014 at 11:57:29AM +0200, Tero Kristo wrote:
> DRA7XX and AM43XX were missing common clock code from the Makefile, which
> causes build breakage in DRA7XX / AM43XX only builds once clock support
> for these SoCs is added. Add the missing entries to the Makefile as
> preparation of this.
>=20
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Reviewed-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--+QwZB9vYiNIzNXIj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJS0BxeAAoJEIaOsuA1yqRElOIP/iXZB3sRhs7+P/ge17Evn32f
HuFePb1Yf4NwsaitV2vXgRpTHit7DEFOEX9gJAgtiKgYj7nIttA/H1tqfcHWnBFj
3v1W3N0L7h6HkHTtPN2M89MOziSkrvDT1BcNwG4M2iofmxD7QUZBiqe+hD++GOJL
q7WBld7YfmG9PPUgpeeQKVOvC1lquSM3vzxqzv8pmLa0vycROt3QR3NZ2Sd9Qy8R
ejDIeWJFcW+gJpDIFa6Y1K5/pdM75UX/7of6oMn1TsuUD7a99cM+r16gUYuhs7eS
YJ0xgvGKm0hYvJ/LUmfeLXWWMdPVbAUjvSs8xY2O8dBMWd1HfkrafIkReZ3lGy1A
uE53MSvOfbrK/M8nMV8ucmQJxWSH1crtf8Ubp4F0QQFvQjTrmwthToc2Aambdp0J
DxMHE9VoDa62eKwgyUqXOl+G/Ujw7xWsxY3ovFCuppiAekSXLksTYGfn3ro7h266
MSERpEX0nYKrx5ii0TiHvxabNCaKI4ghxqDgJk0nkwf2fvlcMTXXJFysPncRE2sP
amplu2tX14SAZgOHOeteGVzLlzrCZFd91npv4BivGGq8hdABWBGlNnp6sROEIeB/
UfbygpR/z21+fTPLSqqMet7Rb+yZhnvLKW4oihA6zk770d/RjhjZChLVMmyh81q6
8OAEtXswXBBdH77MkIa0
=QygN
-----END PGP SIGNATURE-----

--+QwZB9vYiNIzNXIj--
