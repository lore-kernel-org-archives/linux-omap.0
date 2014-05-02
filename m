From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Display not working if omapdrm is builtin with 3.15rc
Date: Fri, 2 May 2014 14:59:08 +0300
Message-ID: <5363888C.5090303@ti.com>
References: <3A6485D2-7FEA-4C7E-9541-B814DFEE17A2@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="2vt28ITcA6JrjHnEvMnwU4ldCbhCMmjpu"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58433 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751763AbaEBL7P (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 May 2014 07:59:15 -0400
In-Reply-To: <3A6485D2-7FEA-4C7E-9541-B814DFEE17A2@dominion.thruhere.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

--2vt28ITcA6JrjHnEvMnwU4ldCbhCMmjpu
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/05/14 13:47, Koen Kooi wrote:
> Hi,
>=20
> I've been trying to get DVI on my beagleboard XM to output a picture wi=
th mainline and with 3.15rc it still doesn't work. If I statically build =
in everything the drm encoders and connectors all go into deferred probe =
mode and fail, falling back to 1024x768. I with omapdrm and encoders/outp=
uts/etc as modules deferred probe is avoided, far fewer error messages an=
d a 1280x1024 resolution is being used. But still the monitor still says =
'no signal' detected.
>=20
> So what's the magic to get an actual signal on the hdmi connector?

Sigh, looks like my beagle xM died on me while testing this...

The reason for this is that the twl_gpio (which TFP410 uses) gets
initialized really late, so display things get deferred. Then, before
TFP410 has initialized, omapdrm starts. It finds VENC (tv-out) display
available, so it starts. After that TFP410 gets probed, but as DRM
doesn't support adding displays later, it is never actually added to
omapdrm.

Also, the VENC output doesn't even work by default if
CONFIG_DRM_OMAP_NUM_CRTCS is 1. It needs to be set to 2 to support the
second output (tv-out in this case). But my board died before I managed
to test this.

So, the probing is quite broken. And I have no good ideas how to fix it,
only bad ones...

A simple thing to do for testing is to either disable
CONFIG_OMAP2_DSS_VENC from the kernel, or remove the svideo-connector
from the board's .dts file. This results in tv-out not being available,
so when omapdrm starts and finds no displays, it'll defer its probe,
thus getting the DVI next time it probes.

 Tomi



--2vt28ITcA6JrjHnEvMnwU4ldCbhCMmjpu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTY4iQAAoJEPo9qoy8lh710uwP/AnJ3eKkTsaUaFy2CJ11pfiT
KucuKHKK/M0YXhG1VkV70XHqDvm1Pd0IqN5uiP9i7ovXci+reCEdj/YGsiDvvBcM
xKaPk4xeSInf5W9aiz9ImINftUDvyI99qTyqbY2oIqt3d1O+zzJC65vz3qsUcFm/
s9ekFBn6I9hju0rwglrzyoj1C7pm+AY2ovUxiUW5mk8U6PHtyExSok8jPPR0BY7V
hUGmlnfgG/HRtQMGjfTwxdRxZk/5tZYmublYl+Lg0b2DaMxzAIaeTN3Xq7Hxjpcc
FIGsdBR3n3/9B8kEI6BQNOjB1oSohsl1jZr4RIwDZbTj9eSJlBH8vrZpV790Xco2
pXae2FwSwc9UnuRPM+nJD4g5Z1WGw1ecTUimPmPUh6DCN7mpVw83nhnBY6hR4GHr
qoCvxC77AQDOVDitMBFys916FSnNuU/TvGCOr72mNn7eJv2sxKCE/dFXWkGVOcul
qppmKm1u+bjaT16EZq+k7oAOQHJeITd/bFQHUXx4mRoLlG6pYTLTtxPkJthaedj+
KgwA3EwWCRS3b22oyJQdPxYbNTe7uzX6334HgpaN3GVAF1IMX0FvwdxXe+dampzO
HThnMpW8FR495yly29GNHsgf7z9zLr2sDQAYAPuZQlzXpILsXhOm5EJzSVN+8AB1
e0h+Pg2YjQnJSFVWFN3B
=7xf3
-----END PGP SIGNATURE-----

--2vt28ITcA6JrjHnEvMnwU4ldCbhCMmjpu--
