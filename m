From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: PM branch and cpufreq
Date: Sun, 11 Jan 2009 19:58:07 +0100
Message-ID: <CF7151A4-B486-4825-85CE-524D1276FD6E@student.utwente.nl>
References: <F8E71D7D-92CC-4E6D-92F0-21BD8E9C432D@student.utwente.nl>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-22--9982382"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.utsp.utwente.nl ([130.89.2.12]:38290 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751979AbZAKS6S (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 11 Jan 2009 13:58:18 -0500
Received: from [172.20.1.5] (vpn006015.vpn.utwente.nl [130.89.6.15])
          by mx.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id n0BIwAIb027344
          for <linux-omap@vger.kernel.org>; Sun, 11 Jan 2009 19:58:10 +0100
In-Reply-To: <F8E71D7D-92CC-4E6D-92F0-21BD8E9C432D@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-22--9982382
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 11 jan 2009, om 19:53 heeft Koen Kooi het volgende geschreven:

> Hi,
>
> I was trying to get cpufreq going on beagleboard (http://cgit.openembedded.net/cgit.cgi?url=openembedded/blob/&id=f56b27781d810dcca0a9946cfd2524c36b7a49c0&path=packages/linux/linux-omap-pm/beagle-cpufreq.diff 
> ) and I ran into a few issues;
>
> * pm-prev branch: SD card doesn't initialize, and my rootfs is in SD
	bootlog: http://dominion.thruhere.net/koen/OE/beagleboard/cpufreq2.txt

> * pm-next branch: SD works, but cpufreq is #if 0'd by the "temp:  
> hack DVFS to build after clockfw changes" commit
	bootlog: http://dominion.thruhere.net/koen/OE/beagleboard/cpufreq.txt

regards,

Koen

--Apple-Mail-22--9982382
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: Dit deel van het bericht is digitaal ondertekend
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJakFBMkyGM64RGpERAq0eAJ9C+QZU8ZWpCV27ytlM+W7OxoLDrgCfZwRN
ArkqsTbCGo//1szj/IN1pTw=
=FXk8
-----END PGP SIGNATURE-----

--Apple-Mail-22--9982382--
