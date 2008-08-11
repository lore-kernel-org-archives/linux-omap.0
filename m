From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: omap24xx is broken in current head
Date: Mon, 11 Aug 2008 16:59:44 +0200
Message-ID: <28085EBF-3BA7-4093-A18F-4035D5DD8040@student.utwente.nl>
References: <20080810115818.GG7574@frodo> <20080810121655.GH7574@frodo> <C558C578-1F45-433E-B82F-F5667CEBAFAF@student.utwente.nl> <1218388936.24010.138.camel@localhost> <20080811145053.GL25784@atomide.com>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-13--358583459"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx2.utsp.utwente.nl ([130.89.2.13]:39384 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751248AbYHKPAQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Aug 2008 11:00:16 -0400
In-Reply-To: <20080811145053.GL25784@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Igor Stoppa <igor.stoppa@nokia.com>, me@felipebalbi.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-13--358583459
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 11 aug 2008, om 16:50 heeft Tony Lindgren het volgende geschreven:

> * Igor Stoppa <igor.stoppa@nokia.com> [080810 20:39]:
>> On Sun, 2008-08-10 at 14:37 +0200, ext Koen Kooi wrote:
>>
>>> "Broken as hell" if you want to do anything NEON related with it.
>>
>> yup
>> Very unlucky but very true.
>>> I
>>> use 2007q3 with the -Os fix for compiling omap3 kernels
>>
>> Felipe: that's also what we should use internally, since it's the  
>> only
>> one approved by our system performance team.
>
> I'll revert this patch for now to avoid adding a compiler dependency
> as we already have a pile of other issues to solve.

Speaking of compiler dependencies, how about applying my patch that  
enable vanilla gcc to compile the kernel? Russel (or Erik) seems to be  
fond of rejecting my mails to the LAKML list, so I can't post it  
there. A copy of it can be found here:

http://ewi546.ewi.utwente.nl/git/?p=openembedded.git;a=blob;f=packages/linux/linux-omap2-git/beagleboard/no-harry-potter.diff;h=2bb20ab9c025312fcf0434de5bcb88aeceb4f87f;hb=HEAD

regards,

Koen

>
>
> Let's plan on re-applying this patch once the other issues are out of
> the way.
>
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux- 
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--Apple-Mail-13--358583459
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFIoFPiMkyGM64RGpERAoQUAJ9LYGCh32b37yPOPnVl8K4ffe6AcQCcC0Qi
fUNZBBiaGZUNZBuHAQut+b4=
=vb1j
-----END PGP SIGNATURE-----

--Apple-Mail-13--358583459--
