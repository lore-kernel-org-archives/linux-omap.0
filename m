From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] arm: omap5: dts: add palmas-usb node
Date: Mon, 15 Jul 2013 12:26:33 +0300
Message-ID: <20130715092633.GC14330@arwen.pp.htv.fi>
References: <1373645681-29779-1-git-send-email-balbi@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ncSAzJYg3Aa9+CRW"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53624 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754609Ab3GOJ1X (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Jul 2013 05:27:23 -0400
Content-Disposition: inline
In-Reply-To: <1373645681-29779-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <benoit.cousson@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--ncSAzJYg3Aa9+CRW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2013 at 07:14:41PM +0300, Felipe Balbi wrote:
> Without this node, there will be no palmas
> driver to notify dwc3 that a cable has
> been connected and, without that, dwc3
> will never initialize.
>=20
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>=20
> after this, all we need is wait EXTCON merge
> which contains the final changes necessary
> to get USB3 working out of the box.
>=20
> I'd suggest waiting on this patch until EXTCON
> reaches mainline, just to make sure we don't
> end up with DTS data for devices which don't
> exist.

this is not entirely correct. v3.11-rc1 has almost everything we need,
already have a newer version of this patch but dwc3 has decided not to
behave.

don't apply this version

--=20
balbi

--ncSAzJYg3Aa9+CRW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR48BJAAoJEIaOsuA1yqREzAAP/jqljQWxtHjl5etcQvM4go7F
gfCDbdCL4i3KT2ZG6Ul8BBMzPrqEV4fqicvIiP8kaWmF1iFywCHmaXjAUCFPVt3z
ebkWcWdYCyCh0iw9g4bSJPL3GLqswMrgudmXs4KHL8Xh94BGUfyH0KuKNMUs9eIe
ao8kkcfBWFaGQWfUT/aAgkbET1PP390LRzXT/++Tw6VpTMTbsgowa0nzYTy3X2JT
ypaqBJc8gep+13/OYj+SYhmZLwVc1QKkWHid2CeU85RGAAGkDffss9uzqjJcxSLZ
K4uhHZObup5lJQZIXLOtiBrL0ViH6iYgpZT+84iAQjyF9XFsQNiDKdmscbKYjxf/
HV7nUYFLGx+++JNNjObEprRFlAiFXG7EJibFroBdjnUg3IsoVerg0f0dWRjPvpko
fh0sNIVPKhUCiu889vIvQf9BkMGqoFd6V+neBwycDKWXFEXtqvvZr5UUcH71F7vR
+1VQuDkScJiWG5zk82TGshcMTLIMqsIbMDh8U+SmgmVKL2GozUW1mgfmYUfi1/cj
T33PbbWJGChNdSudKSxswzosK2x2WpgKXbSsrhjKMvJ0xiKBiAkl2TyjZGJ17mV5
rzlVEa7RsYqovn46OJ1ZcBexlOSZBeGNTNrxkIgRhSD0GzdObWNZ4P6ZPjDlkGpA
yjwqggO2ecke3ovTeLJO
=jse+
-----END PGP SIGNATURE-----

--ncSAzJYg3Aa9+CRW--
