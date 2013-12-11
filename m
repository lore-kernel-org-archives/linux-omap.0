From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] ARM: OMAPFB: panel-sony-acx565akm: fix missing unlock
 in acx565akm_panel_power_on()
Date: Wed, 11 Dec 2013 16:29:57 +0200
Message-ID: <52A876E5.4040000@ti.com>
References: <CAPgLHd_asZkqBEXyx611=NOMfcaR18jZ8Yxkt5yhg7Lbng93MA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="8bgXEdsHRc9nknWSsucea5neatCfi8K5s"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52683 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751498Ab3LKOaS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Dec 2013 09:30:18 -0500
In-Reply-To: <CAPgLHd_asZkqBEXyx611=NOMfcaR18jZ8Yxkt5yhg7Lbng93MA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>, plagnioj@jcrosoft.com, aaro.koskinen@iki.fi
Cc: yongjun_wei@trendmicro.com.cn, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

--8bgXEdsHRc9nknWSsucea5neatCfi8K5s
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On 2013-12-06 14:55, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>=20
> Add the missing unlock before return from function
> acx565akm_panel_power_on() in the error handling case.
>=20
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

A fix for this has already been merged:
c37dd677988ca50bc8bc60ab5ab053720583c168 (ARM: OMAPFB:
panel-sony-acx565akm: fix bad unlock balance)

 Tomi



--8bgXEdsHRc9nknWSsucea5neatCfi8K5s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSqHblAAoJEPo9qoy8lh7194AQAJAr1ScbIjsXKGM8YuwF3QW+
V/TNCRw+XYZN4fxXeu8Q9QFJbmEvcZZ77onTRWX6JqiL9IqkxCJenyhff5OU2+Zr
tPwrYsHhCQVob+mTHuEVQpaz7WhcT7ruVql2MlXsh/IvBH9Anwp6mdEOI/sgiATt
7lALlsHkYT3q+u73idbQDzD+PjSOS9SSsx83eqXnGxZrTQNrycpj5hX/kbYFPUTC
0qstqSMNTsDIMgJ7nXQ604Wt7X3mi2MyASeHQBbbN3CHIC6rj+96WW2xMECo1bLn
ccyXUy/k2W120BWzULlTdNql3WSq+//AEW3nHZu3VgU/yperhXTPpdR/mmuhL9hG
edr9XZjB/8p2zi8H0epf73CDDGo5oW7qkhJeONZNk71IBxRdc5d2gBPkocFWpl7V
B5h6x0nOYEEfm2fj6xdfA1lJ7GtHvV0J5Qs3QnVc0H3/059TydPOlyqRrO7xSmbp
K9n8wcaVtbMaPKATIHCDIpZyxT1WakmXnSb6oQH0tUVYSItKzEjCQDy46XYXPb4C
XB5S8dmty+oj7LifL43/yZHPtRedHfo8zF6+9jc2mIfK54hbFovqjoNv1kEyb1mP
BfS9HD7W8bWtrwB3/q8KammFIrVFV1rvPRdH2xaFvhLd2+1dirTYcjeGgM5zG+WA
sU6SOS/ZZS897sGBljN5
=mzSG
-----END PGP SIGNATURE-----

--8bgXEdsHRc9nknWSsucea5neatCfi8K5s--
