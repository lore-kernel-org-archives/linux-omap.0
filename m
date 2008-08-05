From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [PATCH] Added support for OMAP35x processor series
Date: Tue, 5 Aug 2008 12:10:40 +0200
Message-ID: <9F0A21B6-F565-42A7-9134-4AAF15DDFD62@student.utwente.nl>
References: <premi@ti.com> <1217591379-1515-1-git-send-email-premi@ti.com> <20080805092523.GK7193@atomide.com> <B85A65D85D7EB246BE421B3FB0FBB593013C9AEC8E@dbde02.ent.ti.com> <1217929845.16579.164.camel@localhost>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-16--894328395"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.utsp.utwente.nl ([130.89.2.12]:42994 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757093AbYHEKK7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Aug 2008 06:10:59 -0400
In-Reply-To: <1217929845.16579.164.camel@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jason Kridner <jdk@ti.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-16--894328395
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 5 aug 2008, om 11:50 heeft Igor Stoppa het volgende geschreven:

> On Tue, 2008-08-05 at 15:09 +0530, ext Premi, Sanjeev wrote:
>> This patch is needed to ensure that we can make decisions based on  
>> the processor capabilities.
>> E.g. OMAP3503 does not contain a DSP. We shouldn't be trying to  
>> disable/ manage the clocks for
>> DSP on this processor. Same for SGX.
>
> Why can't the detection happen at runtime?

AIUI the ID bits are the same (linux misdetect the 3530 on my beagle  
for a 3430). I heard that the only definitive way to do it at runtime  
is to CRC check the ROM code.

Jason, is that correct?

regards,

Koen

>> Enabling NEON is support iby default is just based on the number of  
>> requests I have been getting
>> from various users.
>
> Huh?
>
>
> -- 
>
> Cheers, Igor
>
> ---
>
> Igor Stoppa
> Maemo Software - Nokia Devices R&D - Helsinki
> --
> To unsubscribe from this list: send the line "unsubscribe linux- 
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--Apple-Mail-16--894328395
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFImCchMkyGM64RGpERAgbYAJ9t0136q/uHW1wYS3v6vrWFQxM1bACgjRpk
LfjPStLHbdC6VRW454dgGkY=
=iO8l
-----END PGP SIGNATURE-----

--Apple-Mail-16--894328395--
