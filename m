From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/6] OMAPDSS: DISPC: Remove cpu_is_xxxx checks
Date: Tue, 07 Aug 2012 12:05:29 +0300
Message-ID: <1344330329.4091.16.camel@deskari>
References: <cover.1343912532.git.cmahapatra@ti.com>
	 <5344e530a125ef5c5dfeb00e54b7d32df6169aa9.1343912532.git.cmahapatra@ti.com>
	 <20120807084815.GK8468@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-IeQCYqkyJ2UJ2qbirqiK"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:38647 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750878Ab2HGJFf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Aug 2012 05:05:35 -0400
Received: by lbbgk1 with SMTP id gk1so2249133lbb.26
        for <linux-omap@vger.kernel.org>; Tue, 07 Aug 2012 02:05:32 -0700 (PDT)
In-Reply-To: <20120807084815.GK8468@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Chandrabhanu Mahapatra <cmahapatra@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-IeQCYqkyJ2UJ2qbirqiK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-08-07 at 11:48 +0300, Felipe Balbi wrote:

> you're not really removing. You're moving cpu_is_* somewhere else. A
> better approach, IMHO, would be to use the DSS_REVISION register to
> differentiate the DSS IP itself, not the OMAP.

Unfortunately we can't, DSS_REVISION contains bogus information.

I didn't look at these patches yet, but the idea has been to move the
cpu_is_* checks to only a few central places, not scattered all over.

At some point we could perhaps either move the cpu_is_ check code to
somewhere under arch/arm, or, more probably, create our own DSS version
IDs which are found out via cpu_is or soc_is or such.

 Tomi


--=-IeQCYqkyJ2UJ2qbirqiK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQINpZAAoJEPo9qoy8lh717DwP/AmdU5/9VoM9A1aXb4aNgD8T
/laQQKbBSF2mggGeTOKWzoqbf97p8HYzrVuzPa7i0hWxasj6RXx0WIuR12c8ZLoX
EyGBn9Oqb5tmcJtaAXhKd2LVUsf2OPjtWeNc+Nv1kJ6XJD0vxgHlEoPucc8dynzk
9pEu5sq3NVmnwCfF4bqyXJ+rBtMESK5BaK5nW1XHMHiQ9AdfWdCrWrRhU17Gll/m
qCP+cYrNSgYzZmj3UjxjfrlWQX4jou7m9PBhC0mqcYDoxWP0jb4VxBIgRMqb4mlx
64uz8woKkybVLwJxQgEom7ykwLWQGpChCvR3MLE8Hw/zQbxD0bezCV4VBLmblgBp
U9BEpbCPgUyS0FoPSMXol1QfhBM54/qBgCLdwoUyiydkDVd2zXW4ooBaoYPI9Rp2
6yFjfVgl3kPghDfDIvmQVAEc2QjpUmyR6x5H3gPxaafy5jeI8JlCxSZOOxkeaeRJ
KZkhX+KTSI+EKw5q5NX6GzKmA6oCkEmRqit8jIN3ycXuFZWy01qS69wyIoe11suI
199TTEfEkQWfp1nXwK9uExiR2jRyGLjvmT/YZIzxYmoafH/00LrGXOyeL6nGRi+y
RJrW78HNmDfj+3TDkbJa/VTfgDjIkcihc0jMM3VCp/szKGtK/CCFWHB/dHDkSRFk
mYv4U3v3b3qYFPedC27N
=3F0y
-----END PGP SIGNATURE-----

--=-IeQCYqkyJ2UJ2qbirqiK--

