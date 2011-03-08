From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/2] omap_wdt: fix interface clock handling
Date: Tue, 8 Mar 2011 16:01:36 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103081543430.10981@utopia.booyaka.com>
References: <1299589583-22632-1-git-send-email-kalle.jokiniemi@nokia.com> <87bp1lv8uc.fsf@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57027 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755904Ab1CHXBi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Mar 2011 18:01:38 -0500
In-Reply-To: <87bp1lv8uc.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, b-cousson@ti.com, ilkka.koskinen@nokia.com, Charulatha Varadarajan <charu@ti.com>, wim@iguana.be

Hi,

On Tue, 8 Mar 2011, Kevin Hilman wrote:

> Kalle Jokiniemi <kalle.jokiniemi@nokia.com> writes:
> 
> > The runtime PM does not offer enough granularity to control
> > individual clocks separately as needed. Current pm implementation
> > of omap_wdt blocks the CORE power domain from idling in
> > OMAP SoC, as it keeps the interface clock of the watchdog always
> > on. This causes severe power leakage in devices where 
> > the omap watchdog is in active use.
> 
> The iclk remains active because it's in hardware-controlled
> auto-idle mode.  

... and we think that the interface clock never enters auto-idle because 
the WDT doesn't SIdleAck to the PRCM until the special sequence has been 
written to the WDT registers to disable it.  So even if its *CLKEN bits 
are set to zero, the WDT prevents the system from going idle.

> I believe if you set the WDT hwmod to software-supported idle
> (OCPIF_SWSUP_IDLE), the runtime PM idle (which calls omap_device idle,
> then omap_hwmod_idle) should also gate the interface clock.

Agreed.

Kalle, since you requested patches, here's one that implements Kevin's 
first suggestion.  I will reply to your second patch with its equivalent 
for PM runtime.  The patches have been compile-tested only.  Perhaps you 
could see if they solve your problem?


regards,

- Paul

---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |    1 +
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    1 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    1 +
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    1 +
 4 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index 1611f74..df4950d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -974,6 +974,7 @@ static struct omap_hwmod_ocp_if omap2420_l4_wkup__wd_timer2 = {
 	.clk		= "mpu_wdt_ick",
 	.addr		= omap2420_wd_timer2_addrs,
 	.addr_cnt	= ARRAY_SIZE(omap2420_wd_timer2_addrs),
+	.flags		= OCPIF_SWSUP_IDLE,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 809424f..21fc908 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -1074,6 +1074,7 @@ static struct omap_hwmod_ocp_if omap2430_l4_wkup__wd_timer2 = {
 	.clk		= "mpu_wdt_ick",
 	.addr		= omap2430_wd_timer2_addrs,
 	.addr_cnt	= ARRAY_SIZE(omap2430_wd_timer2_addrs),
+	.flags		= OCPIF_SWSUP_IDLE,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 457df3e..7ae2dab 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1234,6 +1234,7 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_wkup__wd_timer2 = {
 	.clk		= "wdt2_ick",
 	.addr		= omap3xxx_wd_timer2_addrs,
 	.addr_cnt	= ARRAY_SIZE(omap3xxx_wd_timer2_addrs),
+	.flags		= OCPIF_SWSUP_IDLE,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 7b72316..2038813 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -4901,6 +4901,7 @@ static struct omap_hwmod_ocp_if omap44xx_l4_wkup__wd_timer2 = {
 	.clk		= "l4_wkup_clk_mux_ck",
 	.addr		= omap44xx_wd_timer2_addrs,
 	.addr_cnt	= ARRAY_SIZE(omap44xx_wd_timer2_addrs),
+	.flags		= OCPIF_SWSUP_IDLE,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-- 
1.7.2.3

