From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [PATCH] [RFC] omap: 3630: default cpu_is_omap3630 to zero
Date: Mon, 12 Oct 2009 16:09:27 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C012A856FB3@dlee02.ent.ti.com>
References: <1255380685-26765-1-git-send-email-vikram.pandita@ti.com>
 <7A436F7769CA33409C6B44B358BFFF0C012A856FA5@dlee02.ent.ti.com>
 <FCCFB4CDC6E5564B9182F639FC35608702FA0D37E8@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39941 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757691AbZJLVKG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Oct 2009 17:10:06 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9CL9T9e011095
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 12 Oct 2009 16:09:29 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id n9CL9SKd000393
	for <linux-omap@vger.kernel.org>; Mon, 12 Oct 2009 16:09:28 -0500 (CDT)
Received: from dsbe71.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id n9CL9SIQ010877
	for <linux-omap@vger.kernel.org>; Mon, 12 Oct 2009 16:09:28 -0500 (CDT)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702FA0D37E8@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: Pandita, Vikram
> Sent: Monday, October 12, 2009 4:08 PM
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

Could you add them in a single patch please?

Regards,
Nishanth Menon
