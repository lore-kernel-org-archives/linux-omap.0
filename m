From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 00/14] GPMC driver conversion
Date: Wed, 13 Jun 2012 05:33:05 -0700
Message-ID: <20120613123305.GS12766@atomide.com>
References: <cover.1339419492.git.afzal@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998065@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:14143 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961Ab2FMMdJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jun 2012 08:33:09 -0400
Content-Disposition: inline
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E998065@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Mohammed, Afzal <afzal@ti.com> [120612 03:44]:
> Hi Tony,
> 
> On Mon, Jun 11, 2012 at 19:55:02, Mohammed, Afzal wrote:
> > Hi,
> > 
> > This series is based on 3.5-rc1, and is dependent on [1,2,3]
> > 
> > This series has been tested on omap3evm (smsc911x) rev G & C and
> > beagle board(nand) using patch series which is going to be posted
> > shortly (this series only creates a driver out of GPMC code)
> > 
> > Also using private patches, nand & onenand was tested on omap3evm,
> > rev G & C respectively (as support for these were not in mainline)
> > 
> > Many of GPMC peripherals depend on bootloader for configuration.
> > This is going to be deprecated. feature-removal-schedule.txt will be
> > updated in one of the upcoming patch series regarding the same.
> > 
> > 
> > [PATCH 03/13] ARM: OMAP2+: gpmc: driver migration helper, is to be
> > reverted once all GPMC peripherals are migrated to use driver
> > interface.
> 
> Please let me know your comments on this series. I had tried to
> go as per your requirements.
> 
> This series keeps old interface while providing a new driver interface.
> Old interface will work (to the best of my knowledge; omap3evm &
> beagle are the ones available here to test) at each of the commits.

Cool, yeah looks like the old interface almost works. I had to undo the
new additions for tusb6010 DMA to work as below. Then Jon has some good
comments. I also made few comments to the GPMC using driver changes.

In general, please keep in mind that eventually we want this to be
a regular device driver that also works as a loadable module.

And we need the device tree bindings for GPMC so we can start dropping
board-*.c files as the GPMC seems to be last remaining blocker for
making rarely used legacy boards DT only. So it might be worth
playing with that so we don't again have to redo some parts.

Regards,

Tony

--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -363,13 +363,13 @@ int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t)
 	GPMC_SET_ONE(GPMC_CS_CONFIG5, 16, 20, access);
 
 	GPMC_SET_ONE(GPMC_CS_CONFIG5, 24, 27, page_burst_access);
-
+#if 0
 	GPMC_SET_ONE(GPMC_CS_CONFIG6, 0, 3, bus_turnaround);
 	GPMC_SET_ONE(GPMC_CS_CONFIG6, 8, 11, cycle2cycle_delay);
 
 	GPMC_SET_ONE(GPMC_CS_CONFIG1, 18, 19, wait_monitoring);
 	GPMC_SET_ONE(GPMC_CS_CONFIG1, 25, 26, clk_activation);
-
+#endif
 	if (cpu_is_omap34xx()) {
 		GPMC_SET_ONE(GPMC_CS_CONFIG6, 16, 19, wr_data_mux_bus);
 		GPMC_SET_ONE(GPMC_CS_CONFIG6, 24, 28, wr_access);

