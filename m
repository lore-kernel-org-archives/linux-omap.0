From: Taras Kondratiuk <taras.kondratiuk@linaro.org>
Subject: [RFC 06/23] drivers: bus: omap_l3: raw read and write endian fix
Date: Sat, 16 Nov 2013 02:01:09 +0200
Message-ID: <1384560086-11994-7-git-send-email-taras.kondratiuk@linaro.org>
References: <1384560086-11994-1-git-send-email-taras.kondratiuk@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f47.google.com ([74.125.83.47]:34502 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753661Ab3KPABj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Nov 2013 19:01:39 -0500
Received: by mail-ee0-f47.google.com with SMTP id c50so835023eek.6
        for <linux-omap@vger.kernel.org>; Fri, 15 Nov 2013 16:01:38 -0800 (PST)
In-Reply-To: <1384560086-11994-1-git-send-email-taras.kondratiuk@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linaro-networking@linaro.org, Victor Kamensky <victor.kamensky@linaro.org>, linux-kernel@vger.kernel.org

From: Victor Kamensky <victor.kamensky@linaro.org>

All OMAP IP blocks expect LE data, but CPU may operate in BE mode.
Need to use endian neutral functions to read/write h/w registers.
I.e instead of __raw_read[lw] and __raw_write[lw] functions code
need to use read[lw]_relaxed and write[lw]_relaxed functions.
If the first simply reads/writes register, the second will byteswap
it if host operates in BE mode.

Changes are trivial sed like replacement of __raw_xxx functions
with xxx_relaxed variant.

Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
Signed-off-by: Taras Kondratiuk <taras.kondratiuk@linaro.org>
---
 drivers/bus/omap_l3_noc.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/omap_l3_noc.c b/drivers/bus/omap_l3_noc.c
index feeecae..82de7a5 100644
--- a/drivers/bus/omap_l3_noc.c
+++ b/drivers/bus/omap_l3_noc.c
@@ -72,7 +72,7 @@ static irqreturn_t l3_interrupt_handler(int irq, void *_l3)
 		 * to determine the source
 		 */
 		base = l3->l3_base[i];
-		err_reg = __raw_readl(base + l3_flagmux[i] +
+		err_reg = readl_relaxed(base + l3_flagmux[i] +
 					+ L3_FLAGMUX_REGERR0 + (inttype << 3));
 
 		/* Get the corresponding error and analyse */
@@ -82,9 +82,9 @@ static irqreturn_t l3_interrupt_handler(int irq, void *_l3)
 
 			/* Read the stderrlog_main_source from clk domain */
 			l3_targ_base = base + *(l3_targ[i] + err_src);
-			std_err_main =  __raw_readl(l3_targ_base +
+			std_err_main =  readl_relaxed(l3_targ_base +
 					L3_TARG_STDERRLOG_MAIN);
-			masterid = __raw_readl(l3_targ_base +
+			masterid = readl_relaxed(l3_targ_base +
 					L3_TARG_STDERRLOG_MSTADDR);
 
 			switch (std_err_main & CUSTOM_ERROR) {
@@ -93,7 +93,7 @@ static irqreturn_t l3_interrupt_handler(int irq, void *_l3)
 					l3_targ_inst_name[i][err_src];
 				WARN(true, "L3 standard error: TARGET:%s at address 0x%x\n",
 					target_name,
-					__raw_readl(l3_targ_base +
+					readl_relaxed(l3_targ_base +
 						L3_TARG_STDERRLOG_SLVOFSLSB));
 				/* clear the std error log*/
 				clear = std_err_main | CLEAR_STDERR_LOG;
-- 
1.7.9.5

