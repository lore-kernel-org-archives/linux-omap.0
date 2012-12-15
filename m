From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] regulator: fixed: Properly use input_supply
 parameter from device tree
Date: Sat, 15 Dec 2012 23:55:37 +0900
Message-ID: <20121215145536.GG22033@opensource.wolfsonmicro.com>
References: <1352991396-19589-1-git-send-email-rogerq@ti.com>
 <1352991396-19589-5-git-send-email-rogerq@ti.com>
 <50A53E7F.6070705@nvidia.com>
 <50A6142F.1070404@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RMedoP2+Pr6Rq0N2"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:38475 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753260Ab2LOOzm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 15 Dec 2012 09:55:42 -0500
Content-Disposition: inline
In-Reply-To: <50A6142F.1070404@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Laxman Dewangan <ldewangan@nvidia.com>, "tony@atomide.com" <tony@atomide.com>, "b-cousson@ti.com" <b-cousson@ti.com>, "balbi@ti.com" <balbi@ti.com>, "keshava_mgowda@ti.com" <keshava_mgowda@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>


--RMedoP2+Pr6Rq0N2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 16, 2012 at 12:23:43PM +0200, Roger Quadros wrote:

> How is this supposed to work? How does phandle supplied in vin-supply
> map to config->input_supply?

You should provide a separate property to name the supply, or just pick
a fixed name in the fixed voltage driver.

--RMedoP2+Pr6Rq0N2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQzI9hAAoJELSic+t+oim9R0YP/iuyzuZ9C/kNOTgKiZOvM96Y
p2r1l5DhBlyT4EkrGs7Vw56sCndlTU8/Ul5k900K5c0IlN9kUMpXK7igsskPkU6M
7Sr8xK+tEkouw/zFim+Rk+C1Tc8t73VteOv+l6pjMpGVwD7Vo2Lple4f2a9sEheH
YxmVVSOVdsWobc9hRTfAugl8BT6ZoKZJ6qpl+/490l/CvB4AUJTJdaxh5c8Rn0pe
sB5mPX71GtGvFOYPcn1wUk5ebTJR4/MWcHA1LsPP8JdWiOhTE7hofl51hGc8hPCV
7QuP6hcMZ3mO26ZHcGjSY0rnX7/Vvqd1RKLBPjDMCyJlsarQUWt96PyxK+fHJDFw
+G39zEHB1iCvL+GPXqOodnANEpOLS3zqWULRi0lFpXL/g2UPWfAE93JT5MevI7w0
RlWQ1l077BsR3E9KqARDSDi5Wxy23PAblED+wNUZGsCbXq20TMPWN8zzcz4PQ+UI
gs5fWB15Hgxw4cY4l6b+O1WYWMPLqgaUzlgRXFmy6iJ/YGag/TTDhpDu6GSOR3lf
+7i1Bqi6MiXYWAWI+ew0X5LAWLzGgGLUHvTdptnvvSMT3aqSdmn3y8NoDEQBdxFs
8K/yf7aGXzgCzHVZ+vEHgyRLV7dxJz6+TN+bijq3rI/WIyju37PmODme/UssqaUn
tBBthAdBOSJMdB93tQ6F
=Bro1
-----END PGP SIGNATURE-----

--RMedoP2+Pr6Rq0N2--
