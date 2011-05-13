From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 0/5] arm: omap: usb: Runtime PM support for EHCI and OHCI
 drivers
Date: Fri, 13 May 2011 14:01:37 +0300
Message-ID: <20110513110136.GG11339@legolas.emea.dhcp.ti.com>
References: <1305122676-27236-1-git-send-email-keshava_mgowda@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TdkiTnkLhLQllcMS"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:33639 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758276Ab1EMLBr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 May 2011 07:01:47 -0400
Content-Disposition: inline
In-Reply-To: <1305122676-27236-1-git-send-email-keshava_mgowda@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keshava Munegowda <keshava_mgowda@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com, gadiyar@ti.com, parthab@india.ti.com


--TdkiTnkLhLQllcMS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 11, 2011 at 07:34:31PM +0530, Keshava Munegowda wrote:
> From: Keshava Munegowda <Keshava_mgowda@ti.com>
>=20
> The Hwmod structures and Runtime PM features are implemented=20
> For EHCI and OHCI drivers of OMAP3 and OMAP4.
> The global suspend/resume of EHCI and OHCI=20
> is validated on OMAP3430 sdp board with these patches.
>=20
> Keshava Munegowda (5):
>   arm: omap: usb: ehci and ohci hwmod structures for omap3 and omap4
>   arm: omap: usb: register hwmods of usbhs
>   arm: omap: usb: device name change for the clk names of usbhs
>   arm: omap: usb: Runtime PM support
>   arm: omap: usb: global Suspend and resume support of ehci and ohci
>=20
>  arch/arm/mach-omap2/clock3xxx_data.c       |   28 ++--
>  arch/arm/mach-omap2/clock44xx_data.c       |   10 +-
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  184 ++++++++++++++++++++++
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  153 ++++++++++++++++++
>  arch/arm/mach-omap2/usb-host.c             |   99 ++++--------
>  drivers/mfd/omap-usb-host.c                |  236 +++++++++++++---------=
------

same for this series. Part goes through linux-omap and part via mfd
tree ?

--=20
balbi

--TdkiTnkLhLQllcMS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJNzQ+QAAoJEAv8Txj19kN1b+0H/iBu1+Hi2qRUyfYs+QKJal09
AODz5C6xNXORi6AQMVUSCmj3ql2OY2RG1XrABw0nklAO5Tq85SJL/7yPMjeBhKNf
SE3Fj3pjHlFrrzrg3VMdyQlVvMSf6Z1nF+tKrfOUMtw0oki2tEYrGP2ko2bnkIMd
w6WS0GhzhX0ZOchWu2YuKPmKK6aStlxYN2aNik5G5kdKoweAuezfzN15UTdAyg0A
4DcN1Xnmm3X6PHjdw6bos7kxv5mfxlFDqi6qepPpks5xbGeU7aFKRTh0VaC6eyMd
Hi57EsHxIe3tsLgjpv7SOnrZob+6bTz+3zfchuseiRVSz6OkEkzaoux93AucVJo=
=iM65
-----END PGP SIGNATURE-----

--TdkiTnkLhLQllcMS--
