From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] OMAP2: PM: check UART status before trying to idle
Date: Wed,  6 Oct 2010 08:52:18 -0700
Message-ID: <1286380338-4072-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54758 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757083Ab0JFPwY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Oct 2010 11:52:24 -0400
Received: by iwn5 with SMTP id 5so9898786iwn.19
        for <linux-omap@vger.kernel.org>; Wed, 06 Oct 2010 08:52:23 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

As is done on OMAP3, check omap_uart_can_sleep() as one of the
pre-conditions for entering the idle loop.  Without this check,
entering idle introduces large latencies on active UARTs, and is
especially noticable on serial console.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
Tony, this fixes the UART lag when using the serial console on n8x0.
With this, the UARTs will not idle until their sleep timeouts are
activated, and they're disabled by default.

There's an additional bug I'm still looking into as to why UART3
does not trigger wakeup from idle on 2420, but that is only triggered
after enabling UART timeouts.

 arch/arm/mach-omap2/pm24xx.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index c1bceec..a40457d 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -245,6 +245,8 @@ static int omap2_can_sleep(void)
 {
 	if (omap2_fclks_active())
 		return 0;
+	if (!omap_uart_can_sleep())
+		return 0;
 	if (osc_ck->usecount > 1)
 		return 0;
 	if (omap_dma_running())
-- 
1.7.2.1

