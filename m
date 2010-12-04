From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/5] omap: Ptr "isr_reg" tracked as NULL was dereferenced
Date: Sat, 04 Dec 2010 13:29:47 -0800
Message-ID: <20101204212947.25978.52302.stgit@baageli.muru.com>
References: <20101204212904.25978.22090.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:28857 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755811Ab0LDV3v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Dec 2010 16:29:51 -0500
In-Reply-To: <20101204212904.25978.22090.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Evgeny Kuznetsov <EXT-Eugeny.Kuznetsov@nokia.com>, linux-omap@vger.kernel.org

From: Evgeny Kuznetsov <ext-eugeny.kuznetsov@nokia.com>

Value of "isr_reg" pointer is depend on configuration and GPIO method.
Potentially it may have NULL value and it is dereferenced later
in code. Warning and exit from function are added in this case.

Signed-off-by: Evgeny Kuznetsov <EXT-Eugeny.Kuznetsov@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/gpio.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 28d28e4..28106b4 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -1171,6 +1171,10 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	if (bank->method == METHOD_GPIO_44XX)
 		isr_reg = bank->base + OMAP4_GPIO_IRQSTATUS0;
 #endif
+
+	if (WARN_ON(!isr_reg))
+		goto exit;
+
 	while(1) {
 		u32 isr_saved, level_mask = 0;
 		u32 enabled;
@@ -1230,6 +1234,7 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	configured, we must unmask the bank interrupt only after
 	handler(s) are executed in order to avoid spurious bank
 	interrupt */
+exit:
 	if (!unmasked)
 		desc->chip->unmask(irq);
 

