From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv2 01/27] ARM: OMAP: remove DSS DT hack
Date: Wed, 18 Dec 2013 12:21:29 +0200
Message-ID: <52B17729.3040807@ti.com>
References: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com> <1387205794-32246-2-git-send-email-tomi.valkeinen@ti.com> <20131216184157.GA26293@atomide.com> <52AFF31C.6010100@ti.com> <20131217153001.GN12324@atomide.com> <52B14AEE.8090807@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="KKO7gh8DnXFB67fN53B17JuaIku77kBLG"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46787 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752642Ab3LRKVc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Dec 2013 05:21:32 -0500
In-Reply-To: <52B14AEE.8090807@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org

--KKO7gh8DnXFB67fN53B17JuaIku77kBLG
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-12-18 09:12, Tomi Valkeinen wrote:

>> Well yeah let's keep those separate still as at least Russell needed
>> some more time with the legacy booting. The point we can drop the
>> legacy booting for omap3 may still need to wait a bit, maybe even
>> until v3.15 to keep things working.
>=20
> They can't be separate. Once I add DT support for a board, I have to
> remove the legacy support for that board. This patch removes legacy
> support for the boards that are converted in the series.
>=20
> If I don't remove the legacy support, both DT and legacy side will be
> ran, and both create the DSS devices...
>=20
> But, it's true that this patch removes the whole file, as all the board=
s
> currently there are converted. But if new boards are added to the DSS
> quirks, then I can't remove the file. So I'll change this patch to only=

> remove the parts for the converted boards, not the whole file.
>=20
> But but... If I understand right, the plan is to remove all omap3 board=

> files for the next merge window. I'm not totally familiar with the
> quirks system, but how should this be handled:
>=20
> omap3.dtsi will contain the SoC's DSS nodes. This means that DSS device=
s
> are created via DT code. But if the display (i.e. panels) for a
> particular omap3 board has not been converted to DT, we should still us=
e
> the legacy DSS initialization. But the DSS is already initialized via D=
T.
>=20
> I guess I can set the status for all the DSS nodes to "disabled" in
> omap3.dtsi, and that should prevent DT code from creating the DSS
> devices. Then, each omap3-board.dts that has been converted to DSS DT,
> can override those to "enabled".
>=20
> That way the DT code should not create DSS devices by default, and the
> quirks system would probably work fine.

I changed the DSS DT nodes to be disabled by default, and I think this
works nicely. It's actually better this way in any case, as we can leave
blocks like DSI out for boards that don't need it.

Also, I now remove the quirks only for the boards that are converted to
DT, not the whole dss-common.c file. So I think we can now add new
boards to dss-common.c, if and when there are ones that cannot be
converted to use DSS DT yet.

 Tomi



--KKO7gh8DnXFB67fN53B17JuaIku77kBLG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSsXcpAAoJEPo9qoy8lh71lUAP/2E6zlvatT9Wa2QJzH3EeqCO
sOpoLqIbdT09oOsSBtn6HsE5M7xmewoBobmgr+t1S/cLeODrPVRHCnx9lTEUJEPZ
TKQZalYVF+G8B0QSFGFmqWdFsbxo+wudcv/TFE8XVrSrQiqAwkLh0lCyph+KqvFy
u8rwOui6IPCLsT2ecqxshXE7FbYuyW1kYnUzNb4KRWw9hN2740I18KavlM6qzu83
6L+DeftRIufhRvD3Hhu+TCLfaqbNGB1dpasP90AGPgrkzh3hUL0aM8ZqbjA4ePlQ
UkGuviFVNcnPjJZvogF83WAt8tXepEEklnNOrKxSKzS6m3AfbUO8cnQWgG0mdHzZ
YBDv4/Svq7RdpzSfk0XAZ0PWOM6jRq2A74IdG/8x9ySxNSAutB4YIGS8VHwrxKsJ
bL9FlJ6ZUSn3wSnGcVw1M8YF/Xve6GVAhFlstkaIkUnck6+d34Di7W9NYUlG/GAl
F0pGE3UsHQJrbK1xcr0rMW0AK+zKmbGmMami20A4/7HL5SP5jwXQADyGI99ugVgK
Ut2r/40asIO+ge4kQWJ3lP/inHOuYuuHrbszd4VNXjmYyeV7kYd5Rbqz6SH7wax7
YijHAwEcFsrIy3zBJhqtecX9azh2xKiKuCQugkJnrcz5oOqfbG1CjMPAQZWbYiGD
tFIy6MLwdgVVGa5zAA8i
=bBnQ
-----END PGP SIGNATURE-----

--KKO7gh8DnXFB67fN53B17JuaIku77kBLG--
