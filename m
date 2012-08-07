From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/6] OMAPDSS: DISPC: Remove cpu_is_xxxx checks
Date: Tue, 07 Aug 2012 12:27:52 +0300
Message-ID: <1344331672.4091.22.camel@deskari>
References: <cover.1343912532.git.cmahapatra@ti.com>
	 <5344e530a125ef5c5dfeb00e54b7d32df6169aa9.1343912532.git.cmahapatra@ti.com>
	 <20120807084815.GK8468@arwen.pp.htv.fi> <1344330329.4091.16.camel@deskari>
	 <20120807091415.GN8468@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-bcXj/qwE6WL3BVU80c5y"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:51555 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753523Ab2HGJ15 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Aug 2012 05:27:57 -0400
Received: by lbbgk1 with SMTP id gk1so2034125lbb.12
        for <linux-omap@vger.kernel.org>; Tue, 07 Aug 2012 02:27:55 -0700 (PDT)
In-Reply-To: <20120807091415.GN8468@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Chandrabhanu Mahapatra <cmahapatra@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-bcXj/qwE6WL3BVU80c5y
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-08-07 at 12:14 +0300, Felipe Balbi wrote:

> Or you could use the driver_data field on the platform_device_id and
> of_device_id structures for that. Something like:
>=20
> static const struct platform_device_id dss_id_table[] __initconst =3D {
> {
> 	{ "omap2-dss", omap2_dss_features },
> 	{ "omap3-dss", omap3_dss_features },
> 	{ "omap4-dss", omap4_dss_features },
> 	{ "omap5-dss", omap5_dss_features },
> 	{} /* Terminating entry */
> };
>=20
> then, on your probe, you just need to copy id->driver_data to your own
> structures so you can reference them later. No need for cpu_is_* or
> soc_is_* or machine_is_* anywhere.
>=20
> On your platform_code, wherever you create the dss device, you need to
> fix up the name though. The platform_device name should match
> platform_device_id name, not platform_driver name.

I've thought about that, but we need versions even for different OMAP ES
versions.

So in the device tree data we couldn't have the DSS nodes in a, say,
common omap4 file. We'd need separate DT files for each OMAP ES version.

 Tomi


--=-bcXj/qwE6WL3BVU80c5y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQIN+YAAoJEPo9qoy8lh71ANMP/2yzqeJ0UosGdDNH3Cq4kpv/
J7MBEd8ZkmJuL6dCnbujimnm+n61+BvzTYhLlqj6lulgM3vTrkr5np2nQo3AgYaV
mnxnWzVLfII7cmhE+U8tDWsWGCzL+N0mxYTjU8Vp52lqs6TD1RK5ICzCMLXfbWGR
D8iRpyjSoSeSp6rI+/f9K7rSZivJI+Sq0LVUfDOF4p+iiEvirrv19fYeA1kpzEBt
TAus1A2rqagM/jIVLOqE0rJr0kTTwulaOjomBcz/MoQ6QO3y5QcqfcBl3Z+5Eiib
lm4ZSZhd12QDbEDey6y5JYdprTDz/9eF74Qic7e3tw4RRamVsayy46/fupVGdj9c
SL1R/aotzeC8F+qAIIqpF8GQa59LCz/efzxar5iLTwENDDEjrJPRNm+DlFlJy52v
OgZplC+MFPZTqg1uhTlKRmX5wQE4orUUJqhP8mt//B6GU7p6qVvWd+lisIGpzv69
j1TYwOwdwpwLFH+ll4UAFOWxBePuyR6dXYLLWH8dpwZanQTJ3ZKPD7ooEArir7Ku
jSrAVTShwy0q7wJ7EINQhG+Tbn55Dy6SPwR3Is6thLrjGkt5jBBOZH2HsGoA9rUg
KqcupRdMXZFXWf8twAsgzlOKUubF1mE+8KiWg7eIiJN8UsRSXKIdB08T/ryLEwqk
t9A9Rk06RQg5bjv6xbge
=0Hxk
-----END PGP SIGNATURE-----

--=-bcXj/qwE6WL3BVU80c5y--

