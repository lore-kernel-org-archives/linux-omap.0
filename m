From: Kim Kyuwon <chammoru@gmail.com>
Subject: [PATCH 3/3] OMAP3: PM: invoke omap_sram_idle() only when
	sleep_while_idle is enabled
Date: Tue, 17 Mar 2009 16:28:30 +0900
Message-ID: <4d34a0a70903170028t1722d565i35ec12b476427ae6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.232]:20180 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752450AbZCQH2c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Mar 2009 03:28:32 -0400
Received: by rv-out-0506.google.com with SMTP id g37so2008287rvb.1
        for <linux-omap@vger.kernel.org>; Tue, 17 Mar 2009 00:28:30 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: OMAP <linux-omap@vger.kernel.org>
Cc: q1.kim@samsung.com, Kevin Hilman <khilman@deeprootsystems.com>, Jouni Hogander <jouni.hogander@nokia.com>, kyungmin.park@samsung.com

If MPU goes to WFI in the idle thread, execution time becomes a bit
slow and the JTAG Debugger doesn't work. This patch is needed for
urgent works(e.g. booting and launching application) and debugging.

To enable sleep_while_idle mode, use below setting.
echo 1 > /sys/power/sleep_while_idle

Signed-off-by: Kim Kyuwon <q1.kim@samsung.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |    3 +++
 arch/arm/mach-omap2/pm34xx.c      |    5 +++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c
b/arch/arm/mach-omap2/cpuidle34xx.c
index 630108c..1623c2f 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -87,6 +87,9 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
 	local_irq_disable();
 	local_fiq_disable();

+	if (!enable_dyn_sleep)
+		goto return_sleep_time;
+
 	if (!enable_off_mode) {
 		if (mpu_state < PWRDM_POWER_RET)
 			mpu_state = PWRDM_POWER_RET;
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 9102cee..402409c 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -484,8 +484,6 @@ static int omap3_fclks_active(void)

 int omap3_can_sleep(void)
 {
-	if (!enable_dyn_sleep)
-		return 0;
 	if (!omap_uart_can_sleep())
 		return 0;
 	if (omap3_fclks_active())
@@ -545,6 +543,9 @@ static void omap3_pm_idle(void)
 	local_irq_disable();
 	local_fiq_disable();

+	if (!enable_dyn_sleep)
+		goto out;
+
 	if (!omap3_can_sleep())
 		goto out;

-- 
1.5.2.5


-- 
Kyuwon
