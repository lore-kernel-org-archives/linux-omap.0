From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: Powertop on Beagle
Date: Fri, 9 Jan 2009 16:40:44 +0100
Message-ID: <F711E9EF-7946-47A5-B649-E312574E5539@student.utwente.nl>
References: <49675282.1040100@balister.org>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-6--194626069"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx2.utsp.utwente.nl ([130.89.2.13]:41263 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750899AbZAIPlY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Jan 2009 10:41:24 -0500
Received: from [172.20.1.5] (vpn006048.vpn.utwente.nl [130.89.6.48])
          by mx.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id n09FelCn001378
          for <linux-omap@vger.kernel.org>; Fri, 9 Jan 2009 16:40:47 +0100
In-Reply-To: <49675282.1040100@balister.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-6--194626069
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 9 jan 2009, om 14:34 heeft Philip Balister het volgende geschreven:

> I'm trying to get powertop running on the latest git. It basically  
> works, but I do not get displays for the C and P states. This has  
> worked in the past, but the OE kernel I'm using had a lot of patches  
> then :)
>
> Does anyone have a list of things to check, before I start working  
> through my kernel patch history?

The older kernel applied CPUidle patches, which are in the PM branch  
nowadays.

regards,

Koen

--Apple-Mail-6--194626069
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: Dit deel van het bericht is digitaal ondertekend
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJZ2/+MkyGM64RGpERAsF1AJ4it1/vUX8fynbLF+rckUFgEkGAKQCfXcVH
+6F6GVSh3pGZvc42A7Latkk=
=3bOa
-----END PGP SIGNATURE-----

--Apple-Mail-6--194626069--
