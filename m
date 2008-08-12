From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: USB-webcam support
Date: Tue, 12 Aug 2008 13:25:01 +0200
Message-ID: <E78C46F1-DB17-4BE0-A310-D1F5072B26B8@student.utwente.nl>
References: <c656a4d20808120332v224c5053r7225c086acd8c2cd@mail.gmail.com> <5A47E75E594F054BAF48C5E4FC4B92AB0256A366A2@dbde02.ent.ti.com>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-6--285066832"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.utsp.utwente.nl ([130.89.2.12]:33096 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751892AbYHLLZ2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Aug 2008 07:25:28 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0256A366A2@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: arun c <arunedarath@mistralsolutions.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-6--285066832
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 12 aug 2008, om 12:50 heeft Gadiyar, Anand het volgende geschreven:

>> Hi All,
>>
>> If I have a USB camera with good Linux support, can I connect it
>> to omap3evm(or any omap2) and make it functional?
>
> I don't see why not. Do you expect a problem with using it? You could
> use MUSB in host or OTG mode and connect the camera to the MUSB port.

Not quite, MUSB doesn't support the 'high bandwidth' flag, which most  
usb webcams seem to use (even the puny 12mbit ones). Tested on the  
MUSB port of my beagle and bf548.

regards,

Koen

--Apple-Mail-6--285066832
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFIoXMPMkyGM64RGpERAkQmAKC20zmijOSCjgj+GVhQ73CQFBXcSgCbBxrG
CG5J51FQTXLgFso8+d1/h5I=
=2cal
-----END PGP SIGNATURE-----

--Apple-Mail-6--285066832--
