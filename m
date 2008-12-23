From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: Nokia Internet Tablets
Date: Tue, 23 Dec 2008 10:04:24 +0100
Message-ID: <9093790D-6A94-435F-9A7F-275BA33A9AB0@student.utwente.nl>
References: <20081222103422.GL29448@guug.org> <20081222140137.GD12324@swansys> <20081223093445.69d761e5.jarkko.nikula@nokia.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-5-460277933"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp2.utsp.utwente.nl ([130.89.2.9]:56363 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752705AbYLWJFX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Dec 2008 04:05:23 -0500
Received: from [172.20.1.5] (vpn006011.vpn.utwente.nl [130.89.6.11])
          by smtp.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id mBN94WEo004441
          for <linux-omap@vger.kernel.org>; Tue, 23 Dec 2008 10:04:32 +0100
In-Reply-To: <20081223093445.69d761e5.jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-5-460277933
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 23 dec 2008, om 08:34 heeft Jarkko Nikula het volgende geschreven:

> On Mon, 22 Dec 2008 08:01:37 -0600
> "ext green" <greenfreedom10@gmail.com> wrote:
>
>> This is great; I hope you have success.  I (who am new to kernel  
>> development
>> and git) have an N810 and have been trying to get Debian running on  
>> it usably;
>> I do have Debian running, but: no X, no RTC, no audio, and a very  
>> short idle
>> time (on a charge).  Unfortunately I have little free time in which  
>> to work on
>> it.
>>
> I recently tried xserver-xorg-video-fbdev from Debian/testing and  
> got it
> working just by adding 'Option "UseFBDev" "true"' in Section  
> "Devices".
> My xorg.conf attached.

have you tried http://cgit.pingu.fi/xf86-video-omapfb/ yet? That  
should give you XV and it shouldn't need an xorg.conf.

regards,

Koen

--Apple-Mail-5-460277933
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: Dit deel van het bericht is digitaal ondertekend
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJUKmaMkyGM64RGpERAukBAJ0Xp91xZ3GFWCJEQcvN5KKppe+DlgCfc6GP
7zRyQrYfMWUclYa9WqCSefo=
=Ntp3
-----END PGP SIGNATURE-----

--Apple-Mail-5-460277933--
