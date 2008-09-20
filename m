From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [RFC 0/2] McBSP and ASoC OMAP update patches for 2430 and 34xx
Date: Sat, 20 Sep 2008 14:21:31 +0200
Message-ID: <7A055BAF-874B-4CAB-A418-80A5E57C20F4@student.utwente.nl>
References: <1219319718-1750-1-git-send-email-jarkko.nikula@nokia.com> <20080905011235.GZ23085@atomide.com> <5e088bd90809042318k762df6c8k79ef1fcbad9a8781@mail.gmail.com> <dfeb90390809200422x79c91c5v2172bbd28b42c634@mail.gmail.com> <6AA0F75E-0ECE-4EBD-A83A-C514A2A3190D@student.utwente.nl> <dfeb90390809200453i35da7891lcea6d620dbb0e46a@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-17-940439890"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx2.utsp.utwente.nl ([130.89.2.13]:43081 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751299AbYITMWM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 20 Sep 2008 08:22:12 -0400
Received: from [172.20.1.5] (vpn006012.vpn.utwente.nl [130.89.6.12])
          by mx.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id m8KCLYI2013023
          for <linux-omap@vger.kernel.org>; Sat, 20 Sep 2008 14:21:34 +0200
In-Reply-To: <dfeb90390809200453i35da7891lcea6d620dbb0e46a@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-17-940439890
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit

Op 20 sep 2008, om 13:53 heeft Arun KS het volgende geschreven:

>>>> I've been testing these patches along with my Overo patches on the
>>>> current l-o head.  Audio is working fine, so the mcbsp changes  
>>>> haven't
>>>> broken anything.
>>>
>>> Is the null substream pointer was the problem in the alsa-lib?
>>
>> We suspect it's in alsa-lib
>>
>>> Is it fixed?
>>
>> Sadly not :(
>>
>
> I saw ASOC patches for overo and beagle board. Any clue how they are
> testing the audio driver.

I use mplayer or aplay to test it, IIRC steve uses something similar.

regards,

Koen

--Apple-Mail-17-940439890
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFI1OrNMkyGM64RGpERAtmjAJ4lH87Wu2l7a84zsEY8vpsy7ERmmQCgj2EL
pwE6OXIe1Dwt5McPOWNoLck=
=wyKC
-----END PGP SIGNATURE-----

--Apple-Mail-17-940439890--
