From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Subject: RE: [Patch v2 2/2] ARM: OMAP2: am33xx-hwmod: Fix "register offset
 NULL check" bug
Date: Fri, 1 Feb 2013 05:05:54 +0000
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EB5B145@DBDE01.ent.ti.com>
References: <1359642327-5542-1-git-send-email-gururaja.hebbar@ti.com>
 <1359642327-5542-3-git-send-email-gururaja.hebbar@ti.com>
 <alpine.DEB.2.00.1301311528320.23099@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34042 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750787Ab3BAFGG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Feb 2013 00:06:06 -0500
In-Reply-To: <alpine.DEB.2.00.1301311528320.23099@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Nori, Sekhar" <nsekhar@ti.com>, "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, Koen Kooi <koen@dominion.thruhere.net>

On Thu, Jan 31, 2013 at 21:00:32, Paul Walmsley wrote:
> + Koen
> 
> Hi
> 
> On Thu, 31 Jan 2013, Hebbar Gururaja wrote:
> 
> > am33xx_cm_wait_module_ready() checks if register offset is NULL.
> > 
> > int am33xx_cm_wait_module_ready(u16 inst, s16 cdoffs, u16 clkctrl_offs)
> > {
> > 	int i = 0;
> > 
> > 	if (!clkctrl_offs)
> > 		return 0;
> > 
> > In case of AM33xx, CLKCTRL register offset for different clock domains
> > are not uniformly placed. An example of this would be the RTC clock
> > domain with CLKCTRL offset at 0x00.
> > In such cases the module ready check is skipped which leads to a data
> > abort during boot-up when RTC registers is accessed.
> > 
> > Remove this check here to avoid checking module readiness for modules
> > with clkctrl register offset at 0x00.
> > 
> > Signed-off-by: Hebbar Gururaja <gururaja.hebbar@ti.com>
> 
> Some text has been added to the patch description to describe Koen's test 
> results, and the updated patch has been queued for v3.8-rc fixes.  Updated 
> patch follows.
> 
> - Paul


Thanks for the review & update.


Regards, 
Gururaja

> 
> From: Hebbar Gururaja <gururaja.hebbar@ti.com>
> Date: Thu, 31 Jan 2013 19:55:27 +0530
> Subject: [PATCH] ARM: OMAP2: am33xx-hwmod: Fix "register offset NULL check"
>  bug
> 
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
> Koen Kooi notes that this patch fixes a crash on boot with
> CONFIG_RTC_DRV_OMAP=y with v3.8-rc5.
> 
> Signed-off-by: Hebbar Gururaja <gururaja.hebbar@ti.com>
> Cc: Koen Kooi <koen@dominion.thruhere.net>
> [paul@pwsan.com: noted Koen's test in the patch description]
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/mach-omap2/cm33xx.c |    3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/cm33xx.c b/arch/arm/mach-omap2/cm33xx.c
> index 058ce3c..325a515 100644
> --- a/arch/arm/mach-omap2/cm33xx.c
> +++ b/arch/arm/mach-omap2/cm33xx.c
> @@ -241,9 +241,6 @@ int am33xx_cm_wait_module_ready(u16 inst, s16 cdoffs, u16 clkctrl_offs)
>  {
>  	int i = 0;
>  
> -	if (!clkctrl_offs)
> -		return 0;
> -
>  	omap_test_timeout(_is_module_ready(inst, cdoffs, clkctrl_offs),
>  			  MAX_MODULE_READY_TIME, i);
>  
> -- 
> 1.7.10.4
> 
> 

