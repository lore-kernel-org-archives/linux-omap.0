From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 14/19] ARM: omap4-panda-common.dtsi: Add HDMI audio nodes
Date: Fri, 16 May 2014 12:08:50 +0100
Message-ID: <20140516110850.GS12304@sirena.org.uk>
References: <cover.1399884780.git.jsarha@ti.com>
 <fdeddff24bc38efb7a155b2569a5f2056278cb9d.1399884780.git.jsarha@ti.com>
 <5375F0CC.8090507@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZVCaZf8y6aNouToH"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:58871 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756827AbaEPLJJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2014 07:09:09 -0400
Content-Disposition: inline
In-Reply-To: <5375F0CC.8090507@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, detheridge@ti.com


--ZVCaZf8y6aNouToH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 16, 2014 at 02:04:44PM +0300, Tomi Valkeinen wrote:

> So all of the above .dts changes are already implied when we have HDMI
> video on the board. Is there no way to prevent every board needing to
> add those exact same nodes to get HDMI audio?

You can always instantiate devices directly from the HDMI controller
code, there's no need to put things in DT at all.

--ZVCaZf8y6aNouToH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTdfG/AAoJELSic+t+oim9c2AQAIHIJ8T0B6vCjx/HrREqf9lt
+YCEm3jEfL+GCCDraM6q4l0O+4BgWyF3qJmUET4VKp6rq6bHCGzj2PXugtlL9pkt
TjwGyolUuP9nB3z/7Le6WKePMVlcryI91oHdTkzOY9B8wnBJgPNIkASxDVDHhFNi
AZTGJKqF0r2cefKZygd2dCkasrxAFbveEgpPDPN+LEpCzaTMeJtghkghrVlAKxOp
rNduwvZNa7IIJAaA8wp5KvMraj+C9r4Wtr0dLFiwDdzyyVIOjH3t2Y3PLqYYKT/Z
7RwV1szt2sd3FvBXTBNmHGanZ9hsgVP/neiKhCWHT4s8ksSH/92hLaH5HgDheNgc
lbMAAfBoDJdpJWtOHcAj4F7hMVYYm8GHY44mHmWIZF2IYq9LoNUQEVixJTwnvaPY
mj0D37uyfBLFHSu1QST3b9QUiUjSTaqsDTNcIyDlE6tF4lOz/yd2pYKB1/sU/ixC
eEMmtsRHwXtrGi8AWInmcL2uI+psVrg5k1qU7r0OjBxti9RvdQ4tPe+C2R5c3py0
HPOsMvL00RMvCgjlStvOjd9EFX10AIS8uvFmoZ8Jny3yHe5CWfS6qH8tcYC1VPCw
3QA1BXoUMKkE/H/ow6tU9vIosignbhL47wEU/+Se3JfvK4idAlC5C/Uv6DwD57AU
/+y16w+Tj3rxTUrBTdv5
=Odjx
-----END PGP SIGNATURE-----

--ZVCaZf8y6aNouToH--
