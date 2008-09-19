From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: OMAP support in mainline?
Date: Fri, 19 Sep 2008 16:07:57 +0200
Message-ID: <447C13FB-DA21-48C3-8903-69A4544F58AB@student.utwente.nl>
References: <87tzcgi1gv.fsf@nokia.com> <DC3E0288-2605-450F-9E54-9B170B7669C9@student.utwente.nl> <FCCFB4CDC6E5564B9182F639FC356087022A3162A3@dbde02.ent.ti.com> <200809180931.02971.david-b@pacbell.net>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-5-860425231"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx3.utsp.utwente.nl ([130.89.2.14]:48114 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750977AbYISOIF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Sep 2008 10:08:05 -0400
Received: from [172.20.1.5] (vpn006014.vpn.utwente.nl [130.89.6.14])
          by mx.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id m8JE7xjN016444
          for <linux-omap@vger.kernel.org>; Fri, 19 Sep 2008 16:07:59 +0200
In-Reply-To: <200809180931.02971.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-5-860425231
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 18 sep 2008, om 18:31 heeft David Brownell het volgende geschreven:

> On Thursday 18 September 2008, Pandita, Vikram wrote:
>>
>>> And, no, I'm not going to try omapzoom stuff, I want it working on  
>>> the
>>> canonical linux-omap kernel, not some corporate version with god  
>>> knows
>>> how many hacks.
>>
>> Your wish.
>> I thought debugging and fixing the issue was more important than the
>> source of the fix !!!
>
> Right, but the point is to fix the linux-omap tree...
> switching to zoom kernels would be a non-trivial detour.

Zoom kernels differ too much from l-o to be able to say "musb works  
there, let's just use their musb driver". That is, *if* musb works  
there.

regards,

Koen

--Apple-Mail-5-860425231
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFI07I/MkyGM64RGpERAmvHAKCqZZWNDVWoeGcJOXrZd30CYcZbUgCfVNjR
6aMqhUiK8zbAw9rJJwIx/sI=
=Z0Ad
-----END PGP SIGNATURE-----

--Apple-Mail-5-860425231--
