From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [PATCH 1/1] ARM: OMAP: omap3beagle: register SD interface
Date: Tue, 22 Apr 2008 15:37:29 +0200
Message-ID: <5E78D228-87CA-4D98-B11E-DDABC05DE638@student.utwente.nl>
References: <3A21C48B-9730-4BB7-9095-B08510070F7D@student.utwente.nl> <7EAD1AEEA7621C45899FE99123E124A001922608@dbde01.ent.ti.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.utsp.utwente.nl ([130.89.2.12]:36000 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764960AbYDVNkt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Apr 2008 09:40:49 -0400
In-Reply-To: <7EAD1AEEA7621C45899FE99123E124A001922608@dbde01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Syed Mohammed, Khasim" <khasim@ti.com>
Cc: linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Op 22 apr 2008, om 11:18 heeft Syed Mohammed, Khasim het volgende  
geschreven:
>
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Koen Kooi
>> Sent: Tuesday, April 22, 2008 1:28 PM
>> To: linux-omap@vger.kernel.org
>> Subject: [PATCH 1/1] ARM: OMAP: omap3beagle: register SD interface
>>
>> In case of broken-mailer-white-space-damage:
>> http://amethyst.openembedded.net/~koen/beagleboard/0001-omap3beagle-
>> register-SD-interface.patch
>>
>> From a4127c880913185919f065800535c8d90751ac3c Mon Sep 17 00:00:00  
>> 2001
>> From: Koen Kooi <koen@openembedded.org>
>> Date: Tue, 22 Apr 2008 09:45:45 +0200
>> Subject: [PATCH] omap3beagle: register SD interface
>>
>> Signed-off-by: Koen Kooi <koen@openembedded.org>
>> - ---
>> arch/arm/mach-omap2/Makefile            |    3 ++-
>> arch/arm/mach-omap2/board-omap3beagle.c |   11 +++++++++++
>
>
>> arch/arm/mach-omap2/board-omap3beagle.h |   12 ++++++++++++
>
> Why new header file ? We can use the existing include/asm-arm/arch- 
> omap/board-omap3beagle.h

Aargh, not enough coffee, will redo the patch and send the usb one as  
well.

regards,

Koen
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFIDeobMkyGM64RGpERAmciAKCR1HJRl/2OBNy5tC5GgYbOShMB2QCeI6Cr
rAIBduCcZHo1R1cJX1j6xxg=
=2+j4
-----END PGP SIGNATURE-----
