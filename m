From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH V2] OMAP3: hwmod_data: register dss hwmods after
 dss_core
Date: Thu, 12 Jan 2012 11:13:38 +0200
Message-ID: <1326359618.2065.4.camel@deskari>
References: <1324562563-27119-1-git-send-email-yanok@emcraft.com>
	 <1325028693-14728-1-git-send-email-yanok@emcraft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-GoHutrbst6vKIQvVrzsS"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:43971 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753103Ab2ALJNp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Jan 2012 04:13:45 -0500
Received: by lahc1 with SMTP id c1so987607lah.23
        for <linux-omap@vger.kernel.org>; Thu, 12 Jan 2012 01:13:42 -0800 (PST)
In-Reply-To: <1325028693-14728-1-git-send-email-yanok@emcraft.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ilya Yanok <yanok@emcraft.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, grinberg@compulab.co.il, sasha_d@emcraft.com, Archit Taneja <archit@ti.com>


--=-GoHutrbst6vKIQvVrzsS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 2011-12-28 at 00:31 +0100, Ilya Yanok wrote:
> dss_core has to be initialized before any other DSS hwmod. Currently
> this is broken as dss_core is listed in chip/revision specific hwmod
> lists while other DSS hwmods are listed in common list which is
> registered first.
>=20
> This patch moves DSS hwmods (except for dss_core) to the separate list
> which is registered last to ensure that dss_core is already registered.
>=20
> This solves the problem with BUG() in L3 interrupt handler on boards
> with DSS enabled in bootloader.

I can ack this patch as a concept. The dss_core has to be initialized
before other dss hw modules. I can't say if the implementation here is
good or not, I don't know enough about hwmod.

Paul?

 Tomi


--=-GoHutrbst6vKIQvVrzsS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPDqRBAAoJEPo9qoy8lh71ALwQAJs9ae0FzglqaX0AKOcsLEUr
ZzSJrWHs3R5mBZedwl7pKKwWRo0e+s5AZCSSMPw5JG1TPZSuV5aus2hY3mwN3nPM
TeiI9fKbnRdALGderXjQ0fnI0Du+TgSCGqvbxaAPSemjTkuKF2C75bssDFkPI+wW
PhmNPjmhPupBlCy90nWiPbxmkcx/75AQJyyLPncSaTf1CjAkdJtzDU/oYXfsyCCt
fcG9ZrT1nKJzgSju3KwbjTqzvJhArQtvMjA4a9dErsOmZN8ZZGCrIrwVJKGjEEFN
9XGGPND+HmKxQ+qP5ChuTT+Y7YHY4bXCVL3F9LZdGIULScTTTsD7mC1Bd00UnlGK
dzKf1vwaF/LMpKlQIu1rIhNkqPqcl9t6Yqm5/n1HgY88RWv9Ayyqeqfi4I5SakR9
zxeix8EFLR+PFadC5LjzP28cBz7+ZPvFhaUzw8X7Yo2ke8z40hp4UrSDcHWrwjzM
q9zShqPXDIyZzAzyN8oKQwknUsRLG8PNtjkfRdYakdxLuSvYbWlj/GhvUdy8gYCG
uvzKY/kPT+E6KelvaGw7x5Dys+KbcmyFRiRq7YYDipUzq2GOKrSCIcNwqyIB1Pho
kZu4a7RBrfEL60BHdhEnS/a2D7KzSlUcfFQtkF6i68Eup3ZpEKy3vZScqDg5BI0r
B6iHlTrfGZLJx+qHdcBY
=+GDJ
-----END PGP SIGNATURE-----

--=-GoHutrbst6vKIQvVrzsS--

