From: Michael Buesch <mb@bu3sch.de>
Subject: [PATCH] cbus-tahvo: Add battery related register defines
Date: Sat, 26 Feb 2011 00:23:24 +0100
Message-ID: <1298676204.27500.9.camel@marge>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 80-190-117-144.ip-home.de ([80.190.117.144]:43615 "EHLO
	bu3sch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932815Ab1BYXX0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Feb 2011 18:23:26 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

This adds battery related register defines to the tahvo driver.

Signed-off-by: Michael Buesch <mb@bu3sch.de>

---

The knowledge originates from various reverse engineering efforts.
So naming might differ from the original unreleased documentation.

Index: linux-omap-2.6/drivers/cbus/tahvo.h
===================================================================
--- linux-omap-2.6.orig/drivers/cbus/tahvo.h	2011-02-26 00:12:47.660828705 +0100
+++ linux-omap-2.6/drivers/cbus/tahvo.h	2011-02-26 00:12:52.757873087 +0100
@@ -30,12 +30,23 @@
 #define TAHVO_REG_IDR		0x01	/* Interrupt ID */
 #define TAHVO_REG_IDSR		0x02	/* Interrupt status */
 #define TAHVO_REG_IMR		0x03	/* Interrupt mask */
+#define TAHVO_REG_CHGCURR	0x04	/* Charge current control PWM (8-bit) */
 #define TAHVO_REG_LEDPWMR	0x05	/* LED PWM */
 #define TAHVO_REG_USBR		0x06	/* USB control */
+#define TAHVO_REG_CHGCTL	0x08	/* Charge control register */
+#define  TAHVO_REG_CHGCTL_EN		0x0001	/* Global charge enable */
+#define  TAHVO_REG_CHGCTL_PWMOVR	0x0004	/* PWM override. Force charge PWM to 0%/100% duty cycle. */
+#define  TAHVO_REG_CHGCTL_PWMOVRZERO	0x0008	/* If set, PWM override is 0% (If unset -> 100%) */
+#define  TAHVO_REG_CHGCTL_CURMEAS	0x0040	/* Enable battery current measurement. */
+#define  TAHVO_REG_CHGCTL_CURTIMRST	0x0080	/* Current measure timer reset. */
+#define TAHVO_REG_BATCURRTIMER	0x0c	/* Battery current measure timer (8-bit) */
+#define TAHVO_REG_BATCURR	0x0d	/* Battery (dis)charge current (signed 16-bit) */
+
 #define TAHVO_REG_MAX		0x0d
 
 /* Interrupt sources */
 #define TAHVO_INT_VBUSON	0
+#define TAHVO_INT_BATCURR	7 /* Battery current measure timer */
 
 #define MAX_TAHVO_IRQ_HANDLERS	8
 


