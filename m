From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH][RFC] OMAP3630: Create architecture macros and config
 entries.
Date: Mon, 21 Sep 2009 01:16:15 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BABA35A6@dbde02.ent.ti.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E9402534261B3@dbde02.ent.ti.com>
 <74583B8642AB8841B30447520659FCA9DD85B939@dnce01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37418 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755081AbZITTqT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 20 Sep 2009 15:46:19 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n8KJkLGi012456
	for <linux-omap@vger.kernel.org>; Sun, 20 Sep 2009 14:46:22 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n8KJkLkk026145
	for <linux-omap@vger.kernel.org>; Mon, 21 Sep 2009 01:16:21 +0530 (IST)
In-Reply-To: <74583B8642AB8841B30447520659FCA9DD85B939@dnce01.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>, "Pais, Allen" <allen.pais@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Raju, Veeramanikandan" <veera@ti.com>, "Bongale, Hariprasad" <hariprasad.bongale@ti.com>

Allen,

>  	depends on ARCH_OMAP3 && ARCH_OMAP34XX
> 
> +config MACH_OMAP_3630SDP
> +	bool "OMAP 3630 SDP board"
> +	depends on ARCH_OMAP3 && ARCH_OMAP34XX & ARCH_OMAP36XX
> +
>  config MACH_NOKIA_N8X0
>  	bool "Nokia N800/N810"
>  	depends on ARCH_OMAP2420
> diff --git a/arch/arm/plat-omap/include/mach/cpu.h b/arch/arm/plat-
> omap/include/mach/cpu.h
> index 7a5f9e8..73c656c 100755
> --- a/arch/arm/plat-omap/include/mach/cpu.h
> +++ b/arch/arm/plat-omap/include/mach/cpu.h
> @@ -157,10 +157,12 @@ IS_OMAP_CLASS(15xx, 0x15)
>  IS_OMAP_CLASS(16xx, 0x16)
>  IS_OMAP_CLASS(24xx, 0x24)
>  IS_OMAP_CLASS(34xx, 0x34)
> +IS_OMAP_CLASS(36xx, 0x36)

###############################
OMAP3630 is "just" an OMAP3430 in disguise. 
I don't think it deserves a new class. It should probably be handled like it was done for 1610 and 1710.

Theoretically, it should be considered as a 3430 ES4.0, because it is an OMAP3430 ES3 + couple of bug fixes + couple of improvements. 

I think, that the proposal from Sanjeev to support 35xx (http://marc.info/?l=linux-omap&m=125050987112798&w=2 ) might be leveraged to handle 36xx as well.   
###############################

I too second Benoit point here.

A single runtime macro like "cpu_is_omap36xx()" should be good enough to add additional code for 3630.

May be we can keep all 3430 switches by default enabled for 3630 and wherever necessary additional 3630 specific code can be added using the runtime switch like " cpu_is_omap36xx()".

Regards,
Santosh
