From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: PM branch and cpufreq
Date: Sun, 11 Jan 2009 19:53:25 +0100
Message-ID: <F8E71D7D-92CC-4E6D-92F0-21BD8E9C432D@student.utwente.nl>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-21--10264973"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.utsp.utwente.nl ([130.89.2.12]:38173 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750825AbZAKSxe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 11 Jan 2009 13:53:34 -0500
Received: from [172.20.1.5] (vpn006015.vpn.utwente.nl [130.89.6.15])
          by mx.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id n0BIrSIb024739
          for <linux-omap@vger.kernel.org>; Sun, 11 Jan 2009 19:53:28 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-21--10264973
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit

Hi,

I was trying to get cpufreq going on beagleboard (http://cgit.openembedded.net/cgit.cgi?url=openembedded/blob/&id=f56b27781d810dcca0a9946cfd2524c36b7a49c0&path=packages/linux/linux-omap-pm/beagle-cpufreq.diff 
) and I ran into a few issues;

* pm-prev branch: SD card doesn't initialize, and my rootfs is in SD
* pm branch: ditto
* pm-next branch: SD works, but cpufreq is #if 0'd by the "temp: hack  
DVFS to build after clockfw changes" commit

So I have a few questions:

1) is the beagleboard cpufreq patch looking OK?
2) any quick fix for the SD issue
3) any timeframe on getting the pm branch working with cpufreq again?

I suspect 3) will take a few weeks to do properly, unless Kevin is  
willing to revert the patchset from Paul removing the custom clocks  
till Rajendra has updated the cpufreq patches.

I know rootfs-on-sd with a serial console isn't going to give me great  
PM, but it's what I have to work with atm.

regards,

Koen

--Apple-Mail-21--10264973
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: Dit deel van het bericht is digitaal ondertekend
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJakAnMkyGM64RGpERAvn8AKCjVRGcRN99EO3A36jfgoCVisLxogCeLRFE
o7ELtG4Mdr+VoSSkvO6q5Dw=
=zrIC
-----END PGP SIGNATURE-----

--Apple-Mail-21--10264973--
