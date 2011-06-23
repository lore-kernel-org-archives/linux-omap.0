From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH] ARM: pm: add v7 suspend/resume functions to v7_processor functions
Date: Thu, 23 Jun 2011 14:46:11 -0700
Message-ID: <1308865571-16074-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:41369 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933154Ab1FWVqK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Jun 2011 17:46:10 -0400
Received: by mail-pv0-f181.google.com with SMTP id 13so1598656pvg.12
        for <linux-omap@vger.kernel.org>; Thu, 23 Jun 2011 14:46:09 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Commit f6b0fa02e8b0708d17d631afce456524eadf87ff (ARM: pm: add generic
CPU suspend/resume support) added v7 functions for suspend and resume
but did not added them to v7_processor_functions which are used in the
MULTI_CPU case.

Add them in order to have working suspend/resume when using MULTI_CPU.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mm/proc-v7.S |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 3c38678..e27c011 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -418,9 +418,9 @@ ENTRY(v7_processor_functions)
 	.word	cpu_v7_dcache_clean_area
 	.word	cpu_v7_switch_mm
 	.word	cpu_v7_set_pte_ext
-	.word	0
-	.word	0
-	.word	0
+	.word	cpu_v7_suspend_size
+	.word	cpu_v7_do_suspend
+	.word	cpu_v7_do_resume
 	.size	v7_processor_functions, . - v7_processor_functions
 
 	.section ".rodata"
-- 
1.7.4

