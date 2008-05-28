From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: 2.6.26rc4 build error
Date: Wed, 28 May 2008 17:05:58 +0200
Message-ID: <9EEF473D-AA5F-49C0-875E-2D2676DCDC7C@student.utwente.nl>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.utsp.utwente.nl ([130.89.2.8]:43276 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750909AbYE1PGJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 May 2008 11:06:09 -0400
Received: from [172.20.1.5] (vpn006047.vpn.utwente.nl [130.89.6.47])
          by smtp.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id m4SF61cW019692
          for <linux-omap@vger.kernel.org>; Wed, 28 May 2008 17:06:01 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I tried building git HEAD today to get some 2.6.26rc4 goodness, but  
stumpled upon:

   CC      arch/arm/mach-omap2/mcbsp.o
arch/arm/mach-omap2/mcbsp.c:78: error: implicit declaration of  
function 'IO_ADDRESS'
arch/arm/mach-omap2/mcbsp.c:78: error: initializer element is not  
constant
arch/arm/mach-omap2/mcbsp.c:78: error: (near initialization for  
'omap2_mcbsp_pdata[0].virt_base')
arch/arm/mach-omap2/mcbsp.c:87: error: initializer element is not  
constant
arch/arm/mach-omap2/mcbsp.c:87: error: (near initialization for  
'omap2_mcbsp_pdata[1].virt_base')

I suspect that's caused by Eduardos "MCBSP: Tranform into platform  
driver" patches and 0001-ASoC-OMAP-Add-basic-support-for-OMAP34xx-in- 
McBSP.patch

Does anyone have updated patches for those?

regards,

Koen
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFIPXTZMkyGM64RGpERAsPJAJ9Wd5u9zTSvIFk+Js3S1aNJEzsLYACfX9aC
cXKA/AI1/ZjAldysMthnmPI=
=NaJu
-----END PGP SIGNATURE-----
