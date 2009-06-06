From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: PM error: Powerdomain (core_pwddm) didn't enter target state 1
Date: Sat, 6 Jun 2009 09:38:36 +0200
Message-ID: <ECEAF22C-7136-40B8-BF5E-467E1B8E3190@student.utwente.nl>
References: <42B46BA8-AF35-42B5-9616-EADA31EF0553@mac.com> <87fxeebrsc.fsf@deeprootsystems.com> <277E4F10-4228-40C5-85C8-5B365B861DFF@mac.com> <87tz2ua7uy.fsf@deeprootsystems.com> <aed62de90906051744q6786b991hffe8640567934501@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-22--321255958"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp2.utsp.utwente.nl ([130.89.2.9]:60615 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750793AbZFFHjK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 6 Jun 2009 03:39:10 -0400
Received: from [172.20.1.5] (vpn006012.vpn.utwente.nl [130.89.6.12])
          by smtp.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id n567ccVM030320
          for <linux-omap@vger.kernel.org>; Sat, 6 Jun 2009 09:38:39 +0200
In-Reply-To: <aed62de90906051744q6786b991hffe8640567934501@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Users <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-22--321255958
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 6 jun 2009, om 02:44 heeft Rebecca Schultz Zavin het volgende  
geschreven:

> On Fri, Jun 5, 2009 at 10:49 AM, Kevin
> Hilman<khilman@deeprootsystems.com> wrote:
>> Elvis Dowson <elvis.dowson@mac.com> writes:
>>
>>> Hi Kevin,
>>>
>>> On Jun 5, 2009, at 7:53 PM, Kevin Hilman wrote:
>>>
>>>>>
>>>>
>>>> It's pretty difficult for me to know what you are actually  
>>>> running by
>>>> the description above.  You've taken a bunch of stuff, put them
>>>> together in some unspecified way, and are using an unspecified  
>>>> config.
>>>
>>> Sorry about that, I'm working on an android port to the gumstix  
>>> overo
>>> earth platform. I'm trying to incorporate patches from the
>>> android-2.6.29 kernel, tomi's latest dss2 patches and your pm  
>>> patches,
>>> to the linux-omap-2.6 master branch.
>>
>> For initial PM debugging, I highly recommend something closer to what
>> others are developing and testing against.  Using the PM branch
>> patches on top of linux-omap master is not yet tested and validated,
>> so I can't give you any support there.
>>
>> For example, you might start from the Android OMAP kernel which
>> is 2.6.29 based and includes the PM branch already.
>>
>>  http://android.git.kernel.org/?p=kernel/omap.git
>>
>> Then you'd just have to add your dss2 and Overo stuff there.
>
> Dss2 is already there as are Kevin's pm patches.  We're actively
> debugging pm issues there as well.  We're happy to take patches
> against that branch if you feel like contributing back.

Ehm, Isn't google supposed to 'contribute back' instead of the  
original authors?

regards,

Koen

--Apple-Mail-22--321255958
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: Dit deel van het bericht is digitaal ondertekend
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFKKhz+MkyGM64RGpERAiUpAJ9E4K49n+7Okh6n/X8dVLBiUQuYmgCfac6v
uPGMJMdyp6CNot6nPaEMSgo=
=ZC6P
-----END PGP SIGNATURE-----

--Apple-Mail-22--321255958--
