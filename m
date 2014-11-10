From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] arm: boot: dts: dra7: add labels to DWC3 nodes
Date: Mon, 10 Nov 2014 17:37:14 -0600
Message-ID: <20141110233714.GQ1041@saruman>
References: <1415032122-8230-1-git-send-email-balbi@ti.com>
 <20141110232709.GB31454@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qUsYCxAE223BCwdt"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58350 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751545AbaKJXhL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Nov 2014 18:37:11 -0500
Content-Disposition: inline
In-Reply-To: <20141110232709.GB31454@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--qUsYCxAE223BCwdt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2014 at 03:27:09PM -0800, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [141103 08:30]:
> > by adding labels to DWC3 nodes, it's far easier
> > for boards to reference them.
> >=20
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
>=20
> Applying into omap-for-v3.19/dt, had to update it because
> of "ARM: dts: DRA7: Move USB_OTG 4 to dra74x.dtsi". Updated
> patch below.
>=20
> Regards,
>=20
> Tony
>=20
> 8< -------------------
> From: Felipe Balbi <balbi@ti.com>
> Date: Mon, 3 Nov 2014 10:28:42 -0600
> Subject: [PATCH] arm: boot: dts: dra7: add labels to DWC3 nodes
>=20
> by adding labels to DWC3 nodes, it's far easier
> for boards to reference them.
>=20
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> [tony@atomide.com: updated for otg 4 move to dra74x.dtsi]
> Signed-off-by: Tony Lindgren <tony@atomide.com>

looks good, thanks.

--=20
balbi

--qUsYCxAE223BCwdt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUYUwqAAoJEIaOsuA1yqRE+yAP/iVLIlxr5+H9oVV5qwLKBh5+
b2W9rBZWN7NUxbr5+qM0p2ikow8HzgCsD54TfZE5XZL3dMGUIATi/9XUOEiiNzgx
InKLPfyOZEGghZLwFSQ+iaWk7h3dy7G/JILB84TiUwoDGiGLSut9eMqoN3YNGRPh
AtKFm+8V5DJRXW/d9WzgNqaPeOARVDvTKyqeiAa0FI1/Lvc+0OY4hH8bwAC5eJoE
4PyCSj/sEKnxyWlNY+o+pBAc81xvoGFEF1RlwSKrq7Nn3Fvx6yhqCNdx0gwvQvlF
W74MHchsg4gvca34ramD3PhZ682yCJhj6su1v8nHN6cEinfhRmhfB401rBpXP27v
ceiyGyU9OTlEp/+cZBqV5ux0gAUe+mtsdwApA2x4B4Sk3IsAr0TzHTdGekPTdxeY
SSD8gy4w3RIUNwJJLpbNqrmNKOfGbJRAvTBzv2Gh8WDxeeuhMlo75YyzZpeahFry
KdW2nAZwoLtvftxl2GYGW1OsbhUQIhDnggKkkV0ZxdVfP891meU6n+zjssVetLzj
Kc6SYUMpbJhk2rFGw5mctpDhrcwTz3tMc4eHsIH2nMxPMd1clfh24ThhYs3vpbZ0
cjol09oyLAw+qgKj528qResFnMCy6yZJkPpdIKM/yXQyId/79owDQ/QzT4AKu+XD
zWUx39t3J8/68OXOhrul
=yLnb
-----END PGP SIGNATURE-----

--qUsYCxAE223BCwdt--
