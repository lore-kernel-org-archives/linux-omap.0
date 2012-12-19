From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2] ARM: OMAP2: hwmod: Fix "register offset NULL check"
 bug
Date: Wed, 19 Dec 2012 02:13:50 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1212190210021.2446@utopia.booyaka.com>
References: <1355835378-23437-1-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:43951 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753999Ab2LSCNv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Dec 2012 21:13:51 -0500
In-Reply-To: <1355835378-23437-1-git-send-email-gururaja.hebbar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hebbar Gururaja <gururaja.hebbar@ti.com>
Cc: tony@atomide.com, b-cousson@ti.com, khilman@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, sudhakar.raj@ti.com, linux@arm.linux.org.uk

On Tue, 18 Dec 2012, Hebbar Gururaja wrote:

> From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
> 
> omap4_cminst_wait_module_ready() checks if register offset is NULL.
> 
> int omap4_cminst_wait_module_ready(u8 part, u16 inst, s16 cdoffs,
> 				   u16 clkctrl_offs)
> {
> 	int i = 0;
> 
> 	if (!clkctrl_offs)
> 		return 0;
> 
> In case of AM33xx, CLKCTRL register offset for different clock domains
> are not uniformly placed. An example of this would be the RTC clock
> domain with CLKCTRL offset at 0x00.
> In such cases the module ready check is skipped which leads to a data
> abort during boot-up when RTC registers is accessed.

We've got a few hwmods on OMAP44xx that don't have clkctrl_offs registers 
listed in the hwmod data, and which are not marked with HWMOD_NO_IDLEST.  
What's going to happen in those cases?


- Paul
