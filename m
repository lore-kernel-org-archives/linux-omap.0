From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH] omap3: cm-t35: add mux initialization (was: Re: [PATCH] omap3:
 cm-t35: add mux initialization)
Date: Wed, 09 Dec 2009 15:27:53 +0200
Message-ID: <4B1FA5D9.4010400@compulab.co.il>
References: <cover.1259481545.git.mike@compulab.co.il> <4B1BCE62.1050005@compulab.co.il> <20091207162209.GV24013@atomide.com> <5A47E75E594F054BAF48C5E4FC4B92AB0309C863C8@dbde02.ent.ti.com> <20091207174446.GY24013@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:59751 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755823AbZLIN1v (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Dec 2009 08:27:51 -0500
In-Reply-To: <20091207174446.GY24013@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Mike Rapoport <mike@compulab.co.il>

Tony,

Tony Lindgren wrote:
> * Gadiyar, Anand <gadiyar@ti.com> [091207 08:35]:
>> Tony Lindgren wrote: 
>>> * Mike Rapoport <mike@compulab.co.il> [091206 07:30]:
>>>> Tony,
>>>> Any chance this can go to 2.6.33?
>>> Sure, I was just waiting to hear back if the OUTPUT_PULLUP is
>>> needed for sure? Or is just OUTPUT enough for musb to work?
>>>
>>> Tony
>>>
>> OUTPUT should work too. The ULPI spec recommends a weak pull-up
>> on STP line, but we needn't really have that. Plain OUTPUT is sufficient.
> 
> OK, thanks for checking that. Mike, what do you prefer to do?
> 
> I guess in some cases the pull may be needed for a pin
> to change faster if an external pull is not used?
> 
> We could add the OUTPUT_PULL defines, but we should probably
> mark them with comments that they should be rarely needed.

Here's updated cm-t35 mux initialization that should apply to current
linux-omap-2.6/master. Please discard the previous version and sorry for the noise.

> Regards,
> 
> Tony
> 
> 

>From 0da6d5d13351c2fc121a86ab641e25e4ff017800 Mon Sep 17 00:00:00 2001
From: Mike Rapoport <mike@compulab.co.il>
Date: Wed, 9 Dec 2009 15:23:24 +0200
Subject: [PATCH] omap3: cm-t35: add mux initialization

CM-T35 can be assembled with different set of peripherals thus making
certain interfaces available to user as GPIOs or dedicated pins. Because
of it CM-T35 bootloader sets up mux configuration only for pins
necessary to boot the system and the rest of the mux configuration is
done by the kernel. Besides, having mux configuration in the kernel
allows to minimize dependancy on bootloader.

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-omap2/Kconfig        |    1 +
 arch/arm/mach-omap2/board-cm-t35.c |   96 +++++++++++++++++++++++++++++++++---
 2 files changed, 90 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 16c0c13..66de47b 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -136,6 +136,7 @@ config MACH_CM_T35
 	bool "CompuLab CM-T35 module"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
 	select OMAP_PACKAGE_CUS
+	select OMAP_MUX

 config MACH_IGEP0020
 	bool "IGEP0020"
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 507c922..1591aae 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -482,13 +482,98 @@ static void __init cm_t35_map_io(void)
 	omap2_map_common_io();
 }

-#ifdef CONFIG_OMAP_MUX
 static struct omap_board_mux board_mux[] __initdata = {
+	/* nCS and IRQ for CM-T35 ethernet */
+	OMAP3_MUX(GPMC_NCS5, OMAP_MUX_MODE0),
+	OMAP3_MUX(UART3_CTS_RCTX, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLUP),
+
+	/* nCS and IRQ for SB-T35 ethernet */
+	OMAP3_MUX(GPMC_NCS4, OMAP_MUX_MODE0),
+	OMAP3_MUX(GPMC_WAIT3, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLUP),
+
+	/* PENDOWN GPIO */
+	OMAP3_MUX(GPMC_NCS6, OMAP_MUX_MODE4 | OMAP_PIN_INPUT),
+
+	/* mUSB */
+	OMAP3_MUX(HSUSB0_CLK, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(HSUSB0_STP, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(HSUSB0_DIR, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(HSUSB0_NXT, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(HSUSB0_DATA0, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(HSUSB0_DATA1, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(HSUSB0_DATA2, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(HSUSB0_DATA3, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(HSUSB0_DATA4, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(HSUSB0_DATA5, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(HSUSB0_DATA6, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(HSUSB0_DATA7, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+
+	/* MMC 2 */
+	OMAP3_MUX(SDMMC2_DAT4, OMAP_MUX_MODE1 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(SDMMC2_DAT5, OMAP_MUX_MODE1 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(SDMMC2_DAT6, OMAP_MUX_MODE1 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(SDMMC2_DAT7, OMAP_MUX_MODE1 | OMAP_PIN_INPUT),
+
+	/* McSPI 1 */
+	OMAP3_MUX(MCSPI1_CLK, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(MCSPI1_SIMO, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(MCSPI1_SOMI, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(MCSPI1_CS0, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLDOWN),
+
+	/* McSPI 4 */
+	OMAP3_MUX(MCBSP1_CLKR, OMAP_MUX_MODE1 | OMAP_PIN_INPUT),
+	OMAP3_MUX(MCBSP1_DX, OMAP_MUX_MODE1 | OMAP_PIN_INPUT),
+	OMAP3_MUX(MCBSP1_DR, OMAP_MUX_MODE1 | OMAP_PIN_INPUT),
+	OMAP3_MUX(MCBSP1_FSX, OMAP_MUX_MODE1 | OMAP_PIN_INPUT_PULLUP),
+
+	/* McBSP 2 */
+	OMAP3_MUX(MCBSP2_FSX, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(MCBSP2_CLKX, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(MCBSP2_DR, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(MCBSP2_DX, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+
+	/* serial ports */
+	OMAP3_MUX(MCBSP3_CLKX, OMAP_MUX_MODE1 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(MCBSP3_FSX, OMAP_MUX_MODE1 | OMAP_PIN_INPUT),
+	OMAP3_MUX(UART1_TX, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(UART1_RX, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+
+	/* DSS */
+	OMAP3_MUX(DSS_PCLK, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_HSYNC, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_VSYNC, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_ACBIAS, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_DATA0, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_DATA1, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_DATA2, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_DATA3, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_DATA4, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_DATA5, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_DATA6, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_DATA7, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_DATA8, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_DATA9, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_DATA10, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_DATA11, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_DATA12, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_DATA13, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_DATA14, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_DATA15, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_DATA16, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_DATA17, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_DATA18, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_DATA19, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_DATA20, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_DATA21, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_DATA22, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_DATA23, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+
+	/* TPS IRQ */
+	OMAP3_MUX(SYS_NIRQ, OMAP_MUX_MODE0 | OMAP_WAKEUP_EN | \
+		  OMAP_PIN_INPUT_PULLUP),
+
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
-#else
-#define board_mux	NULL
-#endif

 static void __init cm_t35_init(void)
 {
@@ -501,9 +586,6 @@ static void __init cm_t35_init(void)
 	cm_t35_init_led();

 	usb_musb_init();
-
-	omap_mux_init_signal("sys_nirq",
-		OMAP_WAKEUP_EN | OMAP_PIN_INPUT_PULLUP);
 }

 MACHINE_START(CM_T35, "Compulab CM-T35")
-- 
1.6.4.4



-- 
Sincerely yours,
Mike.


