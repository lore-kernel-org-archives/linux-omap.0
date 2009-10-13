From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] [RFC] omap: 3630: default cpu_is_omap3630 to zero
Date: Tue, 13 Oct 2009 15:33:49 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BB254E67@dbde02.ent.ti.com>
References: <1255380685-26765-1-git-send-email-vikram.pandita@ti.com>
 <7A436F7769CA33409C6B44B358BFFF0C012A856FA5@dlee02.ent.ti.com>
 <FCCFB4CDC6E5564B9182F639FC35608702FA0D37E8@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43908 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756176AbZJMKEa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Oct 2009 06:04:30 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9DA3og7004181
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 13 Oct 2009 05:03:53 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n9DA3ouq019338
	for <linux-omap@vger.kernel.org>; Tue, 13 Oct 2009 15:33:50 +0530 (IST)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702FA0D37E8@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>, "Menon, Nishanth" <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Has anybody tried building latest linux-omap master ? The build is breaking for other OMAP processors.

CC      arch/arm/mach-omap2/id.o
arch/arm/mach-omap2/id.c: In function 'omap3_cpuinfo':
arch/arm/mach-omap2/id.c:269: error: implicit declaration of function 'cpu_is_omap3630'
make[1]: *** [arch/arm/mach-omap2/id.o] Error 1
make: *** [arch/arm/mach-omap2] Error 2

This is because of " 0a9b95f21995aa3cdda82ebc6e77b0b2ab401861"
	omap: Introduce OMAP3630

Below patch from Vikram fixes the build break.

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Pandita, Vikram
> Sent: Tuesday, October 13, 2009 2:38 AM
> To: Menon, Nishanth
> Cc: linux-omap@vger.kernel.org
> Subject: RE: [PATCH] [RFC] omap: 3630: default cpu_is_omap3630 to zero
> 
> 
> 
> >-----Original Message-----
> >From: Menon, Nishanth
> >Sent: Monday, October 12, 2009 4:05 PM
> >To: Pandita, Vikram
> >Cc: linux-omap@vger.kernel.org
> >Subject: RE: [PATCH] [RFC] omap: 3630: default cpu_is_omap3630 to zero
> >
> >> -----Original Message-----
> >> From: Pandita, Vikram
> >> Sent: Monday, October 12, 2009 3:51 PM
> >>
> >> make default cpu_is_omap3630() return zero
> >>
> >> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> >> ---
> >>  arch/arm/plat-omap/include/mach/cpu.h |    2 ++
> >>  1 files changed, 2 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/arch/arm/plat-omap/include/mach/cpu.h b/arch/arm/plat-
> >> omap/include/mach/cpu.h
> >> index da9e8f8..940946e 100644
> >> --- a/arch/arm/plat-omap/include/mach/cpu.h
> >> +++ b/arch/arm/plat-omap/include/mach/cpu.h
> >> @@ -322,6 +322,7 @@ IS_OMAP_TYPE(3430, 0x3430)
> >>  #define cpu_is_omap2423()		0
> >>  #define cpu_is_omap2430()		0
> >>  #define cpu_is_omap3430()		0
> >> +#define cpu_is_omap3630()		0
> >>
> >>  /*
> >>   * Whether we have MULTI_OMAP1 or not, we still need to distinguish
> >> @@ -386,6 +387,7 @@ IS_OMAP_TYPE(3430, 0x3430)
> >>  						(omap3_has_sgx()) &	\
> >>  						(!omap3_has_iva()))
> >>  # define cpu_is_omap3530		(cpu_is_omap3430())
> >> +# undef cpu_is_omap3630()
> >>  # define cpu_is_omap3630()		is_omap363x()
> >>  #endif
> >Dumb question: why is this needed? cpu_is_omap3530,15,25,03 don't seems
> to declare these..
> 
> If in some file, you want to distinguish between 3630 vs 3430,
> and the build is for 3430 only, then cpu_is_omap3630() should return 0.
> 
> Eg: opp table allocation based on run time check
> 
> Omap35xx may also need it for the opp in future I guess.
>
