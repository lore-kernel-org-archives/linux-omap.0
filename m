From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 1/3] ARM: OMAP: TI81XX: Prepare for addition of
 TI814X support
Date: Fri, 9 Dec 2011 12:52:04 -0800
Message-ID: <20111209205203.GV31337@atomide.com>
References: <1318210796-2357-1-git-send-email-hemantp@ti.com>
 <20111207231741.GP31337@atomide.com>
 <DDE393F022194E4FB9AE108B0AECD70C042A54@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:46220 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750761Ab1LIUwH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Dec 2011 15:52:07 -0500
Content-Disposition: inline
In-Reply-To: <DDE393F022194E4FB9AE108B0AECD70C042A54@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pedanekar, Hemant" <hemantp@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>

* Pedanekar, Hemant <hemantp@ti.com> [111209 09:57]:
> Tony Lindgren wrote on Thursday, December 08, 2011 4:48 AM:
> 
> > * Hemant Pedanekar <hemantp@ti.com> [111009 18:06]:
> >> This patch updates existing macros, functions used for TI816X, to enable
> >> addition of other SoCs belonging to TI81XX family (e.g., TI814X).
> >> 
> >> The approach taken is to use TI81XX/ti81xx for code/data going to be
> >> common across all TI81XX devices. 
> >> 
> >> cpu_is_ti81xx() is introduced to handle code common across TI81XX devices.
> >> 
> >> In addition, ti8168_evm_map_io() is now replaced with ti81xx_map_io() and
> >> moved in mach-omap2/common.c as same will be used for TI814X and is not
> >> board specific.
> > 
> > Looks like this series needs a rebase after the map_io and common.h
> > changes. Can you please rebase against the current omap soc branch at
> > commit 24a5e092a387e4c8e93f33448da334bd3fd15192?
> > 
> > Regards,
> > 
> > Tony
> 
> Thanks Tony, I sent v5 in the morning but it didnlt reach the ML
> may be because I got unsubscribed for some reason.

Yeah not seeing it :(
 
> Btw, I am getting following error when trying to build from soc branch:
> 
> make[1]: *** No rule to make target `arch/arm/mach-omap2/omap-smc.o', needed by `arch/arm/mach-omap2/built-in.o'.  Stop.
> 
> Looks like the commit c95f06a0d4bc9c2546769b5d984cc2dc6665d4f5 added
> Following but not the corresponding c file(s):
> 
>  +secure-common                          = omap-smc.o omap-secure.o

Thanks for letting me know, that means there's a dependency to the omap4
branch, I'll update the soc branch accordingly.

Regards,

Tony
