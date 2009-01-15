From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: new PM branch available
Date: Thu, 15 Jan 2009 09:18:35 +0100
Message-ID: <0A31781D-EC15-4B4D-A48A-47A67AC38824@student.utwente.nl>
References: <87iqoij2me.fsf@deeprootsystems.com> <84166B96-7874-4B6D-B86E-659250F62558@student.utwente.nl> <87wscxk022.fsf@deeprootsystems.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-3-297244985"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx3.utsp.utwente.nl ([130.89.2.14]:13192 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754754AbZAOISq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Jan 2009 03:18:46 -0500
In-Reply-To: <87wscxk022.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-3-297244985
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 14 jan 2009, om 23:14 heeft Kevin Hilman het volgende geschreven:

> Koen Kooi <k.kooi@student.utwente.nl> writes:
>
>> Op 13 jan 2009, om 22:51 heeft Kevin Hilman het volgende geschreven:
>>
>>> Hello,
>>>
>>> The latest PM branch is now available[1].
>>>
>>> I've done basic testing of retention and off-mode (suspend and  
>>> dynamic
>>> idle) on Beagle and custom HW.  My SDP has something still keeping
>>> CORE active that others have not seen, but I have yet to debug.  Any
>>> other reports from SDP testing would be appreciated.
>>>
>>> Notable changes/updates
>>> - rebased on latest clock updates and fixes from Paul
>>> - clockfw pre- and post- notifiers
>>> - DVFS for VDD2
>>
>> The bootlog on my rev C1D beagle looks suspicious:
>>
>
> Hi Koen,
>
> Hmm, it looks like you're tree is missing the McBSP fix from Paul[1].
> This patch made it in before v2.6.28-omap1 which the latest PM branch
> is based on, so I'm guessing you're not testing the latest PM branch.

Indeed:

>>  Image Name:   Angstrom/2.6.28-pm1+gitrb5d11429

The latest is gitr998bd567. I'll test the proper one later today.

regards,

Koen

--Apple-Mail-3-297244985
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: Dit deel van het bericht is digitaal ondertekend
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJbvFdMkyGM64RGpERAl2WAJ94ru5xq09jmJq2LlKDDomqfbgT4gCeIQxA
a+kwz26byymIAqSgdGzcLtI=
=rn0Z
-----END PGP SIGNATURE-----

--Apple-Mail-3-297244985--
