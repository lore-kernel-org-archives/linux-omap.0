From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: ASoC audio not working on OMAP3 EVM
Date: Thu, 12 Feb 2009 12:01:31 +0100
Message-ID: <E25633C1-D318-4AAC-BEA0-006034B1D619@student.utwente.nl>
References: <1234424393.13374.2.camel@eenurkka-desktop> <2ee9e08d0902120138p62b91989rbaf525d2efbbad21@mail.gmail.com> <20090212114948.5fe50dd8.jarkko.nikula@nokia.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-1-578737161"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.utsp.utwente.nl ([130.89.2.8]:38473 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752567AbZBLLCx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Feb 2009 06:02:53 -0500
In-Reply-To: <20090212114948.5fe50dd8.jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: ext Anuj Aggarwal <anuj.aggarwal@gmail.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-1-578737161
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit


Op 12 feb 2009, om 10:49 heeft Jarkko Nikula het volgende geschreven:

> On Thu, 12 Feb 2009 10:38:27 +0100
> ext Anuj Aggarwal <anuj.aggarwal@gmail.com> wrote:
>
>> The patch doesn't help, result is same...
>>
>> Any help is welcome
>>
> My Beagle is working fine on top of l-o head (commit
> 70ff4a1aafd2378c9e3ff153135ba6d0bde45215) and with Steve's patch
>
> http://git.kernel.org/?p=linux/kernel/git/tiwai/sound-2.6.git;a=commit;h=80c509fdd74f3b158267374cc55156965c8bf930
>
> What codec OMAP3 EVM is using? If AIC3x, then Eero's patch might help

the same codec as beagle and overo (twl/tps)

regards,

Koen

--Apple-Mail-1-578737161
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: Dit deel van het bericht is digitaal ondertekend
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJlAGNMkyGM64RGpERAlLhAKCQarsQVh26GuHGc1xsNbZBw0urewCgnyjj
jgiwICE+VOTtpv5vI01kLPU=
=+17w
-----END PGP SIGNATURE-----

--Apple-Mail-1-578737161--
