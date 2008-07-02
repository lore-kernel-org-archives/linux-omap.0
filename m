From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: Kernel hang on OMAP3 based Beagle board, RTC issue?
Date: Wed, 2 Jul 2008 22:18:11 +0200
Message-ID: <AF70E37B-038B-4117-B69F-B2BCD9EFF6AA@student.utwente.nl>
References: <486BDD2A.5070500@googlemail.com> <5A47E75E594F054BAF48C5E4FC4B92AB022BB6621C@dbde02.ent.ti.com>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-1-499490748"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.utsp.utwente.nl ([130.89.2.8]:35410 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754689AbYGBUS2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 Jul 2008 16:18:28 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB022BB6621C@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: Dirk Behme <dirk.behme@googlemail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Syed Mohammed, Khasim" <khasim@ti.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-1-499490748
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 2 jul 2008, om 22:03 heeft Gadiyar, Anand het volgende geschreven:

>> At Beagle IRC there was some discussion [1] [2] today about kernel
>> hang on OMAP3 based Beagle board. I'll try to summarize discussion  
>> and
>> Khasim's findings, maybe somebody here has an idea.
>>
>> Latest OMAP git kernel seems to hang on beagle board after some time.
>> You don't see any crash, but after a while typing, anything doesn't
>> work. SD stops as well, so you can only do stuff that's in ram, any  
>> IO
>> will block. It can take >1 day to get there, but mostly it's ~30  
>> minutes.
>>
>> Khasim found that it seems disabling RTC will remove the hang. When
>> booting the git kernel after some time there are no timer or PRCM
>> interrupts and the control resides in cpu_idle. We don't know where
>> exactly the problem in RTC is, but while browsing the history of  
>> files
>> related to RTC Khasim found that some changes were done to the files
>> to handle T2 interrupts in a centralized way for USB, Battery and  
>> RTC.
>> It seems even Battery broke with this patch set
>>
>> http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commitdiff;h=68d7477caca19c0b52b5d4e85700cd3e6115577f
>>
>> May be this is the change that is affecting RTC. But it's unclear why
>> it is affecting GP timer and PRCM interrupts.
>>
>> Any idea?
>>
>> Thanks and please correct if something is wrong in the summary
>>
>> Dirk
>
> Khasim also found that T2 RTC is not enabled by default in 3430sdp
> defconfig, but it appears to be enabled in the beagleboard defconfig.
> Maybe you can get by by simply disabling T2 RTC in menuconfig for now?

Tried that and I get the same hang, so I don't think the RTC is to  
blame.


--Apple-Mail-1-499490748
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFIa+KFMkyGM64RGpERAt5TAJ4gnKRFVgQhiTpwzxhtvPPLTHNzEACeIYIR
bSYKTchEf6kDQM4z8na3Xkc=
=e/yQ
-----END PGP SIGNATURE-----

--Apple-Mail-1-499490748--
