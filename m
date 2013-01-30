From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v3] ARM: OMAP2: am33xx-hwmod: Fix "register offset NULL
 check" bug
Date: Wed, 30 Jan 2013 16:42:22 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1301301641490.17105@utopia.booyaka.com>
References: <1359556760-25214-1-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:46286 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754331Ab3A3QmX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Jan 2013 11:42:23 -0500
In-Reply-To: <1359556760-25214-1-git-send-email-gururaja.hebbar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hebbar Gururaja <gururaja.hebbar@ti.com>
Cc: tony@atomide.com, b-cousson@ti.com, khilman@deeprootsystems.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, sudhakar.raj@ti.com, linux@arm.linux.org.uk, hvaibhav@ti.com, vaibhav.bedia@ti.com

On Wed, 30 Jan 2013, Hebbar Gururaja wrote:

> am33xx_cm_wait_module_ready() checks if register offset is NULL.
> 
> int am33xx_cm_wait_module_ready(u16 inst, s16 cdoffs, u16 clkctrl_offs)
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
> 
> Remove this check here to avoid checking module readiness for modules
> with clkctrl register offset at 0x00.
> 
> Signed-off-by: Hebbar Gururaja <gururaja.hebbar@ti.com>

See 

http://marc.info/?l=linux-omap&m=135956399407076&w=2


- Paul
