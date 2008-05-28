From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: 2.6.26rc4 build error
Date: Thu, 29 May 2008 01:06:44 +0200
Message-ID: <AC3EBEAE-0562-4EBF-8498-AAB3DCB78B88@student.utwente.nl>
References: <9EEF473D-AA5F-49C0-875E-2D2676DCDC7C@student.utwente.nl> <20080528154351.GX8845@atomide.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx2.utsp.utwente.nl ([130.89.2.13]:42383 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754103AbYE1XHD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 May 2008 19:07:03 -0400
Received: from [172.20.1.5] (vpn006023.vpn.utwente.nl [130.89.6.23])
          by mx.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id m4SN6jlg004142
          for <linux-omap@vger.kernel.org>; Thu, 29 May 2008 01:06:46 +0200
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

That indeed fixed the compile error, and even better: it was the only  
error :)

regards,

Koen

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFIPeWFMkyGM64RGpERAsM7AKCn9Sh7k7Rh0mX2iFpkWWQDYZR0cwCdEHgW
MIIspt3BbVY+Ssjv2IaYkVA=
=lXyi
-----END PGP SIGNATURE-----
