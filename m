From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: NULL pointer dereference when using ALSA SOC
Date: Thu, 25 Sep 2008 23:46:01 +0200
Message-ID: <69299993-CA68-4F6C-88E7-778A8DEDF7AF@student.utwente.nl>
References: <dfeb90390809222326s44162f94sf42f96fdfc0a0690@mail.gmail.com> <01BA5FDD-AC4E-4450-B576-8A7DA867E314@student.utwente.nl> <dfeb90390809250638r22474563q1262209d15974cb9@mail.gmail.com> <200809251022.08544.david-b@pacbell.net> <5e088bd90809251034h4de27054tfa00182814791645@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-2--741173724"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx2.utsp.utwente.nl ([130.89.2.13]:57496 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755214AbYIYVtv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Sep 2008 17:49:51 -0400
Received: from [172.20.1.5] (vpn006057.vpn.utwente.nl [130.89.6.57])
          by mx.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id m8PLk5I2028805
          for <linux-omap@vger.kernel.org>; Thu, 25 Sep 2008 23:46:06 +0200
In-Reply-To: <5e088bd90809251034h4de27054tfa00182814791645@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-2--741173724
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 25 sep 2008, om 19:34 heeft Steve Sakoman het volgende geschreven:

> On Thu, Sep 25, 2008 at 10:22 AM, David Brownell <david- 
> b@pacbell.net> wrote:
>> On Thursday 25 September 2008, Arun KS wrote:
>>>>>> I narrowed this into CONFIG_SLUB. When it's set, I can  
>>>>>> reproduce the
>>>>>> bug both with N810 and Beagle but not when using CONFIG_SLAB.
>>
>> So it's confirmed that SLUB is a factor, but
>> the root cause is still not known or resolved?
>
> Correct.  I suspect that somewhere in alsa-lib code is not checking an
> error return on a memory allocation.  When I previously discussed this
> issue with the folks on alsa-devel they suspected a bug in alsa-lib.
> I'll give them this additional data and see if someone there wants to
> help track down the root cause.

Hmmm, SLAB makes it trigger the null pointer less, not make it go away  
completely :(

regards,

Koen

--Apple-Mail-2--741173724
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFI3AacMkyGM64RGpERAgjBAJ0Qk6UNHLPAisfXmKRHskVfBlWIVQCgkwpm
kcd3PfxSRI+9CMRZS+9pFtU=
=g/vO
-----END PGP SIGNATURE-----

--Apple-Mail-2--741173724--
