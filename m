From: Sebastian Reichel <sre@debian.org>
Subject: HSI: any status updates on omap_ssi?
Date: Sat, 21 Apr 2012 12:52:35 +0200
Message-ID: <20120421105235.GA3296@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:44845 "EHLO ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752142Ab2DULWw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 21 Apr 2012 07:22:52 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Carlos Chinea <carlos.chinea@nokia.com>
Cc: linux-omap@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Missing omap_ssi support is currently the most important missing
feature, to make the mainline kernel on the Nokia N900 useful, see
also [0].

Can you prepare SSI inclusion into the mainline kernel, now that HSI
has been pulled into 3.4? Do you think we get SSI support in 3.5?

[0] http://elinux.org/N900

-- Sebastian

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPkpFzAAoJENju1/PIO/qaDAAP/0K9t8iuIgMYVsGHIVgzT6ln
xOOy8Zy4j3I+xI7i8jqbRP2AvDBb0JqFi9qOy8ZiiyiGh5mwTUMf7c8LlJ1L2N19
W9oGA7NdtXLAvxV1lNY4V/ZAOgeFP4SEDsS3DjG3tZ3FobQiyelnuwKF7sReCZaS
71Lo5oxU8r95AfS7hM+Dele5g1sK0nxTOJ3LhCEDIqnF9fUdMDi13RPu8594+HZY
nykcy6rgpvXiR24e/xxi6Y8Y7iBfWMlrmjtACnAXrtwqF3rwwSaoE8VevC//F2Tw
q5fDhD1kfZcAa/ThvgstiEah+9RzyKQ8oAX00HYyGGld9fukgmkmIuPyK3c9xfIi
85hOeEcNRlBFGjmo71smXfST/orziAYe70qOyQMgClbO+fKfs+yk+RcfF0X/zz4/
oD0TRinjCihrtSgYSo67St0W7IjgxCohByxpNRb2LDaKUr6XMaj3b+oh/mK0KuCO
vEdGqsPGN/sq61nmonspFoAHzyuuuVAC90gvSMewyzmKAUPbToRpAe+W1eGuwszG
l2qUn5Q171VnSuUMe8GlA4JBTKBq6rAgrfX7bVZ2up3HuzJY17gTbdvHtBjy2VI7
r72qIIAmsFrYGd0siQnN5q1IwbQW25IAGIOMIOO5QhC2QeDUMkVNJ3YpLkI1hJmE
gDp0Kivwb0yc86xWYyrx
=tGGa
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
