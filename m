From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 1/2] ARM: OMAP2+: HDMI: Relocate audio platform device
 creation
Date: Fri, 16 Nov 2012 11:04:42 +0900
Message-ID: <20121116020440.GL4387@opensource.wolfsonmicro.com>
References: <1353029819-21809-1-git-send-email-ricardo.neri@ti.com>
 <1353029819-21809-2-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vTUhhhdwRI43FzeR"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:45652 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751048Ab2KPCEw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Nov 2012 21:04:52 -0500
Content-Disposition: inline
In-Reply-To: <1353029819-21809-2-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: tony@atomide.com, tomi.valkeinen@ti.com, lrg@ti.com, s-guiriec@ti.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org


--vTUhhhdwRI43FzeR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 15, 2012 at 07:36:58PM -0600, Ricardo Neri wrote:
> Creating the accessory devices (such as audio) from the HDMI driver,
> allows to regard HDMI as a single entity with audio an display
> functionality. This intends to follow the design of drivers such

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

--vTUhhhdwRI43FzeR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQpZ5FAAoJELSic+t+oim9ktEP/3JloWjll7HZkAaKIeDS3/dC
6D2yAoONmfcNPNjud2UsbguII2JiRvCokHfNph+UsjKfYJz3YdcXhoqMalg23Kml
rorKWGh8eHvhxCh6IcsuwaPVPSVbojngpoTWUpWC1LNEi3FFCYZDYJF5wYRVXOp7
PqrXa92sdfZAMGfRfxSNGAHGiMNBFGpP30h6UNdREXC+8UOuoVd2grcUwathDUiW
yi/0XLwUN0QyJMA7crYoRw25lAHZx0NTIV0yhH93ilOkLiYICi/vhIaUT3qlfURh
KYT86l1IPtvrbBBUNkAMBLQX0pQnRBjUOOnlN5jXCRnT1acZ7n1ceQqO9C1QeAsd
SfN3V2pLvPY4nqFXyb1LWVM4IajUTDwLpCZoK5sRrOQxGtwktB0Nx42a/UQ13+4y
m6/xxYSKgR6AeUVBD23sEM07s6vNIDCKVTc/ysVkV7voXQvrMUEtr+N5/cO9RFoS
tLfoe+rqs9wMomAOlxkNqfx0B2fyaHSmqkwvXWaYAEHtegzEUDTLlqIAq0z3v86l
YdP5XKtaEnIVSHho61zt+kOPx4dYZPmCRI1Qsp3Racm8EeB/P1S+3GAtGQZIQyxs
bkOjR9UF/rlUO+1kcI1412JC4yTwMGhNsaqxzrnicG4N1ZUC3cYgPsw58k2j/SqP
f3Hs6uceHL3zpo0o05Gn
=gQYF
-----END PGP SIGNATURE-----

--vTUhhhdwRI43FzeR--
