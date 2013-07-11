From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 1/2] Revert "ARM: OMAP2+: Fix serial init for device tree based booting"
Date: Thu, 11 Jul 2013 16:23:04 +0530
Message-ID: <1373539986-27272-2-git-send-email-rnayak@ti.com>
References: <1373539986-27272-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36140 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755807Ab3GKKxv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Jul 2013 06:53:51 -0400
In-Reply-To: <1373539986-27272-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: khilman@linaro.org, linux-omap@vger.kernel.org, vaibhav.bedia@ti.com, linux-arm-kernel@lists.infradead.org, mpfj-list@newflow.co.uk, sourav.poddar@ti.com, paul@pwsan.com, balbi@ti.com, Rajendra Nayak <rnayak@ti.com>

This reverts commit 82702ea11ddfe0e43382e1fa5b66d807d8114916.

The above commit stubbed out omap_serial_early_init() in case of
DT build thinking it was doing the serial port initializations.

omap_serial_early_init() however does not do the serial port
inits (its instead done by omap_serial_init_port()) instead
it sets the HWMOD_INIT_NO_IDLE and HWMOD_INIT_NO_RESET flags
for the console uart which causes hwmod to avoid doing a reset
followed by the idling of the console uart.

This is still needed even in the DT case.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Reported-by: Mark Jackson <mpfj-list@newflow.co.uk>
Reported-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
---
 arch/arm/mach-omap2/serial.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 3a674de..58d5b56 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -175,9 +175,6 @@ static char *cmdline_find_option(char *str)
 
 static int __init omap_serial_early_init(void)
 {
-	if (of_have_populated_dt())
-		return -ENODEV;
-
 	do {
 		char oh_name[MAX_UART_HWMOD_NAME_LEN];
 		struct omap_hwmod *oh;
-- 
1.7.9.5

