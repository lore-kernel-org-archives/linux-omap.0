From: "Pedanekar, Hemant" <hemantp@ti.com>
Subject: RE: [PATCH v4 1/3] ARM: OMAP: TI81XX: Prepare for addition of
 TI814X support
Date: Fri, 9 Dec 2011 18:29:25 +0000
Message-ID: <DDE393F022194E4FB9AE108B0AECD70C042A54@DBDE01.ent.ti.com>
References: <1318210796-2357-1-git-send-email-hemantp@ti.com>
 <20111207231741.GP31337@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44868 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752153Ab1LIS3f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Dec 2011 13:29:35 -0500
In-Reply-To: <20111207231741.GP31337@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>

Tony Lindgren wrote on Thursday, December 08, 2011 4:48 AM:

> * Hemant Pedanekar <hemantp@ti.com> [111009 18:06]:
>> This patch updates existing macros, functions used for TI816X, to enable
>> addition of other SoCs belonging to TI81XX family (e.g., TI814X).
>> 
>> The approach taken is to use TI81XX/ti81xx for code/data going to be
>> common across all TI81XX devices. 
>> 
>> cpu_is_ti81xx() is introduced to handle code common across TI81XX devices.
>> 
>> In addition, ti8168_evm_map_io() is now replaced with ti81xx_map_io() and
>> moved in mach-omap2/common.c as same will be used for TI814X and is not
>> board specific.
> 
> Looks like this series needs a rebase after the map_io and common.h
> changes. Can you please rebase against the current omap soc branch at
> commit 24a5e092a387e4c8e93f33448da334bd3fd15192?
> 
> Regards,
> 
> Tony

Thanks Tony, I sent v5 in the morning but it didnlt reach the ML
may be because I got unsubscribed for some reason.

Btw, I am getting following error when trying to build from soc branch:

make[1]: *** No rule to make target `arch/arm/mach-omap2/omap-smc.o', needed by `arch/arm/mach-omap2/built-in.o'.  Stop.

Looks like the commit c95f06a0d4bc9c2546769b5d984cc2dc6665d4f5 added
Following but not the corresponding c file(s):

 +secure-common                          = omap-smc.o omap-secure.o

   Hemant