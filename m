From: Evgeny Kuznetsov <EXT-Eugeny.Kuznetsov@nokia.com>
Subject: [PATCH 1/1] omap: Ptr "isr_reg" tracked as NULL was dereferenced
Date: Tue,  5 Oct 2010 12:42:10 +0400
Message-ID: <131d16236d19895323fca2f058d65f1f116bacad.1286261378.git.EXT-Eugeny.Kuznetsov@nokia.com>
References: <cover.1286261378.git.EXT-Eugeny.Kuznetsov@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:54702 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757950Ab0JEIqe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 04:46:34 -0400
In-Reply-To: <cover.1286261378.git.EXT-Eugeny.Kuznetsov@nokia.com>
In-Reply-To: <cover.1286261378.git.EXT-Eugeny.Kuznetsov@nokia.com>
References: <cover.1286261378.git.EXT-Eugeny.Kuznetsov@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, khilman@deeprootsystems.com, akpm@linux-foundation.org, zmc@lurian.net, a.j.buxton@gmail.com, ext-eugeny.kuznetsov@nokia.com

From: Evgeny Kuznetsov <ext-eugeny.kuznetsov@nokia.com>

Value of "isr_reg" pointer is depend on configuration and GPIO method.
Potentially it may have NULL value and it is dereferenced later 
in code. If pointer is NULL there is some kernel bug.
Log line and 'BUG' macro are added to halt code execution in this case.

Signed-off-by: Evgeny Kuznetsov <EXT-Eugeny.Kuznetsov@nokia.com>
---
 arch/arm/plat-omap/gpio.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index c05c653..7669928 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -1318,6 +1318,13 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	if (bank->method == METHOD_GPIO_44XX)
 		isr_reg = bank->base + OMAP4_GPIO_IRQSTATUS0;
 #endif
+
+	if (!isr_reg) {
+		printk(KERN_ERR "FATAL: Incorrect GPIO method %i\n",
+				bank->method);
+		BUG();
+		}
+
 	while(1) {
 		u32 isr_saved, level_mask = 0;
 		u32 enabled;
-- 
1.6.3.3

