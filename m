From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH RFC 1/2] watchdog : omap_wdt : Implement
 WDIOC_GETBOOTSTATUS for omap3+
Date: Tue, 24 Jan 2012 10:33:18 +0100
Message-ID: <20120124093318.GA2609@pengutronix.de>
References: <1327317188-14782-1-git-send-email-shubhrajyoti@ti.com>
 <1327317188-14782-2-git-send-email-shubhrajyoti@ti.com>
 <B5906170F1614E41A8A28DE3B8D12143317901B9@DBDE01.ent.ti.com>
 <CAM=Q2ctL_Z5P6=NwAWBHD2bR=xqHMCF15g6v0Ap=hJMPdgXwyQ@mail.gmail.com>
 <B5906170F1614E41A8A28DE3B8D12143317902D6@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50072 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753929Ab2AXJdW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jan 2012 04:33:22 -0500
Content-Disposition: inline
In-Reply-To: <B5906170F1614E41A8A28DE3B8D12143317902D6@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Just returning the register content does not help much and looking at oth=
er
> implementations, like Blackfin, I am guessing this IOCTL is supposed to g=
ive
> a yes/no sort of result.

It needs to return WDIOF_* flags as defined in include/linux/watchdog.h.
Check also Documentation/watchdog/watchdog-api.txt for further info.
Yes, not all drivers follow this style, sadly.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk8eet4ACgkQD27XaX1/VRvemQCfdyCWZpduV2MQDzuGG5EzjvDo
niAAnigt6+3lL3UGKmLUTrEvbahfjJj8
=SE2R
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
