From: Daniel Stone <daniel.stone@nokia.com>
Subject: [PATCH 0/2] Minor display fixes
Date: Wed, 27 Aug 2008 04:27:36 +0300
Message-ID: <20080827012736.GA10868@intune.research.nokia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:63828 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693AbYH0B0o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Aug 2008 21:26:44 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m7R1QX1B004153
	for <linux-omap@vger.kernel.org>; Tue, 26 Aug 2008 20:26:42 -0500
Received: from intune.research.nokia.com (intune.research.nokia.com [172.21.50.54])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m7R1QRh8031127
	for <linux-omap@vger.kernel.org>; Wed, 27 Aug 2008 04:26:27 +0300
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
The following two patches fix two minor display issues.

One is that sgx_fck was useless, and didn't work (at least on ES2.0 and
above; haven't checked the TRM for pre-ES2.0).

The other is that the dispc IRQ handling was rather odd and inflexible,
so due to the needs of ... an external consumer ... I made it a bit more
sensible.

Tested on 3430.

Cheers,
Daniel

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAki0rYgACgkQ68xJuWtYYdUzFwCeLjgsRrOW18ePBbxHWYY7UvMY
QEMAn10pyA/+6y8NTsoAXoMjTwmR5r0z
=2CRy
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
