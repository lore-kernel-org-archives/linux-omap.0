From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 5/5] usb: musb: dsps: add support for suspend and
 resume
Date: Tue, 1 Oct 2013 09:59:19 -0500
Message-ID: <20131001145919.GZ1476@radagast>
References: <1380634797-29541-1-git-send-email-zonque@gmail.com>
 <1380634797-29541-6-git-send-email-zonque@gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HwnjeXAdSoek43pS"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60011 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753493Ab3JAO77 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Oct 2013 10:59:59 -0400
Content-Disposition: inline
In-Reply-To: <1380634797-29541-6-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, neumann@teufel.de, bigeasy@linutronix.de, vinod.koul@intel.com, dan.j.williams@intel.com, balbi@ti.com

--HwnjeXAdSoek43pS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 01, 2013 at 03:39:57PM +0200, Daniel Mack wrote:
> The dsps platform needs to save save some registers at suspend time and
> restore them after resume. This patch adds a struct for these registers,
> and also lets the musb core know that the core registers need to be
> saved as well.
>=20
> Signed-off-by: Daniel Mack <zonque@gmail.com>

this last patch didn't apply. can you rebase on my 'testing' branch ?

--=20
balbi

--HwnjeXAdSoek43pS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSSuNHAAoJEIaOsuA1yqREymkQALDqoNPlOu+8yRyy9gavDDCm
S+FYNVU6AaCYTnhK3aqklQk78jWi8Qab2fAH3yljpu846F0eM4NCnuz/qJg+IEOb
LAin9J0ZmYCvh/PDPnJYbN1PoqdtSqF3223kRCe+bd+Fh0UkIAUF6/wndkKnWljd
qHHzh/QI3KHgzH+JytVoqo7I3oFA0MGVGk0w/lhnjX9Au5EO0QPDDutsn+9LPBRH
KNvKtWVrEM1WIxflffWqInmEuYW/kPP8uKEGLft9X02G1d00CVODk4NtFICmXV1U
ZI0VcRp8Fvj8H/2jZiK0WLCKkc6MhRgvL24eUk/ZRYsLEldhma8O9Zmi1edaCPVD
x2St7485YMpyQpGOt8WuexwWlAQfJFB5pHq8NEOUgfPyAnCJ5kLZ+WsBuNnpWCXC
PPi5oM2U0QYMUGHa1Fyqk2AOveB/i5sbk1L8vihUv+gcLlLcG44cpzdvCi9BJZjD
NebkI3gxC3tsgoZTd9+acxDjLhj46InviW8+LvepwHeIxrVoQ3C2ErTadDH6VKzy
OgwEp2tyMeAV6kDV21zTxhveJ915SIBgPWEzMY9em8J55eNy145+iM/QJsgJML/a
KKuOlaVmZ1JFYmGre+5tZPUVitQYA5vBH/LWM8vczAfJN/5fdSCDhGzQKMksvBLH
eR/8fDBvsOP6Nce1uRN7
=WmhI
-----END PGP SIGNATURE-----

--HwnjeXAdSoek43pS--
