From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: OMAPFB: fix framebuffer console colors
Date: Mon, 06 Aug 2012 09:00:16 +0300
Message-ID: <1344232816.6227.0.camel@lappyti>
References: <1344097153-13903-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-mUp0BzeelIlxb/ujQ1CQ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:48796 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752589Ab2HFGA1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Aug 2012 02:00:27 -0400
Received: by lbbgj3 with SMTP id gj3so3615544lbb.39
        for <linux-omap@vger.kernel.org>; Sun, 05 Aug 2012 23:00:24 -0700 (PDT)
In-Reply-To: <1344097153-13903-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org


--=-mUp0BzeelIlxb/ujQ1CQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2012-08-04 at 19:19 +0300, Grazvydas Ignotas wrote:
> omapfb does not currently set pseudo palette correctly for color depths
> above 16bpp, making red text invisible, command like
>   echo -e '\e[0;31mRED' > /dev/tty1
> will display nothing on framebuffer console in 24bpp mode.
> This is because temporary variable is declared incorrectly, fix it.

Thanks, applied to OMAP DSS tree.

 Tomi


--=-mUp0BzeelIlxb/ujQ1CQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQH11wAAoJEPo9qoy8lh71SQYP/1atM+iiIiOkz7l6O7tOr4XS
tSzMdQ+rm7Azh2/LQ8Iw0f5NStvK47phWgBUW35NGPqEEL6yyfmFBx7ylKbJBsYd
OEY4P3C3Vr66HM8wnpAQa0Q8ZPpj3gMJc+BL574Z8ZwSs0zCPg5h8f+nbp0WqPQe
ba3BBixNMb1QgwwAkJGlE1rSo7HbAPNqFU25ZmEZipWb898Mkjy4eaz7yoPeAoFy
65kn1sejlAf4JIIHZg9UKNgaWP/mK02prD04wvvNrDNe+LE9GJE4Mrx1zC8u+Agv
1lY6D+xrYXPS8Jikwmj0Bk8cuitaC/T4RLBojNvDCNDiX4VdHyKsARcnw/43GOIR
+tL4GoOEDd7nMRJlL4pb9UQ6qUE84i16Anzcrljda3xnUSiUOzwO2gbZijAGetOh
v3yiUvAcTJbwAbYStoZOgJcAScCLNt68znHZDrvsz73IzpJPsJwqBhoyIoR568oa
ZV4xZJKq68ieNPy66xnD+tgKbcqF4waNz02uhgl4mkbgtBmgCHSBP2adiTsDjJRn
WqLb08+Ldo6NQtfFN/m+ID49kcPC2iI3FVxfU4oOjRLChzt5GXWj/AWPyLzg49eG
0RjeiHFq1Ccs9qBJWyn8x2BI2zUwid1Mcpg2Lp0pE5c85q86cTfmQ7eKXdxs6uAg
rVpEoW3NURzbxr3rKfvn
=DRxA
-----END PGP SIGNATURE-----

--=-mUp0BzeelIlxb/ujQ1CQ--

