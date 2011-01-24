From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 5/5] ARM: smp: Skip secondary cpu calibration to speed-up boot
Date: Mon, 24 Jan 2011 14:21:20 +0530
Message-ID: <1295859080-15259-7-git-send-email-santosh.shilimkar@ti.com>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35281 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751307Ab1AXIvn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Jan 2011 03:51:43 -0500
In-Reply-To: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, ccross@android.com, catalin.marinas@arm.com, linux@arm.linux.org.uk, linus.ml.walleij@gmail.com

 	if (!skip_secondary_calibrate) {
 		for_each_online_cpu(cpu)
-			bogosum += per_cpu(cpu_data, cpu).loops_per_jiffy;
+			bogosums += per_cpu(cpu_data, cpu).loops_per_jiffy;
 
-		snprintf(bogosum, sizeof(bogosum), " (%lu.%02lu BogoMIPS).\n",
-			bogosum / (500000/HZ), (bogosum / (5000/HZ)) % 100);
+		snprintf(bogosum, sizeof(bogosums), " (%lu.%02lu BogoMIPS).\n",
+			bogosums / (500000/HZ), (bogosums / (5000/HZ)) % 100);
 	} else
 		bogosum[0] = '\0';
 
