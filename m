From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 29/29] PM: serial: ensure padconf wake-enable bits are set for UARTs
Date: Thu, 11 Sep 2008 15:34:13 +0300
Message-ID: <1221136453-16697-29-git-send-email-khilman@deeprootsystems.com>
References: <87iqt2amoi.fsf@deeprootsystems.com>
 <1221136453-16697-1-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-2-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-3-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-4-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-5-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-6-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-7-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-8-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-9-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-10-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-11-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-12-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-13-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-14-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-15-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-16-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-17-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-18-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-19-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-20-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-21-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-22-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-23-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-24-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-25-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-26-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-27-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-28-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:48520 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754422AbYIKMfA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 08:35:00 -0400
In-Reply-To: <1221136453-16697-28-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

FIXME: there needs to be a platform specific way to set which
       padconf regs are actually used, as the current ones
       are specific to 3430SDP.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/serial.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index c189cc9..96e3165 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -298,6 +298,15 @@ void __init omap_serial_init(void)
 		v = __raw_readl(omap_uart_wk_en[i]);
 		v |= omap_uart_wk_bit[i];
 		__raw_writel(v, omap_uart_wk_en[i]);
+
+		/* Ensure PADCONF wake-enables are set */
+		if (cpu_is_omap34xx() && omap34xx_uart_padconf[i]) {
+			u16 w;
+
+			w = omap_ctrl_readw(omap34xx_uart_padconf[i]);
+			w |= 0x4000;
+			omap_ctrl_writew(w, omap34xx_uart_padconf[i]);
+		}
 	}
 
 	omap_serial_kick();
-- 
1.6.0

