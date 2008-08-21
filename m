From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: [PATCH] Fix TWL4030 BCI compilation break
Date: Thu, 21 Aug 2008 21:19:53 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870229E813AB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55088 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752331AbYHUPuG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Aug 2008 11:50:06 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m7LFnv2d014753
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 21 Aug 2008 10:50:05 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>

From: Vikram Pandita <vikram.pandita@ti.com>

Fix following compilation error when enabling CONFIG_TWL4030_BCI_BATTERY

drivers/power/twl4030_bci_battery.c: In function 'twl4030_bci_battery_probe':
drivers/power/twl4030_bci_battery.c:911: error: dereferencing pointer to incomplete type

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
---
 drivers/power/twl4030_bci_battery.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: base-tony/drivers/power/twl4030_bci_battery.c
===================================================================
--- base-tony.orig/drivers/power/twl4030_bci_battery.c	2008-08-21 15:06:47.000000000 +0530
+++ base-tony/drivers/power/twl4030_bci_battery.c	2008-08-21 20:37:18.000000000 +0530
@@ -23,7 +23,7 @@
 #include <linux/platform_device.h>
 #include <linux/i2c/twl4030.h>
 #include <linux/power_supply.h>
-#include <asm/arch/bci.h>
+#include <mach/bci.h>
 #include <linux/i2c/twl4030-madc.h>
 
 #define T2_BATTERY_VOLT		0x04
