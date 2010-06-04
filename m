From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [pm-wip/uart][PATCH 2/4] OMAP3: serial: Fix uart4 handling for
 3630
Date: Fri, 4 Jun 2010 19:33:18 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03232DA919@dbde02.ent.ti.com>
References: <53199.192.168.10.88.1275659023.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39066 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755696Ab0FDOD0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Jun 2010 10:03:26 -0400
In-Reply-To: <53199.192.168.10.88.1275659023.squirrel@dbdmail.itg.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Raja, Govindraj" <govindraj.raja@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Aguirre, Sergio" <saaguirre@ti.com>



>>-----Original Message-----
>>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
>>Govindraj.R
>>Sent: Friday, June 04, 2010 7:14 PM
>>To: linux-omap@vger.kernel.org
>>Cc: Kevin Hilman; Aguirre, Sergio
>>Subject: [pm-wip/uart][PATCH 2/4] OMAP3: serial: Fix uart4 handling for 3630
>>
>>This patch makes the following:
>> - Adds missing wakeup padding register handling.
>> - Fixes a hardcode to use PER module ONLY on UART3.
>> - Muxmode usage needed for uart4 for 3630 for padconf
>>   wakeup on rx line.
>>
>>Cc: Kevin Hilman <khilman@deeprootsystems.com>
>>Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
>>Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>>---
>> arch/arm/mach-omap2/serial.c |   30 +++++++++++++++++++++++++++++-
>> 1 files changed, 29 insertions(+), 1 deletions(-)
>>
>>diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
>>index da9fee6..70a9089 100644
>>--- a/arch/arm/mach-omap2/serial.c
>>+++ b/arch/arm/mach-omap2/serial.c
>>@@ -42,6 +42,7 @@
>> #include "prm.h"
>> #include "pm.h"
>> #include "cm.h"
>>+#include "mux.h"
>> #include "prm-regbits-34xx.h"
>>
>> #define UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV	0x52
>>@@ -68,6 +69,7 @@ struct omap_uart_state {
>> 	u32 wk_mask;
>> 	u32 padconf;
>> 	u32 dma_enabled;
>>+	u16 muxmode;
>>
>> 	struct clk *ick;
>> 	struct clk *fck;
>>@@ -229,8 +231,20 @@ static inline void omap_uart_disable_clocks(struct omap_uart_state *uart)
>> 	omap_device_idle(uart->pdev);
>> }
>>
>>+static inline void omap_uart_setmux_mode(struct omap_uart_state *uart)
>>+{
>>+	u16 w = omap_ctrl_readw(uart->padconf);
>>+	w &= ~0x7;
>>+	w |= OMAP_MUX_MODE2;

Why it is hard coded to MUX_MODE2? Should it not be w |= uart->muxmode?

Regards
Thara

>>+	omap_ctrl_writew(w, uart->padconf);
>>+}
>>+
>> static void omap_uart_enable_wakeup(struct omap_uart_state *uart)
>> {
>>+	/* Set appropriate muxmode */
>>+	if (uart->muxmode && uart->padconf)
>>+		omap_uart_setmux_mode(uart);
>>+
>> 	/* Set wake-enable bit */
>> 	if (uart->wk_en && uart->wk_mask) {
>> 		u32 v = __raw_readl(uart->wk_en);
>>@@ -248,6 +262,10 @@ static void omap_uart_enable_wakeup(struct omap_uart_state *uart)
>>
>> static void omap_uart_disable_wakeup(struct omap_uart_state *uart)
>> {
>>+	/* Set appropriate muxmode */
>>+	if (uart->muxmode && uart->padconf)
>>+		omap_uart_setmux_mode(uart);
>>+
>> 	/* Clear wake-enable bit */
>> 	if (uart->wk_en && uart->wk_mask) {
>> 		u32 v = __raw_readl(uart->wk_en);
>>@@ -338,6 +356,9 @@ void omap_uart_resume_idle(int num)
>> 		if (num == uart->num) {
>> 			omap_uart_enable_clocks(uart);
>>
>>+			if (uart->muxmode && uart->padconf)
>>+				omap_uart_setmux_mode(uart);
>>+
>> 			/* Check for IO pad wakeup */
>> 			if (cpu_is_omap34xx() && uart->padconf) {
>> 				u16 p = omap_ctrl_readw(uart->padconf);
>>@@ -416,9 +437,10 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
>> 	omap_uart_smart_idle_enable(uart, 0);
>>
>> 	if (cpu_is_omap34xx()) {
>>-		u32 mod = (uart->num == 2) ? OMAP3430_PER_MOD : CORE_MOD;
>>+		u32 mod = (uart->num > 1) ? OMAP3430_PER_MOD : CORE_MOD;
>> 		u32 wk_mask = 0;
>> 		u32 padconf = 0;
>>+		u16 muxmode = 0;
>>
>> 		uart->wk_en = OMAP34XX_PRM_REGADDR(mod, PM_WKEN1);
>> 		uart->wk_st = OMAP34XX_PRM_REGADDR(mod, PM_WKST1);
>>@@ -435,9 +457,15 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
>> 			wk_mask = OMAP3430_ST_UART3_MASK;
>> 			padconf = 0x19e;
>> 			break;
>>+		case 3:
>>+			wk_mask = OMAP3630_ST_UART4_MASK;
>>+			padconf = 0x0d2;
>>+			muxmode = OMAP_MUX_MODE2;
>>+			break;
>> 		}
>> 		uart->wk_mask = wk_mask;
>> 		uart->padconf = padconf;
>>+		uart->muxmode = muxmode;
>> 	} else if (cpu_is_omap24xx()) {
>> 		u32 wk_mask = 0;
>>
>>--
>>1.6.3.3
>>
>>
>>
>>
>>--
>>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
