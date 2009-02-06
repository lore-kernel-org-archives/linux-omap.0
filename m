From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [PATCH v2] board-omap3beagle: set i2c-3 to 100kHz
Date: Fri, 6 Feb 2009 15:15:43 +0100
Message-ID: <0447C4C2-86D0-4FC4-9C33-E09CDE1D2055@student.utwente.nl>
References: <1232873177-15531-1-git-send-email-koen@openembedded.org> <200901250404.11059.david-b@pacbell.net> <1DDF6542-7A64-44F0-9B7B-7B841D02A512@beagleboard.org>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-1-71989360"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx2.utsp.utwente.nl ([130.89.2.13]:47287 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752462AbZBFOQA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 Feb 2009 09:16:00 -0500
Received: from [172.20.1.5] (vpn006013.vpn.utwente.nl [130.89.6.13])
          by mx.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id n16EFjpw016381
          for <linux-omap@vger.kernel.org>; Fri, 6 Feb 2009 15:15:45 +0100
In-Reply-To: <1DDF6542-7A64-44F0-9B7B-7B841D02A512@beagleboard.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-1-71989360
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 4 feb 2009, om 20:58 heeft Koen Kooi het volgende geschreven:

>
> Op 25 jan 2009, om 13:04 heeft David Brownell het volgende geschreven:
>
>> On Sunday 25 January 2009, Koen Kooi wrote:
>>> From: Koen Kooi <koen@beagleboard.org>
>>>
>>> Changing it do 100kHz is needed to make more devices works  
>>> properly. Controlling the TI DLP Pico projector[1] doesn't work  
>>> properly at 400kHz, 100kHz and lower work fine. EDID readout is  
>>> unaffected by this change.
>>>
>>> [1] http://focus.ti.com/dlpdmd/docs/dlpdiscovery.tsp?sectionId=60&tabId=2234
>>>
>>> Signed-off-by: Koen Kooi <koen@beagleboard.org>
>>
>> Acked-by: David Brownell <dbrownell@users.sourceforge.net>
>
> ping

Any more changes needed before this can go in?

regards,

Koen

--Apple-Mail-1-71989360
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: Dit deel van het bericht is digitaal ondertekend
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJjEYRMkyGM64RGpERAjG/AKCKoGOpQUvNJMsX1G0j0BoCtFAlhQCdH0YT
pmrkDsn1yTQdOlmh4TQxuwY=
=hgH5
-----END PGP SIGNATURE-----

--Apple-Mail-1-71989360--
