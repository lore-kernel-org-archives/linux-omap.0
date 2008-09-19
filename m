From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: getting 2.6.25 from git to run on omap35x evm
Date: Fri, 19 Sep 2008 17:37:06 +0200
Message-ID: <98D88699-2EF7-4976-95BE-65CCD490C135@student.utwente.nl>
References: <dbdb2ea60809171136v5a380989mf57aca6ff1df5aba@mail.gmail.com> <ADBD1DC1-66B1-4EE2-92D8-051C5B91FC1C@student.utwente.nl> <dbdb2ea60809171223h7ef92c3dg6a4d41f29b9b8c1e@mail.gmail.com> <1f11a5490809171236k52fcc05q74ce5dfe1882d5cb@mail.gmail.com> <dbdb2ea60809171311g13631826m4b46a881ebbb1ae5@mail.gmail.com> <FCCFB4CDC6E5564B9182F639FC356087022A2BAB54@dbde02.ent.ti.com> <dbdb2ea60809190824w507aa4f4j5754b0b73d2664fe@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-6-865774941"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx2.utsp.utwente.nl ([130.89.2.13]:44323 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752464AbYISPia (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Sep 2008 11:38:30 -0400
Received: from [172.20.1.5] (vpn006014.vpn.utwente.nl [130.89.6.14])
          by mx.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id m8JFb9I2014050
          for <linux-omap@vger.kernel.org>; Fri, 19 Sep 2008 17:37:09 +0200
In-Reply-To: <dbdb2ea60809190824w507aa4f4j5754b0b73d2664fe@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-6-865774941
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 19 sep 2008, om 17:24 heeft twebb het volgende geschreven:

>>>
>>> Great, that's helpful.  Do you know omapzoom linux-2.6.25 to be
>>> somewhat functional with OMAP 35x EVM, or would you suggest going  
>>> with
>>> something newer like v2.6.26-ti-07252008?  Or must I go to 2.6.27- 
>>> rc3?
>>> I assume newer (to a point) would result in better stability on the
>>> 35x EVM?
>>
>> On omapzoom.org, I try to test for functionality complete and  
>> working for primarily LDP board and also 3430SDP. I have not tested  
>> the EVM stuff.
>>
>> I just completed up merging omapzoom tree to 2.6.27rc6 on branch:  
>> branch_2.6.27rc6_migration
>> You could have a look at it if that helps.
>>
>
> I tried the rc6_migration branch, and after a few hiccups got it
> basically running.  However, seeing two problems - one is minor at
> this point but the other is a real issue.
>
>
> #2 - when any key is pressed on the 35x EVM, I get the following
> output continuously...
> TWL4030 module irq 369 is disabled but can't be masked!
> TWL4030 module irq 369 is disabled but can't be masked!
> ...
>
> Though it sounds like no one is testing this code against a 35x EVM,
> I'm still hoping someone may have a clue about what is going wrong
> here.

The irq 369 problem is present on l-o git as well, no idea what's  
causing it. Basically: 2.6.26 is awesome, 2.6.27rc is broken crap[1].

regards,

Koen

[1] At least on beagle and evm, overo seems to work after a musb patch



--Apple-Mail-6-865774941
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFI08clMkyGM64RGpERAnEyAJwOMJecm0/oJdRIpvNZocDRKjDv8wCfRGFi
scKzX0GyCB0rBWeMJtUl1Ac=
=a9m8
-----END PGP SIGNATURE-----

--Apple-Mail-6-865774941--
