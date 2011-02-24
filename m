From: Markos Chandras <hwoarang@gentoo.org>
Subject: Re: double_buffer_not_ok compile error
Date: Thu, 24 Feb 2011 13:31:59 +0000
Message-ID: <20110224133159.GA28332@Eternity>
References: <4D6261C8.1090605@matrix-vision.de>
 <20110221132438.GD23087@legolas.emea.dhcp.ti.com>
 <4D626E93.3070501@matrix-vision.de>
 <20110221135613.GF23087@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:34740 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751742Ab1BXNcN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Feb 2011 08:32:13 -0500
Received: by eyx24 with SMTP id 24so181825eyx.19
        for <linux-omap@vger.kernel.org>; Thu, 24 Feb 2011 05:32:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110221135613.GF23087@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Michael Jones <michael.jones@matrix-vision.de>, linux-omap@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 21, 2011 at 03:56:13PM +0200, Felipe Balbi wrote:
> On Mon, Feb 21, 2011 at 02:54:27PM +0100, Michael Jones wrote:
> > Hi Felipe,
> >=20
> > Sorry, thanks.  I tried to avoid getting that reply by searching the
> > mailing list to see whether this was already discovered.  I searched for
> > "double_buffer_not_ok" and "musb_host" on the mailing list but didn't
> > see anything newer than the original patch.
> >=20
> > Where is the correct place to search for such a recent fix?  Where is
> > Greg's queue?
>=20
> Yes, Greg's usb-linux or my gitorious musb branch.
>=20
> --=20
> balbi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Hi, thanks for that. Ran into the same problem whilst trying the
linux-linaro-2.6.38 tree. I hope your patch will make it to this tree
soon

Regards,
--=20
Markos Chandras / Gentoo Linux Developer / Key ID: B4AFF2C2

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAEBCgAGBQJNZl3PAAoJEPqDWhW0r/LCKVEP/AirS6sb1pAbcJLNRm0rN7UQ
LBWu+RtjhNs4XhRyLdFx/qylK0Ugw7yjz9dtXW6YvWuED9TIC5KMUGH5omKM5Mwh
WdyKspZLZbRI5g4LWvFJk9ObWHlpMHvvTP+SZU7nPxP3A2ogg7yMzwxrRW9/H9wB
1gc7tSv+KFh+WZBfiGd9FUtFBp5UJ2PfBTBLBzk0cRJuPsrG8OvFlFzB9/qqElM4
zPnw6FGPFOo/puajjc6CyOLQxPlL6RwQKLUyNBasIswmPLmBoK9iFLjQ1fg+0ZJ/
KiqrqnyJy2L6zGaFAH0DjV1G1BCx0zB9StOB6+S1XOXHPIMx4OnIwZkEghvxLyNV
94QH0tJcYxZET9ZvUxB5uLiKYfOmzsO8DvNAJZF+OEu19DN9nEO0qtvHCwc3fmYB
PGw2brgKRyv49vnAiorP0p001PjmIGs8ts9Ki1CYeeaXkK3QNDS8Hg6KBJAj9DJK
Ez1cXF+qJt2uiWY9R8eJyxnxLpsp9W9phEJOY5ANaJk8VNWV6tieoGY9F+SPfcvr
ocgkuWY0PXt4qgqPqAi4ZIidfdQdaCBdul37vpZY1pnjivyj3CqiDgohpp0yi1Un
89fir3yvno4WTSAbWRFYmvIu3qhIBrfwCFup05bd7ClKvikj92zDtnkgdWa6QJm/
CFwN1F4OZUA/cAEJ+ASJ
=0WKa
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
