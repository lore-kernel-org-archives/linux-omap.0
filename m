From: Koen Kooi <koen@beagleboard.org>
Subject: Re: [PATCH v2] board-omap3beagle: set i2c-3 to 100kHz
Date: Wed, 4 Feb 2009 20:58:22 +0100
Message-ID: <1DDF6542-7A64-44F0-9B7B-7B841D02A512@beagleboard.org>
References: <1232873177-15531-1-git-send-email-koen@openembedded.org> <200901250404.11059.david-b@pacbell.net>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-5--80251716"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f20.google.com ([209.85.220.20]:40507 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755574AbZBDT63 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Feb 2009 14:58:29 -0500
Received: by fxm13 with SMTP id 13so3327496fxm.13
        for <linux-omap@vger.kernel.org>; Wed, 04 Feb 2009 11:58:28 -0800 (PST)
In-Reply-To: <200901250404.11059.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-5--80251716
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 25 jan 2009, om 13:04 heeft David Brownell het volgende geschreven:

> On Sunday 25 January 2009, Koen Kooi wrote:
>> From: Koen Kooi <koen@beagleboard.org>
>>
>> Changing it do 100kHz is needed to make more devices works  
>> properly. Controlling the TI DLP Pico projector[1] doesn't work  
>> properly at 400kHz, 100kHz and lower work fine. EDID readout is  
>> unaffected by this change.
>>
>> [1] http://focus.ti.com/dlpdmd/docs/dlpdiscovery.tsp?sectionId=60&tabId=2234
>>
>> Signed-off-by: Koen Kooi <koen@beagleboard.org>
>
> Acked-by: David Brownell <dbrownell@users.sourceforge.net>

ping


--Apple-Mail-5--80251716
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: Dit deel van het bericht is digitaal ondertekend
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJifNfMkyGM64RGpERArOYAKCynqoIoMw3r6yEti/UPy7WO/H5SgCfRkw9
4HZcryG6VvQ+ohdagB4Cmr8=
=wsUw
-----END PGP SIGNATURE-----

--Apple-Mail-5--80251716--
