From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Help needed with remaining plat headers
Date: Thu, 27 Sep 2012 13:07:26 +0300
Message-ID: <1348740446.2913.3.camel@deskari>
References: <20120920232907.GN28835@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-ulSA7l9maO+Q17XN0f5h"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:51023 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754494Ab2I0KL5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Sep 2012 06:11:57 -0400
Received: by bkcjk13 with SMTP id jk13so1474735bkc.19
        for <linux-omap@vger.kernel.org>; Thu, 27 Sep 2012 03:11:54 -0700 (PDT)
In-Reply-To: <20120920232907.GN28835@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org


--=-ulSA7l9maO+Q17XN0f5h
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-09-20 at 16:29 -0700, Tony Lindgren wrote:
> Hi all,
>=20
> With the recent pull request I sent for v3.7, we now have pretty
> much all the mach includes fixed up for omap2+ for single zImage
> support.
>=20
> We still have quite a few plat headers that we need to sort
> out manually.
>=20
> Please take a look at the following list, and reply to this
> thread if you are working on patches moving one of the headers
> in the list so we can coordinate things. The rules are simple

> vram.h
> vrfb.h

I'll work on these ones.

 Tomi


--=-ulSA7l9maO+Q17XN0f5h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQZCVfAAoJEPo9qoy8lh71z0sP/ibjYpFz185tD4v8hhUNDb35
fqPugBIVmBTcWAjcRn+JtXdYPVgLt48PrR+2eU+d9KOO8X+vWbacuWbH/vWjBxhr
f3YiZb8g86/DrSgCXhmdTC01XK+NNmASslEa51cnNKVUWLCWaw046R9kK6/m0GKP
fL7JNllqV/EQCvJLeE+QEoCtwZf9L8BmgZ2SXnk1V/tJ7JEHU8Ze8wWKtWX0OFWK
k54yJaRwOMg7eLhEsuO2eMpL4FhyvvnP4DJBBmHt7rR935MYKjvkOZ0W4uPB7Rur
rmsw+Z2q6WvS19zKT48KmGyapvrpVnkPpVeW6lZaPzFL7J8dLiMlsBd6IzHRajH5
I4r/Km3Gw9B8fZZuyivyb4oAV++5lcbRV5HhJ2K3/rOdLwbI3xy54cVk/ClARS8T
YtbRJAi2PDc/+kojO+zxwKwCpQBJzI16SC56lOMZwqtkll4NV596ruN/9s81aSoy
j+tl7s2KDDrhqAsUQVHdtUMqs9dikrtl1HOULzKJjenPKAsKxQbIs7x+0xRYTyXy
8dk8a7YJnZXRrjyQRO0eZbvWlfJpXJF+SDjC+JWFw/MMS0m0MjTJRsAlnkFE7tbp
EaB13nDfZvLV7OTD5UoLCTiS+eaUQ06ZH1NiGnWqTMyZjWcLOrOLkLYYInBZxRCD
tFfyChF7vthnFedadnJL
=TL7r
-----END PGP SIGNATURE-----

--=-ulSA7l9maO+Q17XN0f5h--

