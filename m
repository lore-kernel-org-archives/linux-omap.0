From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 06/23] OMAP_VOUT: Remove manager->device references
Date: Fri, 31 Aug 2012 15:11:58 +0300
Message-ID: <1346415118.18766.15.camel@lappyti>
References: <1345528711-27801-1-git-send-email-archit@ti.com>
	 <1346326845-16583-1-git-send-email-archit@ti.com>
	 <1346326845-16583-7-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-nHNPyOJ2Pj2gjdLn9OlO"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:49747 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752363Ab2HaMMG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 Aug 2012 08:12:06 -0400
Received: by lbbgj3 with SMTP id gj3so1164106lbb.19
        for <linux-omap@vger.kernel.org>; Fri, 31 Aug 2012 05:12:02 -0700 (PDT)
In-Reply-To: <1346326845-16583-7-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: rob@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Vaibhav Hiremath <hvaibhav@ti.com>


--=-nHNPyOJ2Pj2gjdLn9OlO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-08-30 at 17:10 +0530, Archit Taneja wrote:
> With the introduction of output entities, managers will now connect to ou=
tputs.
> Use the helper op for managers named get_device. This will abstract away =
the
> information on how to get the device from an overlay manager.
>=20
> Using the helper function will reduce the number of pointer dereferences =
a user
> of OMAPDSS needs to do and reduce risk of a NULL dereference.

Almost all the uses here seem to be getting the dssdev from an overlay.
Would it make sense to implement get_device for an ovl? That would
reduce all the ovl->manager ? ovl->manager->get_device(ovl->manager) :
NULL; code to ovl->get_device(ovl).

 Tomi


--=-nHNPyOJ2Pj2gjdLn9OlO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQQKoPAAoJEPo9qoy8lh71M0EP/0j1/LW5NpeZYwFt/wpq3DN6
BHB4XptEumKAv+yHLfx1zqIJovg17c1cZS47ndmSja/sgZJ4LyMwW9qD9GPF50CU
g7fMPkECwyGyjqWzuVm3jq2ItADOhrSsgqIIBB5RWBemPLKLqcEMsvMGcN2MhW6l
5xm0zdGq2pAiFfxiSq8iL73ide+2gCyBwv2HgQI5g5mJ3kNfmDO0XBGw1UBSfEx6
qQ5FQwXBap7A8fHfyfkG7i43C3j5lHRqeD3I0cIn0AI2ssetGWUlvpiUSMl47GN2
MGR0raRk1NBLfPB9D84/nOaT3+9elj4WGG56O9MgIchbgpVu6ldOhRguWn5upDDp
TzOHq3Yf92Z26XLJcOmRQvHULKTpXYBTvGjXcu7upf9u71AiK5Fy5ez8qmleN7XH
1w+Hkn/B/jurydYt5cdF/Ile+s5cWxiDKn7ND3vPPpBx4cFGezoeyMFrOwSsKsLI
tdXd1OA75qqPerc/koVFiwqk7PhKQWoPlfwOIhHzxx8MpCFFohbw7ET1WKH5htJn
jytB4JEfRxWKUB5WzNsHy/T3EhxE8WZCPAc06y/OOVvVGHHEhfAxqltqtGz6Y255
ke77lDdeEFbJavqYCrXepRlGN6o31y2L3xhdfLFjqcWmZnE5zDHfcuYii1tHL+Ef
FrX4wVp1ST2lvfsDteoX
=Tzlf
-----END PGP SIGNATURE-----

--=-nHNPyOJ2Pj2gjdLn9OlO--

