From: Felipe Balbi <balbi@ti.com>
Subject: Re: [GIT PULL] USB patches for next merge window
Date: Wed, 18 May 2011 14:42:44 +0300
Message-ID: <20110518114242.GI13908@legolas.emea.dhcp.ti.com>
References: <20110518110353.GH13908@legolas.emea.dhcp.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IbA9xpzOQlG26JSn"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:49127 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932763Ab1ERLmy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 May 2011 07:42:54 -0400
Received: by fxm16 with SMTP id 16so1253472fxm.23
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 04:42:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110518110353.GH13908@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>


--IbA9xpzOQlG26JSn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

forgot to Cc linux-omap. Sorry

On Wed, May 18, 2011 at 02:03:53PM +0300, Felipe Balbi wrote:
> Hi Tony,
>=20
> these patches are for 2.6.40 merge window.
>=20
> The following changes since commit 693d92a1bbc9e42681c42ed190bd42b636ca87=
6f:
>=20
>   Linux 2.6.39-rc7 (2011-05-09 19:33:54 -0700)
>=20
> are available in the git repository at:
>   master.kernel.org:/pub/scm/linux/kernel/git/balbi/usb.git for-tony-next
>=20
> Keshava Munegowda (3):
>       arm: omap: usb: ehci and ohci hwmod structures for omap3 and omap4
>       arm: omap: usb: register hwmods of usbhs
>       arm: omap: usb: device name change for the clk names of usbhs
>=20
>  arch/arm/mach-omap2/clock3xxx_data.c       |   28 ++--
>  arch/arm/mach-omap2/clock44xx_data.c       |   10 +-
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  184 ++++++++++++++++++++++=
++++++
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  153 +++++++++++++++++++++++
>  arch/arm/mach-omap2/usb-host.c             |   99 ++++++----------
>  drivers/mfd/omap-usb-host.c                |    2 +-
>  6 files changed, 392 insertions(+), 84 deletions(-)
>=20
> --=20
> balbi



--=20
balbi

--IbA9xpzOQlG26JSn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJN07CyAAoJEAv8Txj19kN1pWQH/3GQ9mMCLwI/23ecn7aLD7zn
4T4eFwY63++MhJxXLuTL/OQetR0LFNz8jS1eHFQQxgGuba3yRnFmR1xUf1cctPph
2nOIShOIQ3WuITxMhAO/QBg4bUPmNjkHe7jO7Yjec+ITp6gDtUBcOMsrhucdHWtX
J3r/lWXzAlhcFIHiL+2hEJGdmpiG1Wc78gT3jOu104Exuldhbz0QeRtdgTFAUXFc
WEAQfy36UdGN3RTYMgOSYgzn8mdzYSVuCOH8cVBoToiazvK4o2L/pXMzeibcvmo/
6utwUyf+lCVymseKtWvbYiUm2VkWd9a/iEcW6A3yygTaHj2kgKQB2xcts5TBnNw=
=2f6q
-----END PGP SIGNATURE-----

--IbA9xpzOQlG26JSn--
