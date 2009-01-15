From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: leds-gpio broken with current git?
Date: Thu, 15 Jan 2009 15:19:22 +0100
Message-ID: <7088542D-28A0-4BCA-9583-6BCDDF9E960A@student.utwente.nl>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-9-318891698"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.utsp.utwente.nl ([130.89.2.8]:58188 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757191AbZAOOUV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Jan 2009 09:20:21 -0500
Received: from [172.20.1.5] (vpn006014.vpn.utwente.nl [130.89.6.14])
          by smtp.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id n0FEJOVR027716
          for <linux-omap@vger.kernel.org>; Thu, 15 Jan 2009 15:19:24 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-9-318891698
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit

Hi,

I've been playing with different kernels on beagleboard lately and it  
seems that somewhere between 2.6.28rc8 and the final release leds-gpio  
got broken for beagleboard:

Registered led device: beagleboard::usr0
Registered led device: beagleboard::usr1
leds-gpio: probe of leds-gpio failed with error -22

and in userspace:

root@beagleboard:~# ls /sys/class/leds/
root@beagleboard:~#

I'm currently too swamped with exams and testing the PM branch to do a  
bisect for 3 blinkenlights, so if anyone has a suggestion were to  
look....

regards,

Koen

--Apple-Mail-9-318891698
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: Dit deel van het bericht is digitaal ondertekend
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJb0XrMkyGM64RGpERAi9oAJoCMr1SUyaHY3g7181Z+Ujo0fMxSgCgov/B
SqWQJd6mYFu8zyUbHQy7vLE=
=1GJX
-----END PGP SIGNATURE-----

--Apple-Mail-9-318891698--
