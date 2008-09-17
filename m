From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: OMAP support in mainline?
Date: Wed, 17 Sep 2008 09:16:54 +0200
Message-ID: <9934E327-66E0-48DF-9FB6-FFF828E5358B@student.utwente.nl>
References: <87tzcgi1gv.fsf@nokia.com> <20080916232505.GC25885@atomide.com> <20080917082043.04c94e2d.jarkko.nikula@nokia.com> <200809162255.00918.david-b@pacbell.net>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-2-662962714"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp2.utsp.utwente.nl ([130.89.2.9]:46341 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751549AbYIQHTH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Sep 2008 03:19:07 -0400
In-Reply-To: <200809162255.00918.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Felipe Balbi <me@felipebalbi.com>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-2-662962714
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 17 sep 2008, om 07:55 heeft David Brownell het volgende geschreven:

> On Tuesday 16 September 2008, Jarkko Nikula wrote:
>>
>> I think one good measure for this whole work when one can can run
>> Beagle or Overo with mainline kernel.
>
> Yes ... ideally for 2.6.28 for both.  The Overo boards handed
> out at the kernel summit are a bit visible right now as not
> yet booting with mainline code.  :)

And they aren't working too well with current l-o git either with MUSB  
being broken. There's a patch to fix client mode, but host mode still  
isn't working.

regards,

Koen




>
>
>
>> That would require some "spring-cleaning" effort and getting core,
>> TWL4030, etc. patches out but then it is much more easier to send
>> remaining board files and other drivers to their relevant lists.
>
> My quick audit:
>
>  - core updates
>  - board files
>  - twl4030 ... converted to new-style, gpiolib, drivers/mfd
>  - hsmmc
>  - omap2 nand
>  - various pending musb updates
>
> FB support would be nice too, but IMO not if that means rushing
> the updates discussed lately.  Not all the TWL components would
> need to go upstream at once.
>
> - Dave
> --
> To unsubscribe from this list: send the line "unsubscribe linux- 
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--Apple-Mail-2-662962714
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFI0K7oMkyGM64RGpERAgINAJ0X0LHEOVBBXbu9nDpgMdm5nWOulACfW/1G
fgTnF+cnymyQmmMlu7FMKhs=
=JVMo
-----END PGP SIGNATURE-----

--Apple-Mail-2-662962714--
