From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [RFC 20/21] ARM: OMAP: Complete Innovator FPGA gpiolib conversion
Date: Wed, 29 Oct 2008 13:36:28 +0200
Message-ID: <1225280189-6559-21-git-send-email-jarkko.nikula@nokia.com>
References: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:53276 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753456AbYJ2Lhu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Oct 2008 07:37:50 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9TBbA4l031633
	for <linux-omap@vger.kernel.org>; Wed, 29 Oct 2008 06:37:48 -0500
In-Reply-To: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 arch/arm/mach-omap1/fpga.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/fpga.c b/arch/arm/mach-omap1/fpga.c
index 55748ec..4f2b8a7 100644
--- a/arch/arm/mach-omap1/fpga.c
+++ b/arch/arm/mach-omap1/fpga.c
@@ -177,7 +177,7 @@ void omap1510_fpga_init_irq(void)
 	 * NOTE: For general GPIO/MPUIO access and interrupts, please see
 	 * gpio.[ch]
 	 */
-	omap_request_gpio(13);
+	gpio_request(13, "FPGA irq");
 	gpio_direction_input(13);
 	set_irq_type(gpio_to_irq(13), IRQ_TYPE_EDGE_RISING);
 	set_irq_chained_handler(OMAP1510_INT_FPGA, innovator_fpga_IRQ_demux);
-- 
1.5.6.5

