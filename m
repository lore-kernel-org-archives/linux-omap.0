From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: MMC broken on beagleboard with current git
Date: Thu, 25 Sep 2008 12:24:55 +0200
Message-ID: <4D346DA2-6C57-48A7-AC4E-2191C44497CF@student.utwente.nl>
References: <FDAFB709-68B8-478D-8321-1322449B9A7F@student.utwente.nl> <20080925085142.GC5222@atomide.com> <77EE6A0D-895B-4E0B-B9C4-18D333BFF85C@student.utwente.nl> <20080925094718.GE5222@atomide.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-7--782039828"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx2.utsp.utwente.nl ([130.89.2.13]:46510 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753124AbYIYKZR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Sep 2008 06:25:17 -0400
In-Reply-To: <20080925094718.GE5222@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-7--782039828
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 25 sep 2008, om 11:47 heeft Tony Lindgren het volgende geschreven:

> * Koen Kooi <k.kooi@student.utwente.nl> [080925 12:23]:
>>
>> Op 25 sep 2008, om 10:51 heeft Tony Lindgren het volgende geschreven:
>>
>>> * Koen Kooi <k.kooi@student.utwente.nl> [080925 11:42]:
>>>> Hi,
>>>>
>>>> I just built a kernel from current git[1] and the mmc controller
>>>> doesn't
>>>> get detected on boot on my beagleboards. The omap mmc system has
>>>> seen a
>>>> lot of changes lately, does anyone have a hint where to start  
>>>> looking
>>>> before attemping a bisect?
>>>
>>> Sounds like the recent mmc init changes we've done:
>>>
>>> 535e1808d1c77a580815f7d7daacc6c030e29cb1 -  12 september 2008
>>
>>> 8e6e06c71b9d21d85a3ae652868e2802c054a08a - 12 september 2008
>>
>>> c434c15d28c82d92e55897bd265c423e9ab69362 - 24 september 2008
>>
>>
>>> I've verified that it works on omap3430sdp. But mach-omap2/hsmmc.c
>>> needs
>>> some more work done to support other mmc controllers besides the  
>>> first
>>> one.
>>> I don't think other controllers ever worked before these patches
>>> either though..
>>>
>>> Let me know if you can narrow it down to some commit and I may be  
>>> able
>>> to help further from there.
>>
>> The previous working version I built was based of
>> de1121fdb899f762b9e717f44eaf3fae7c00cd3e which was commited at 13
>> september 2008, so 535e18.. and 8e6e06c.. don't break it.
>
> OK, good to know. Can you try to git-bisect it?

That proved to be a lot less work than expected :)

Last good: 9d1dff8638c9e96a401e1885f9948662e9ff9636
First bad: c434c15d28c82d92e55897bd265c423e9ab69362

So http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commit;h=c434c15d28c82d92e55897bd265c423e9ab69362 
  breaks MMC on beagle.

regards,

Koen
>
>
> Tony
>
>>>
>>>> [1] http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commit;h=c434c15d28c82d92e55897bd265c423e9ab69362
>>>
>>>
>>>
>>
>
>
>


--Apple-Mail-7--782039828
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFI22b6MkyGM64RGpERAnPZAJ9yXhh4XDSVZ6yI7kq5OImO2RbntgCglMA8
7LZNGHVT3e/o99UN6woWB+I=
=tD2b
-----END PGP SIGNATURE-----

--Apple-Mail-7--782039828--
