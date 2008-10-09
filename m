From: "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>
Subject: [PATCH] twl4030-core: fix a typo
Date: Thu, 9 Oct 2008 20:44:49 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB028C6305D0@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52952 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753570AbYJIPO6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Oct 2008 11:14:58 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>

From: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>

Fix a trivial typo.

Signed-off-by: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
---
Index: linux-omap-git/drivers/mfd/twl4030-core.c
===================================================================
--- linux-omap-git.orig/drivers/mfd/twl4030-core.c	2008-10-09 18:32:15.000000000 +0530
+++ linux-omap-git/drivers/mfd/twl4030-core.c	2008-10-09 20:40:18.007239952 +0530
@@ -57,7 +57,7 @@
 #define DRIVER_NAME			"twl4030"
 
 #if defined(CONFIG_TWL4030_BCI_BATTERY) || \
-	defined(CONFIG_TWL4030_BCI_BATTERY_MODUEL)
+	defined(CONFIG_TWL4030_BCI_BATTERY_MODULE)
 #define twl_has_bci()		true
 #else
 #define twl_has_bci()		false

--
With Regards,
Jagadeesh Bhaskar P
 
----------------------------
Some men see things as they are and say why - I dream things that never were and say why not.
- George Bernard Shaw
-------------------

