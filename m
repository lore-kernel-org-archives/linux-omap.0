From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 05/10] ARM: OMAP: Fix gpio.c compile on 15xx with
	CONFIG_DEBUGFS
Date: Mon, 12 Jan 2009 16:43:35 +0200
Message-ID: <20090112144335.24205.46418.stgit@localhost>
References: <20090112143405.24205.52151.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62484 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754883AbZALOnk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jan 2009 09:43:40 -0500
In-Reply-To: <20090112143405.24205.52151.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

There are no wakeup registers on 15xx, and suspend_wakeup
does not exist in the struct gpio_bank.

Without this fix we'll get "arch/arm/plat-omap/gpio.c:1792:
error: 'struct gpio_bank' has no member named 'suspend_wakeup'"
as noted by Russell King.

Note that the ifdefs will be cleaned up once the omap gpio
code gets split into omap1 and omap2 specific parts.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/gpio.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 07b6968..f856a90 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -1789,6 +1789,8 @@ static int dbg_gpio_show(struct seq_file *s, void *unused)
 /* FIXME for at least omap2, show pullup/pulldown state */
 
 			irqstat = irq_desc[irq].status;
+#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP24XX) ||	\
+		defined(CONFIG_ARCH_OMAP34XX)
 			if (is_in && ((bank->suspend_wakeup & mask)
 					|| irqstat & IRQ_TYPE_SENSE_MASK)) {
 				char	*trigger = NULL;
@@ -1818,6 +1820,7 @@ static int dbg_gpio_show(struct seq_file *s, void *unused)
 						(bank->suspend_wakeup & mask)
 							? " wakeup" : "");
 			}
+#endif
 			seq_printf(s, "\n");
 		}
 

