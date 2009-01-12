From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: PM branch and cpufreq
Date: Mon, 12 Jan 2009 08:16:10 +0100
Message-ID: <D1986163-A086-4798-A1D7-0A5E93984C21@student.utwente.nl>
References: <F8E71D7D-92CC-4E6D-92F0-21BD8E9C432D@student.utwente.nl>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-26-34300337"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.utsp.utwente.nl ([130.89.2.8]:47487 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754529AbZALHQX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Jan 2009 02:16:23 -0500
Received: from [172.20.1.5] (vpn006015.vpn.utwente.nl [130.89.6.15])
          by smtp.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id n0C7GCVR030207
          for <linux-omap@vger.kernel.org>; Mon, 12 Jan 2009 08:16:13 +0100
In-Reply-To: <F8E71D7D-92CC-4E6D-92F0-21BD8E9C432D@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-26-34300337
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 11 jan 2009, om 19:53 heeft Koen Kooi het volgende geschreven:

> Hi,
>
> I was trying to get cpufreq going on beagleboard (http://cgit.openembedded.net/cgit.cgi?url=openembedded/blob/&id=f56b27781d810dcca0a9946cfd2524c36b7a49c0&path=packages/linux/linux-omap-pm/beagle-cpufreq.diff 
> ) and I ran into a few issues;
>
> * pm-prev branch: SD card doesn't initialize, and my rootfs is in SD

SD *does* initialize, but 'rootwait' doesn't work, booting from a  
ubifs volume in nand works and udev automounts my SD card. Cpufreq  
isn't working, so I still need advice on that :)

regards,

Koen

--Apple-Mail-26-34300337
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: Dit deel van het bericht is digitaal ondertekend
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJau48MkyGM64RGpERAuQbAKCsfvAvEwJ+sPS/LFrQUPQgIfXrEQCfSj9/
nyIFpL9G/yRIFuWaPPnBj/w=
=I90O
-----END PGP SIGNATURE-----

--Apple-Mail-26-34300337--
