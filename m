From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: OMAP Zoom kernel ALSA build problem
Date: Thu, 4 Dec 2008 19:30:55 +0100
Message-ID: <8D7E5AB6-B24B-4667-A0EE-DD26FC3B8EB8@student.utwente.nl>
References: <23D0CDE7C386D144A4F26EB0F427F8C019A5829E@dlee04.ent.ti.com> <200812040940.18076.david-b@pacbell.net> <5d5443650812040951p33886dcchd04b11932641625b@mail.gmail.com> <BD771A35-18A7-41C7-80F5-0BC59D77597C@student.utwente.nl>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-13-1000152670"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp2.utsp.utwente.nl ([130.89.2.9]:32934 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753209AbYLDSbK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Dec 2008 13:31:10 -0500
In-Reply-To: <BD771A35-18A7-41C7-80F5-0BC59D77597C@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: David Brownell <david-b@pacbell.net>, Stephen Smith <smsmith@ti.com>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-13-1000152670
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 4 dec 2008, om 19:25 heeft Koen Kooi het volgende geschreven:

>
> Op 4 dec 2008, om 18:51 heeft Trilok Soni het volgende geschreven:
>
>> Hi,
>>
>> On Thu, Dec 4, 2008 at 11:10 PM, David Brownell <david- 
>> b@pacbell.net> wrote:
>>> On Thursday 04 December 2008, Smith, Stephen wrote:
>>>> I am trying to build sound support for the MDK (3430LDP).  There  
>>>> is a build
>>>> problem on the current git master of the OMAP Zoom kernel.
>>>
>>> Perhaps that kernel should sync with newer code?
>>
>> This is going to happen on some other drivers in future too, because
>> for some unknown reasons (atleast I don't know), that OMAP Zoom went
>> ahead with their tree. I don't see any reason why they have to create
>> new tree. See, how beagleboard guys are working.
>
> Well, the from the 'beagleboard guys' AFAIK only Khasim is being  
> paid (or rather allowed to work in it at the office) to work on  
> beagle kernel stuff, so maintaining a fork is out of the question.  
> The rest of the beagleboards peeps wants to get things as fast as  
> possible into mainline instead of wanting awesomely good  
> powermanagement.


To be clear: I'm not fond of long-running forks like the zoom tree,  
but I can see why people (read: companies) find them attractive.

regards,

Koen

--Apple-Mail-13-1000152670
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJOCHhMkyGM64RGpERAr9hAJ0X/ABeI8DFGT3RuoFoGv1tvOTmBgCggadS
4NUklrcUAZ9AyU8WoPT50mI=
=x2Oz
-----END PGP SIGNATURE-----

--Apple-Mail-13-1000152670--
