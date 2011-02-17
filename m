From: Dave Martin <dave.martin@linaro.org>
Subject: [PATCH v5 2/5] ARM: omap4: Convert END() to ENDPROC() for correct linkage with CONFIG_THUMB2_KERNEL
Date: Thu, 17 Feb 2011 12:42:35 +0000
Message-ID: <1297946558-13436-3-git-send-email-dave.martin@linaro.org>
References: <1297946558-13436-1-git-send-email-dave.martin@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63374 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753532Ab1BQMpM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Feb 2011 07:45:12 -0500
Received: by wwa36 with SMTP id 36so2510764wwa.1
        for <linux-omap@vger.kernel.org>; Thu, 17 Feb 2011 04:45:11 -0800 (PST)
In-Reply-To: <1297946558-13436-1-git-send-email-dave.martin@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Dave Martin <dave.martin@linaro.org>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Jean Pihet <j-pihet@ti.com>, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, Nicolas Pitre <nicolas.pitre@linaro.org>, linaro-dev@lists.linaro.org, patches@linaro.org

Code marked with ENTRY() also needs a matching ENDPROC() directive,
in order to ensure that the type and instruction set of the
symbol are correctly annotated.

ENDPROC() tags the affected symbol as a function symbol, which will
ensure that link-time fixups don't accidentally switch to the
wrong instruction set.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap-headsmp.S |    2 +-
 arch/arm/mach-omap2/omap44xx-smc.S |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-headsmp.S b/arch/arm/mach-omap2/omap-headsmp.S
index 6ae937a..4ee6aec 100644
--- a/arch/arm/mach-omap2/omap-headsmp.S
+++ b/arch/arm/mach-omap2/omap-headsmp.S
@@ -45,5 +45,5 @@ hold:	ldr	r12,=0x103
 	 * should now contain the SVC stack for this core
 	 */
 	b	secondary_startup
-END(omap_secondary_startup)
+ENDPROC(omap_secondary_startup)
 
diff --git a/arch/arm/mach-omap2/omap44xx-smc.S b/arch/arm/mach-omap2/omap44xx-smc.S
index 1980dc3..e69d37d 100644
--- a/arch/arm/mach-omap2/omap44xx-smc.S
+++ b/arch/arm/mach-omap2/omap44xx-smc.S
@@ -29,7 +29,7 @@ ENTRY(omap_smc1)
 	dsb
 	smc	#0
 	ldmfd   sp!, {r2-r12, pc}
-END(omap_smc1)
+ENDPROC(omap_smc1)
 
 ENTRY(omap_modify_auxcoreboot0)
 	stmfd   sp!, {r1-r12, lr}
@@ -37,7 +37,7 @@ ENTRY(omap_modify_auxcoreboot0)
 	dsb
 	smc	#0
 	ldmfd   sp!, {r1-r12, pc}
-END(omap_modify_auxcoreboot0)
+ENDPROC(omap_modify_auxcoreboot0)
 
 ENTRY(omap_auxcoreboot_addr)
 	stmfd   sp!, {r2-r12, lr}
@@ -45,7 +45,7 @@ ENTRY(omap_auxcoreboot_addr)
 	dsb
 	smc	#0
 	ldmfd   sp!, {r2-r12, pc}
-END(omap_auxcoreboot_addr)
+ENDPROC(omap_auxcoreboot_addr)
 
 ENTRY(omap_read_auxcoreboot0)
 	stmfd   sp!, {r2-r12, lr}
@@ -54,4 +54,4 @@ ENTRY(omap_read_auxcoreboot0)
 	smc	#0
 	mov	r0, r0, lsr #9
 	ldmfd   sp!, {r2-r12, pc}
-END(omap_read_auxcoreboot0)
+ENDPROC(omap_read_auxcoreboot0)
-- 
1.7.1

