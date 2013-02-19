From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 2/2] arm: omap2: voltage: remove unnecessary header
Date: Tue, 19 Feb 2013 12:24:24 +0200
Message-ID: <1361269464-20263-2-git-send-email-balbi@ti.com>
References: <1361269464-20263-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33601 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932246Ab3BSKYp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Feb 2013 05:24:45 -0500
In-Reply-To: <1361269464-20263-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

nothing from <linux/debugfs.h> is used on
voltage.c.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/voltage.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 3ac8fe1..595bf1a 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -23,7 +23,6 @@
 #include <linux/io.h>
 #include <linux/err.h>
 #include <linux/export.h>
-#include <linux/debugfs.h>
 #include <linux/slab.h>
 #include <linux/clk.h>
 
-- 
1.8.1.rc1.5.g7e0651a

