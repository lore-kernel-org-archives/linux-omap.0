From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC 0/4] TWL external controller support
Date: Fri, 8 Jul 2011 19:25:32 +0300
Message-ID: <20110708162531.GE31978@legolas.emea.dhcp.ti.com>
References: <1310140588-26078-1-git-send-email-t-kristo@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lkTb+7nhmha7W+c3"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:37586 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751136Ab1GHQZg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 12:25:36 -0400
Received: by mail-bw0-f42.google.com with SMTP id 19so2113912bwa.29
        for <linux-omap@vger.kernel.org>; Fri, 08 Jul 2011 09:25:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1310140588-26078-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, lrg@ti.com, broonie@opensource.wolfsonmicro.com


--lkTb+7nhmha7W+c3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi,

On Fri, Jul 08, 2011 at 06:56:24PM +0300, Tero Kristo wrote:
> Following patches add an external controller support for TWL SMPS regulat=
ors.
> This is needed because OMAP has voltage processor support which provides
> interface to control a few regulators (VDD1 / VDD2 for OMAP3), and this
> is shared with smartreflex.
>=20
> These patches work in a way that twl regulators now provide an external
> controller registration interface, and this is used by the OMAP voltage
> layer during init. set_voltage / get_voltage APIs now check for presence
> of external controller, and if it is there, calls are routed to external
> controller.
>=20
> Baseline work for these patches was done by Thomas Petezzoni.
>=20
> Any comments welcome, does something like this look like it could be push=
ed
> to regulator framework?

isn't this all the same as claiming the regulator but never actually
using the regulator APIs ? I mean, you could add the regulator, then on
smartreflex code, regulator_get(), but when it gets to get/set voltage,
you use the omap_*() functions instead of regulator_*().

--=20
balbi

--lkTb+7nhmha7W+c3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOFy97AAoJEAv8Txj19kN1GN8H/RrwKW6zwM6xw4pBEDWb3W2L
3r9xS+sMynQB/B4GQvWjRMpfnJNA8muAv6DyubYARsd5e/Df7zpbNBiy69c6QSeg
UXr9DixhaWkhDHRO56mSq+N5XTgwT44bbxktWZhSfj7/W9AvlAL9iLlXWfJ+bE9F
3gbUG7rslRhLnNVrPrWL27mHpw/y+PZx/5BQgQbMnCOdo+5WtWjeDwraKE3lqJCW
n28XM8sD91SuWbpLrUX5nfzM75Zs7T6adR5l7/EQn+4kiltz4Wo6SweS38LFuO4G
/jLCW40jUHcIbjC5f7XVayFUx4w+uXNiSRaYFg4mZO77W1cbo52H8E+3Lh7FPVI=
=pvyH
-----END PGP SIGNATURE-----

--lkTb+7nhmha7W+c3--
