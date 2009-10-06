From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] OMAP: Fix Unlikely(x) < y
Date: Tue, 06 Oct 2009 15:21:40 +0200
Message-ID: <4ACB4464.9080803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f217.google.com ([209.85.219.217]:50027 "EHLO
	mail-ew0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932265AbZJFNNd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Oct 2009 09:13:33 -0400
Received: by ewy17 with SMTP id 17so3873178ewy.39
        for <linux-omap@vger.kernel.org>; Tue, 06 Oct 2009 06:12:55 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

The closing parenthesis was not on the right location.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 71ebd7f..7c345b7 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -373,7 +373,7 @@ static inline int gpio_valid(int gpio)
 
 static int check_gpio(int gpio)
 {
-	if (unlikely(gpio_valid(gpio)) < 0) {
+	if (unlikely(gpio_valid(gpio) < 0)) {
 		printk(KERN_ERR "omap-gpio: invalid GPIO %d\n", gpio);
 		dump_stack();
 		return -1;
