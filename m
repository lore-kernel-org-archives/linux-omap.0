From: Felipe Balbi <me@felipebalbi.com>
Subject: RE: [PATCH 1/4] Updating Kconfig and Makefile for OMAP3 EVM support
Date: Tue, 15 Apr 2008 04:33:53 -0500
Message-ID: <0d3cf630a9b3224f095a15864f78a779@felipebalbi.com>
References: <7EAD1AEEA7621C45899FE99123E124A0018C8603@dbde01.ent.ti.com> <20080414180447.GA4463@kedavra.cpe.vivax.com.br> <7EAD1AEEA7621C45899FE99123E124A0018C8749@dbde01.ent.ti.com> <e2a24afe53a509270888ce07ab944818@felipebalbi.com> <7EAD1AEEA7621C45899FE99123E124A0018C87BA@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:40961 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755314AbYDOJdz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Apr 2008 05:33:55 -0400
In-Reply-To: <7EAD1AEEA7621C45899FE99123E124A0018C87BA@dbde01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Syed Mohammed, Khasim" <khasim@ti.com>
Cc: linux-omap@vger.kernel.org



On Tue, 15 Apr 2008 14:50:20 +0530, "Syed Mohammed, Khasim" <khasim@ti.com>
wrote:
> 
>> 
>> >> > Index: my_branch/arch/arm/mach-omap2/Kconfig
>> >> >
> ===================================================================
>> >> > --- my_branch.orig/arch/arm/mach-omap2/Kconfig	2008-04-14
>> >> 16:07:11.000000000 +0530
>> >> > +++ my_branch/arch/arm/mach-omap2/Kconfig	2008-04-14
>> >> 16:07:41.000000000 +0530
>> >> > @@ -98,10 +98,14 @@
>> >> >  	bool "OMAP 2430 SDP board"
>> >> >  	depends on ARCH_OMAP2 && ARCH_OMAP2430
>> >> >
>> >> > +config MACH_OMAP_2430OSK
>> >> > +	bool "OMAP 2430 OSK board"
>> >> > +	depends on ARCH_OMAP2 && ARCH_OMAP24XX
>> >> > +
>> >> >  config MACH_OMAP_3430SDP
>> >> >  	bool "OMAP 3430 SDP board"
>> >> >  	depends on ARCH_OMAP3 && ARCH_OMAP34XX
>> >> >
>> >> > -config MACH_OMAP_2430OSK
>> >> > -	bool "OMAP 2430 OSK board"
>> >> > -	depends on ARCH_OMAP2 && ARCH_OMAP24XX
>> >> > +config MACH_OMAP3EVM
>> >> > +	bool "OMAP 3530 EVM board"
>> >> > +	depends on ARCH_OMAP3 && ARCH_OMAP34XX
>> >>
>> >> Do you really need to move 2430OSK here?
>> >> It looks like unnecessary change.
>> >>
>> >> please revert.
>> >>
>> > This change is good as it lists all omap2 followed by omap3 boards.
>> > Otherwise it mixes OMAP2 boards with OMAP3 boards.
>> 
>> so put it in a separate patch. It has nothing to do with
>> "Adding support for OMAP3 EVM"
> 
> Why? ???
> 
> These lines add OMAP3 EVM
> 
> +config MACH_OMAP3EVM
> +	bool "OMAP 3530 EVM board"
> +	depends on ARCH_OMAP3 && ARCH_OMAP34XX
> 
> The other lines are re-arranging OMAP2 and OMAP3 boards. 

Yes, re-arranging omap2/3 is another "task". Has nothing to do with
"adding omap3 evm". I'd rather see these two changes split in two
separate patches but Tony might be the one with the final word anyway. :-p
If he's ok with this patch...

> 
> We can make two separate patches but this fix seems to be simple.
-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me@felipebalbi.com

