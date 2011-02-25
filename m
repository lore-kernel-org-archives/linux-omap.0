From: Michael Buesch <mb@bu3sch.de>
Subject: [PATCH] cbus-retu: Add status reg bits and ADC channel definitions
Date: Sat, 26 Feb 2011 00:18:36 +0100
Message-ID: <1298675916.27500.4.camel@marge>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 80-190-117-144.ip-home.de ([80.190.117.144]:40427 "EHLO
	bu3sch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754523Ab1BYXSn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Feb 2011 18:18:43 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

This adds definitions for power management related
RETU_REG_STATUS bits and a list of ADC channels.

Signed-off-by: Michael Buesch <mb@bu3sch.de>

---

Index: linux-omap-2.6/drivers/cbus/retu.h
===================================================================
--- linux-omap-2.6.orig/drivers/cbus/retu.h	2011-02-26 00:12:48.269834012 +0100
+++ linux-omap-2.6/drivers/cbus/retu.h	2011-02-26 00:12:49.828847589 +0100
@@ -40,6 +40,8 @@
 #define RETU_REG_CTRL_CLR	0x0f	/* Regulator clear register */
 #define RETU_REG_CTRL_SET	0x10	/* Regulator set register */
 #define RETU_REG_STATUS		0x16	/* Status register */
+#define  RETU_REG_STATUS_BATAVAIL	0x0100 /* Battery available */
+#define  RETU_REG_STATUS_CHGPLUG	0x1000 /* Charger is plugged in */
 #define RETU_REG_WATCHDOG	0x17	/* Watchdog register */
 #define RETU_REG_AUDTXR		0x18	/* Audio Codec Tx register */
 #define RETU_REG_MAX		0x1f
@@ -57,6 +59,23 @@
 
 #define	MAX_RETU_IRQ_HANDLERS	16
 
+/* ADC channels */
+#define RETU_ADC_GND		0x00 /* Ground */
+#define RETU_ADC_BSI		0x01 /* Battery Size Indicator */
+#define RETU_ADC_BATTEMP	0x02 /* Battery temperature */
+#define RETU_ADC_CHGVOLT	0x03 /* Charger voltage */
+#define RETU_ADC_HEADSET	0x04 /* Headset detection */
+#define RETU_ADC_HOOKDET	0x05 /* Hook detection */
+#define RETU_ADC_RFGP		0x06 /* RF GP */
+#define RETU_ADC_WBTX		0x07 /* Wideband Tx detection */
+#define RETU_ADC_BATTVOLT	0x08 /* Battery voltage measurement */
+#define RETU_ADC_GND2		0x09 /* Ground */
+#define RETU_ADC_LIGHTSENS	0x0A /* Light sensor */
+#define RETU_ADC_LIGHTTEMP	0x0B /* Light sensor temperature */
+#define RETU_ADC_BKUPVOLT	0x0C /* Backup battery voltage */
+#define RETU_ADC_TEMP		0x0D /* RETU temperature */
+
+
 int retu_read_reg(struct device *child, unsigned reg);
 void retu_write_reg(struct device *child, unsigned reg, u16 val);
 void retu_set_clear_reg_bits(struct device *child, unsigned reg, u16 set,


