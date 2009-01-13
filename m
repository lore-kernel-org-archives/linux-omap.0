From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: PM branch and cpufreq
Date: Tue, 13 Jan 2009 08:58:11 +0100
Message-ID: <1EA5690A-7DC6-41C9-81AB-BACBEDAAD938@student.utwente.nl>
References: <F8E71D7D-92CC-4E6D-92F0-21BD8E9C432D@student.utwente.nl> <D1986163-A086-4798-A1D7-0A5E93984C21@student.utwente.nl> <878wpfn7t6.fsf@deeprootsystems.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-15-123221415"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.utsp.utwente.nl ([130.89.2.8]:44017 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758389AbZAMH60 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Jan 2009 02:58:26 -0500
In-Reply-To: <878wpfn7t6.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-15-123221415
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 13 jan 2009, om 05:33 heeft Kevin Hilman het volgende geschreven:

> Koen Kooi <k.kooi@student.utwente.nl> writes:
>
>> Op 11 jan 2009, om 19:53 heeft Koen Kooi het volgende geschreven:
>>
>>> Hi,
>>>
>>> I was trying to get cpufreq going on beagleboard
>>> (http://cgit.openembedded.net/cgit.cgi?url=openembedded/blob/&id=f56b27781d810dcca0a9946cfd2524c36b7a49c0&path=packages/linux/linux-omap-pm/beagle-cpufreq.diff
>>> ) and I ran into a few issues;
>>>
>>> * pm-prev branch: SD card doesn't initialize, and my rootfs is in SD
>>
>> SD *does* initialize, but 'rootwait' doesn't work, booting from a
>> ubifs volume in nand works and udev automounts my SD card. Cpufreq
>> isn't working, so I still need advice on that :)
>
> pm-next isn't supposed to work. ;) It is work in progress.  Once it's
> ready it will become 'pm'.
>
> Re: SD/MMC problem I see the same problem in linux-omap HEAD where
> rootwait doesn't seem to work, so at least the 'rootwait' problem
> think is not PM branch related.
>
> Re: CPUfreq on Beagle.  I haven't done any testing of CPUfreq on
> beagle.  AFAICT, the OPP definitions are not being defined for Beagle.
> That would explain no availabe operating points.
>
> These are board specific settings.  You could start by looking at the
> *_rate_table definitions in board-3430sdp.c.

Thats' where http://cgit.openembedded.net/cgit.cgi?url=openembedded/blob/&id=95234a14a387c1437e71eafe0c48d4ebf95a9bc8&path=packages/linux/linux-omap-pm/beagle-cpufreq.diff 
  comes in :)

It doesn't seem to have any effect though, no 'cpufreq' prints in  
dmesg whatsoever (with pm-prev, that is).

regards,

Koen
>
>
> Kevin
>
>


--Apple-Mail-15-123221415
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: Dit deel van het bericht is digitaal ondertekend
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJbEmWMkyGM64RGpERAu65AKCrQp8OAkLmCTFUiqPSgMQ5BdPcvACgrvuo
Cr+zuu2T/3+xjpNiskxZDVo=
=QWWJ
-----END PGP SIGNATURE-----

--Apple-Mail-15-123221415--
