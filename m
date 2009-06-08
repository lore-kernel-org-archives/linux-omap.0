From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: What does CONFIG_SYSFS_DEPRECATED do?
Date: Mon, 8 Jun 2009 16:15:40 +0200
Message-ID: <60E83D99-69E9-4FD8-87DB-666241567879@student.utwente.nl>
References: <44D7A87D-CEE3-40F4-910E-D8EDB46D9D9E@mac.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-8--124631361"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx2.utsp.utwente.nl ([130.89.2.13]:43997 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750975AbZFHRwi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Jun 2009 13:52:38 -0400
In-Reply-To: <44D7A87D-CEE3-40F4-910E-D8EDB46D9D9E@mac.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: Linux OMAP Users <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-8--124631361
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit


Op 8 jun 2009, om 16:06 heeft Elvis Dowson het volgende geschreven:

> Hi,
> 	What does CONFIG_SYSFS_DEPRECATED do?
>
> CONFIG_SYSFS_DEPRECATED=y
> CONFIG_SYSFS_DEPRECATED_V2=y

if you have a recent userspace it will break udev.

regards,

Koen

--Apple-Mail-8--124631361
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: Dit deel van het bericht is digitaal ondertekend
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFKLR0hMkyGM64RGpERAkKHAJsF2oyEYBiULctCY/hB9FLiHZRdcACcCy7H
WKtVcmDeHFGfKvLDpeas8gs=
=Sq9a
-----END PGP SIGNATURE-----

--Apple-Mail-8--124631361--
