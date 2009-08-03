From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: VDD2 setting question
Date: Mon, 3 Aug 2009 16:49:06 +0200
Message-ID: <3DB2B9F4-7903-47BA-9E66-1E34C512A3FD@student.utwente.nl>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-5-420806841"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp2.utsp.utwente.nl ([130.89.2.9]:57696 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932290AbZHCPZt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Aug 2009 11:25:49 -0400
Received: from [172.20.1.5] (vpn006014.vpn.utwente.nl [130.89.6.14])
          by smtp.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id n73EnAFN019975
          for <linux-omap@vger.kernel.org>; Mon, 3 Aug 2009 16:49:11 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Users <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-5-420806841
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit

Hi,

I'm to trying to lower VDD2 on beagleboard to something slightly below  
1V instead of the current slightly above 1V setting, but I'm having a  
hard time figuring out how to do that in the linux-omap (non-PM) tree.
I grepped in (admittedly 2.6.29) arch/arm/mach-omap2 and it only  
returned hits that seem to be related to smartreflex. Now, enabling  
smartreflex would accomplish my goal if the beagleboards had there  
efuses blown, which they didn't and the debug values make some of my  
boards lock up :( So the questions I have are:

o How do I lower VDD2 in the non-PM kernel, should I be doing it in  
uboot or in the kernel?
o For the PM kernel, where should I go patching the VDD2 reference  
value?

And the most important question:

o Would a patch to lower the default value of VDD2 be accepted into  
the tree? Can it be lowered globally or should it be guarded with an  
machine_is_omap3beagle() clause?

regards,

Koen

--Apple-Mail-5-420806841
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: Dit deel van het bericht is digitaal ondertekend
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFKdvjmMkyGM64RGpERAhphAJ9jDGRE16JoLYIdQOHrp/ekVPWHmQCfUQDo
MnzF+hDVhEjAu+e5ybKuUgY=
=LSsk
-----END PGP SIGNATURE-----

--Apple-Mail-5-420806841--
