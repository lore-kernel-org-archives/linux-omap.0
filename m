From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: MMC broken on beagleboard with current git
Date: Thu, 25 Sep 2008 10:41:20 +0200
Message-ID: <FDAFB709-68B8-478D-8321-1322449B9A7F@student.utwente.nl>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-3--788254875"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx3.utsp.utwente.nl ([130.89.2.14]:51065 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751651AbYIYIlb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Sep 2008 04:41:31 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>
Cc: beagleboard Board <beagleboard@googlegroups.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-3--788254875
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit

Hi,

I just built a kernel from current git[1] and the mmc controller  
doesn't get detected on boot on my beagleboards. The omap mmc system  
has seen a lot of changes lately, does anyone have a hint where to  
start looking before attemping a bisect?

regards,

Koen




[1] http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commit;h=c434c15d28c82d92e55897bd265c423e9ab69362

--Apple-Mail-3--788254875
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFI206yMkyGM64RGpERAqR4AKCE2aazlIKSSBNKVI6zxEE4EiR9PgCdE9sn
R/lDfohLhx6YGC/1HyN8v4A=
=RCOr
-----END PGP SIGNATURE-----

--Apple-Mail-3--788254875--
