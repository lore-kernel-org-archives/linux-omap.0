From: felipe.balbi@nokia.com
Subject: [RFC PATCH 15/37] cbus: retu: fix compile breakage on retu-headset
Date: Wed,  7 Apr 2010 19:04:06 +0300
Message-ID: <1270656268-7034-16-git-send-email-felipe.balbi@nokia.com>
References: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:58631 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932700Ab0DGQGT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 12:06:19 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o37G5wgR005211
	for <linux-omap@vger.kernel.org>; Wed, 7 Apr 2010 19:06:17 +0300
In-Reply-To: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

when building retu-headset as a  module, we need to
export retu_set_clear_reg_bits() and retu_read_adc().

While at that, also move the EXPORT_SYMBOL() macros
closer to the function definitions.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/cbus/retu.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
index 80a2acc..7f7a31b 100644
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -83,6 +83,7 @@ int retu_read_reg(unsigned reg)
 	BUG_ON(!retu_initialized);
 	return cbus_read_reg(RETU_ID, reg);
 }
+EXPORT_SYMBOL(retu_read_reg);
 
 /**
  * retu_write_reg - Write a value to a register in Retu
@@ -96,6 +97,7 @@ void retu_write_reg(unsigned reg, u16 val)
 	BUG_ON(!retu_initialized);
 	cbus_write_reg(RETU_ID, reg, val);
 }
+EXPORT_SYMBOL(retu_write_reg);
 
 void retu_set_clear_reg_bits(unsigned reg, u16 set, u16 clear)
 {
@@ -109,6 +111,7 @@ void retu_set_clear_reg_bits(unsigned reg, u16 set, u16 clear)
 	retu_write_reg(reg, w);
 	spin_unlock_irqrestore(&retu_lock, flags);
 }
+EXPORT_SYMBOL_GPL(retu_set_clear_reg_bits);
 
 #define ADC_MAX_CHAN_NUMBER	13
 
@@ -141,7 +144,7 @@ int retu_read_adc(int channel)
 
 	return res;
 }
-
+EXPORT_SYMBOL(retu_read_adc);
 
 static u16 retu_disable_bogus_irqs(u16 mask)
 {
@@ -174,6 +177,7 @@ void retu_disable_irq(int id)
 	retu_write_reg(RETU_REG_IMR, mask);
 	spin_unlock_irqrestore(&retu_lock, flags);
 }
+EXPORT_SYMBOL(retu_disable_irq);
 
 /*
  * Enable given RETU interrupt
@@ -194,6 +198,7 @@ void retu_enable_irq(int id)
 	retu_write_reg(RETU_REG_IMR, mask);
 	spin_unlock_irqrestore(&retu_lock, flags);
 }
+EXPORT_SYMBOL(retu_enable_irq);
 
 /*
  * Acknowledge given RETU interrupt
@@ -202,6 +207,7 @@ void retu_ack_irq(int id)
 {
 	retu_write_reg(RETU_REG_IDR, 1 << id);
 }
+EXPORT_SYMBOL(retu_ack_irq);
 
 /*
  * RETU interrupt handler. Only schedules the tasklet.
@@ -283,6 +289,7 @@ int retu_request_irq(int id, void *irq_handler, unsigned long arg, char *name)
 
 	return 0;
 }
+EXPORT_SYMBOL(retu_request_irq);
 
 /*
  * Unregister the handler for a given RETU interrupt source.
@@ -305,6 +312,7 @@ void retu_free_irq(int id)
 	retu_disable_irq(id);
 	hnd->func = NULL;
 }
+EXPORT_SYMBOL(retu_free_irq);
 
 /**
  * retu_power_off - Shut down power to system
@@ -465,14 +473,6 @@ static void __exit retu_exit(void)
 	wait_for_completion(&device_release);
 }
 
-EXPORT_SYMBOL(retu_request_irq);
-EXPORT_SYMBOL(retu_free_irq);
-EXPORT_SYMBOL(retu_enable_irq);
-EXPORT_SYMBOL(retu_disable_irq);
-EXPORT_SYMBOL(retu_ack_irq);
-EXPORT_SYMBOL(retu_read_reg);
-EXPORT_SYMBOL(retu_write_reg);
-
 subsys_initcall(retu_init);
 module_exit(retu_exit);
 
-- 
1.7.0.rc0.33.g7c3932

