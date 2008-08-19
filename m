From: "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>
Subject: [PATCH] TWL4030-RTC: Remove obsolete comment
Date: Tue, 19 Aug 2008 19:50:26 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB020F89F003@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59568 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752675AbYHSOUg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Aug 2008 10:20:36 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id m7JEKR3B007986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 19 Aug 2008 09:20:35 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id m7JEKR8G017268
	for <linux-omap@vger.kernel.org>; Tue, 19 Aug 2008 19:50:27 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>

TWL4030-RTC: Remove obsolete comment.

Signed-off-by: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
Index: my-local-git-dir/drivers/rtc/rtc-twl4030.c
===================================================================
--- my-local-git-dir.orig/drivers/rtc/rtc-twl4030.c	2008-08-19 19:20:24.000000000 +0530
+++ my-local-git-dir/drivers/rtc/rtc-twl4030.c	2008-08-19 19:28:43.037746119 +0530
@@ -446,12 +446,6 @@ static irqreturn_t twl4030_rtc_interrupt
 				   REG_RTC_STATUS_REG);
 	if (res)
 		goto out;
-	/*
-	 * Workaround for strange behaviour with T2. Need to write into ISR
-	 * register one more time to clear the interrupt. Otherwise, the same
-	 * RTC event generates 2 interrupts in a row.
-	 * (no errata document available)
-	 */
 	res = twl4030_i2c_write_u8(TWL4030_MODULE_INT,
 			PWR_RTC_INT_CLR, REG_PWR_ISR1);
 	if (res)

--
With Regards,
Jagadeesh Bhaskar P
 
----------------------------
Some men see things as they are and say why - I dream things that never were and say why not.
- George Bernard Shaw
-------------------

