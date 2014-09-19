From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v3 1/5] clk: ti: add "ti,gpio-gate-clock" controlled clock
Date: Fri, 19 Sep 2014 16:25:48 +0300
Message-ID: <541C2EDC.2050707@ti.com>
References: <cover.1410898073.git.jsarha@ti.com> <71e8bdf16f8a3bff5db6ba80dcab9d21de05e939.1410898073.git.jsarha@ti.com> <541C2A77.9070406@ti.com> <541C2BC8.3020207@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="PAumHMipg7PqfU3lxae0HmlHp11O89ekQ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56185 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756767AbaISN0D (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Sep 2014 09:26:03 -0400
In-Reply-To: <541C2BC8.3020207@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jyri Sarha <jsarha@ti.com>, dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, alsa-devel@alsa-project.org, Mike Turquette <mturquette@linaro.org>
Cc: tony@atomide.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, peter.ujfalusi@ti.com, detheridge@ti.com, t-kristo@ti.com

--PAumHMipg7PqfU3lxae0HmlHp11O89ekQ
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 19/09/14 16:12, Nishanth Menon wrote:
> On 09/19/2014 08:07 AM, Tomi Valkeinen wrote:
>> On 16/09/14 23:40, Jyri Sarha wrote:
>>> The added ti,gpio-gate-clock is a basic clock that can be enabled and=

>>> disabled trough a gpio output. The DT binding document for the clock
>>> is also added. For EPROBE_DEFER handling the registering of the clock=

>>> has to be delayed until of_clk_get() call time.
>>>
>>> Signed-off-by: Jyri Sarha <jsarha@ti.com>
>>> ---
>>>  .../bindings/clock/ti/gpio-gate-clock.txt          |   21 ++
>>>  drivers/clk/ti/Makefile                            |    2 +-
>>>  drivers/clk/ti/gpio.c                              |  202 ++++++++++=
++++++++++
>>>  3 files changed, 224 insertions(+), 1 deletion(-)
>>>  create mode 100644 Documentation/devicetree/bindings/clock/ti/gpio-g=
ate-clock.txt
>>>  create mode 100644 drivers/clk/ti/gpio.c
>>
>> Why is this a TI clock? Sounds like a generic one to me.
>=20
> Like thread: https://lkml.org/lkml/2014/9/5/284 ?

Right, I should've read the earlier versions before making any smart
comments =3D).

 Tomi



--PAumHMipg7PqfU3lxae0HmlHp11O89ekQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUHC7cAAoJEPo9qoy8lh71NMkQAKCfsYhgs6aR3gCDHidHeXbC
PCOibPdhdzeAUHZZd8dJKP8EiTyTBXbUtRTE76j1a/Ku+OxqD3yoxC9t8ESi67MU
R++DU28ysW5wMTp3wPHi41zjiRZ717LTvrdIQ08dUUk2o3pxC/Re46wwwpkwTSdx
QIUGsg3lqEEss8fRgkxLParBJskOLQutAlBojotpCO++SuCzIJLkO6WEiId6JU2M
BQGid7TjQX6HL8r/9N/ncfyEf3fSykXXrmAoxD4Arek7OZ0BOnWUqTz0AAVvBDZK
mgnVO2Hod1aiVbb5D3wTH547lr4CfwFvGxBWg74DRBDHkfqL5fIWVNNOF1IdKOfb
WXjS+9jbej8JemHObD1pgbocI7Fo+Bjl5igqRIM/BsWbWyu+f1K1ekAWoJJKCZRn
r/2ei9GVFiBzaDxixHOs4c2k+wt2m5P+A473dH921PCC7/qQTOlbFvyLn563O+FO
W2hOOFLyJbnrNU8qJU9rApqwUiYTAPIrondn5E3G62SwSlGHV6DsdOMMbieHBLDR
cc7JYAsXnyw+xDrmDzfHGlx6JSQIC99m6ZDng3wRTK7Jj+VsSWZZxpBKRiYjm+6f
RAXmy5jljPk/hXQ3vkzZb2qoUnOoLul4NjS8i1eR4C9GEt+P9/+nxs6EwDb3tHbg
MIS4GO4bCKhOSz+UpZbd
=ZRpG
-----END PGP SIGNATURE-----

--PAumHMipg7PqfU3lxae0HmlHp11O89ekQ--
