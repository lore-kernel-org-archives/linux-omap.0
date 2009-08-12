From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: query: omap-defconfigs
Date: Wed, 12 Aug 2009 22:07:27 +0200
Message-ID: <7A9558F8-D694-4EA8-8A69-85A69725E682@student.utwente.nl>
References: <FCCFB4CDC6E5564B9182F639FC35608702F598989C@dbde02.ent.ti.com> <87iqgt14n6.fsf@deeprootsystems.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-2--929975828"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.utsp.utwente.nl ([130.89.2.8]:46185 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753831AbZHLUHm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Aug 2009 16:07:42 -0400
In-Reply-To: <87iqgt14n6.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-2--929975828
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 12 aug 2009, om 16:35 heeft Kevin Hilman het volgende geschreven:

> "Pandita, Vikram" <vikram.pandita@ti.com> writes:
>
>> For the omap board defconfigs, is there a plan to remove these  
>> entries:
>> CONFIG_SYSFS_DEPRECATED=y
>> CONFIG_SYSFS_DEPRECATED_V2=y
>>
>> I can see that on pm branch on kevin's tree, these are not enabled.
>>
>> With older busybox, I needed these entries to be enabled, but  
>> switching to latest busybox 1_9_2 I could disable these entries  
>> without problem.
>>
>> Anything we would break by removing these DEPRECATED entries?
>
> I vote to remove them since using OE or OE-based distros like Arago
> require them to be disabled.

And because most defconfigs are still using them I created this in OE:

http://cgit.openembedded.net/cgit.cgi/openembedded/commit/?id=40e3fb133a467addff6f63b712d3d3d680334e98

I suspect I'll need to create a similar one to turn on NEON :)

regards,

Koen

--Apple-Mail-2--929975828
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: Dit deel van het bericht is digitaal ondertekend
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFKgyEBMkyGM64RGpERAh96AJ0dYGZ/CFnZh8X+zJxc8j9XG0YKjQCdE5Y2
PIjbKLyeeYfGtn0hW6zR6mY=
=f37K
-----END PGP SIGNATURE-----

--Apple-Mail-2--929975828--
