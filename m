From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: 2.6.26rc4 build error
Date: Wed, 28 May 2008 17:56:15 +0200
Message-ID: <73F48642-4E9A-4A38-8BEF-9FF7417A1DF2@student.utwente.nl>
References: <9EEF473D-AA5F-49C0-875E-2D2676DCDC7C@student.utwente.nl> <20080528154351.GX8845@atomide.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp2.utsp.utwente.nl ([130.89.2.9]:55717 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752040AbYE1QEa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 May 2008 12:04:30 -0400
Received: from [172.20.1.5] (vpn006047.vpn.utwente.nl [130.89.6.47])
          by smtp.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id m4SFuGuq030825
          for <linux-omap@vger.kernel.org>; Wed, 28 May 2008 17:56:17 +0200
In-Reply-To: <20080528154351.GX8845@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Op 28 mei 2008, om 17:43 heeft Tony Lindgren het volgende geschreven:

> Hi,
>
> * Koen Kooi <k.kooi@student.utwente.nl> [080528 08:06]:
>> Hi,
>>
>> I tried building git HEAD today to get some 2.6.26rc4 goodness, but
>> stumpled upon:
>>
>>   CC      arch/arm/mach-omap2/mcbsp.o
>> arch/arm/mach-omap2/mcbsp.c:78: error: implicit declaration of
>> function 'IO_ADDRESS'
>> arch/arm/mach-omap2/mcbsp.c:78: error: initializer element is not
>> constant
>> arch/arm/mach-omap2/mcbsp.c:78: error: (near initialization for
>> 'omap2_mcbsp_pdata[0].virt_base')
>> arch/arm/mach-omap2/mcbsp.c:87: error: initializer element is not
>> constant
>> arch/arm/mach-omap2/mcbsp.c:87: error: (near initialization for
>> 'omap2_mcbsp_pdata[1].virt_base')
>>
>> I suspect that's caused by Eduardos "MCBSP: Tranform into platform
>> driver" patches and 0001-ASoC-OMAP-Add-basic-support-for-OMAP34xx-in-
>> McBSP.patch
>>
>> Does anyone have updated patches for those?
>
> Sounds like you need to #include <linux/io.h> from mcbsp.c.
>
> Based on the fact that it's at mach-omap2/mcbsp.o, I guess you're
> trying out the unmerged mcbsp patches?

AFAIK they are still unmerged.

regards,

Koen

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFIPYCgMkyGM64RGpERAolEAJkB8/mMCnHTPRhBNhTv5Wy8CLqPpwCdGRbO
KjGsI2FdfoVj8bcNF7qoCIM=
=62e1
-----END PGP SIGNATURE-----
