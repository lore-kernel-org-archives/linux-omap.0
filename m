From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: omap clocksource timer selection: dmtimer OR 32K-Sync timer
Date: Fri, 13 Jan 2012 12:21:32 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A8317A4E2E@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46369 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753134Ab2AMMVq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jan 2012 07:21:46 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Russell King <rmk@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi,

In case of AM33xx family of devices, we do not have 32K Sync timer 
(32K Counter) available; and the current implementation is based on 
compile-time option, where clock-source is chosen by something like,

File - arch/arm/mach-omap2/timer.c

#ifdef CONFIG_OMAP_32K_TIMER
static void __init omap2_gp_clocksource_init(int unused, const char *dummy)
{
...
}
#else
static void __init omap2_gp_clocksource_init(int unused, const char *dummy)
{
...
}
#endif


But in order to support multi-omap build, we must
make run-time decision to use the timer for kernel clock-source, either of -

 - DMTIMER
 - 32K Sync Timer

The DMTIMER is already migrated to the HWMOD framework, but 32K Timer code
has not yet migrated to it. So the question here is,

1) Does it make sense to migrate counter_32k.c to search entry in hwmod 
   table and if 32k_sync timer is available in hwmod table then use 32K   
   timer for Kernel clock-source 
   OR 
   Fall back to DMTIMER.

   OMAP4 hwmod table already has entry,

   static struct omap_hwmod omap44xx_counter_32k_hwmod = {
         .name           = "counter_32k",
   ...
   };

   We need to have similar entries in all devices where 32K timer is present.

2) OR simply add another cpu_is_am33xx() and then fall back to dmtimer?
   Just to prove this, everything works here, I modified the code for this
   and tested it on both AM335x EVM and AM37xEVM and it works fine for me.


Any comments?? OR Better approach? OR anything which I am missing here?

Thanks,
Vaibhav

