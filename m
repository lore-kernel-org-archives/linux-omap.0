From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: getting 2.6.25 from git to run on omap35x evm
Date: Fri, 19 Sep 2008 21:16:43 +0200
Message-ID: <95C4F54C-39F7-4E13-AEDD-7398DF2E34BB@student.utwente.nl>
References: <dbdb2ea60809171136v5a380989mf57aca6ff1df5aba@mail.gmail.com> <ADBD1DC1-66B1-4EE2-92D8-051C5B91FC1C@student.utwente.nl> <dbdb2ea60809171223h7ef92c3dg6a4d41f29b9b8c1e@mail.gmail.com> <1f11a5490809171236k52fcc05q74ce5dfe1882d5cb@mail.gmail.com> <dbdb2ea60809171311g13631826m4b46a881ebbb1ae5@mail.gmail.com> <FCCFB4CDC6E5564B9182F639FC356087022A2BAB54@dbde02.ent.ti.com> <dbdb2ea60809190824w507aa4f4j5754b0b73d2664fe@mail.gmail.com> <98D88699-2EF7-4976-95BE-65CCD490C135@student.utwente.nl> <dbdb2ea60809191129k17dd8710j8c10cc17eb0dd637@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-8-878951404"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.utsp.utwente.nl ([130.89.2.12]:40099 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752796AbYISTRq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Sep 2008 15:17:46 -0400
Received: from [172.20.1.5] (vpn006014.vpn.utwente.nl [130.89.6.14])
          by mx.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id m8JJGjdN008852
          for <linux-omap@vger.kernel.org>; Fri, 19 Sep 2008 21:16:45 +0200
In-Reply-To: <dbdb2ea60809191129k17dd8710j8c10cc17eb0dd637@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-8-878951404
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 19 sep 2008, om 20:29 heeft twebb het volgende geschreven:

>>
>> The irq 369 problem is present on l-o git as well, no idea what's  
>> causing
>> it. Basically: 2.6.26 is awesome, 2.6.27rc is broken crap[1].
>>
>> regards,
>>
>> Koen
>>
>> [1] At least on beagle and evm, overo seems to work after a musb  
>> patch
>>
>
> Which is awesome, 2.6.26 on omapzoom.git or on linux-omap git?

linux-omap git.

>
>
> I try linux-omap git (tag = v2.6.26-omap2) and have problems mounting
> rootfs.  Appears to be trying to mount root via NFS and ignoring
> kernel command line specifying the mtdblock...
>
> Kernel command line: mem=128M console=ttyS0,115200n8 noinitrd root=/ 
> dev/mtdblock
> 4 rw rootfstype=jffs2  
> ip=192.168.1.200:192.168.1.123:192.168.1.2:255.255.255.0::
> eth0:on

cmdlines work for me, did you set bootargs in uboot properly?

regards,

Koen


--Apple-Mail-8-878951404
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFI0/qdMkyGM64RGpERAmd1AJ4gnXrfEo8rowKCdbtJqAq/RNP9HgCgnL1k
TrjfY7FOK2qkZ+3NlEo6WHY=
=E+CT
-----END PGP SIGNATURE-----

--Apple-Mail-8-878951404--
