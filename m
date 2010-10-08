From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH] Revert "OMAP: mach-omap2: Fix incorrect assignment warnings"
Date: Fri, 8 Oct 2010 18:49:13 +0200
Message-ID: <AANLkTimCXyTh30iGVd2j8JUcfT2a0+xrT8AqjX=qQ0k+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:35841 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754938Ab0JHQtP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Oct 2010 12:49:15 -0400
Received: by qyk10 with SMTP id 10so1518441qyk.19
        for <linux-omap@vger.kernel.org>; Fri, 08 Oct 2010 09:49:14 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>

Hi,

This patch reverts commit 914bab936fe0388a529079679e2f137aa4ff548d, which
breaks the OFF mode on the OMAP3 platforms.
The details are here below.

The intent behind the original patch was to fix some compiler
warnings, which I do not have on my side. Is the problem dependent on
the setup and config used?

Jean

---
>From ec85bc90978cf0f257e73eaad593ffb774595863 Mon Sep 17 00:00:00 2001
From: Jean Pihet <jean.pihet@newoldbits.com>
Date: Fri, 8 Oct 2010 18:36:48 +0200
Subject: [PATCH] Revert "OMAP: mach-omap2: Fix incorrect assignment warnings"

This reverts commit 914bab936fe0388a529079679e2f137aa4ff548d, which
breaks the OFF mode on the OMAP3 platforms.

The use of a void* pointer for scratchpad_address confuses the
compiler which generates wrong offset for the access to the L4
address space. In that case an alignement fault is generated
during the wake-up from OFF mode.

The code that causes problem is:
__raw_readl(scratchpad_address + OMAP343X_TABLE_ADDRESS_OFFSET);

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/control.c |    4 ++--
 arch/arm/mach-omap2/pm34xx.c  |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 1fa3294..049bfb1 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -217,7 +217,7 @@ void omap4_ctrl_pad_writel(u32 val, u16 offset)
 void omap3_clear_scratchpad_contents(void)
 {
 	u32 max_offset = OMAP343X_SCRATCHPAD_ROM_OFFSET;
-	void __iomem *v_addr;
+	u32 *v_addr;
 	u32 offset = 0;
 	v_addr = OMAP2_L4_IO_ADDRESS(OMAP343X_SCRATCHPAD_ROM);
 	if (prm_read_mod_reg(OMAP3430_GR_MOD, OMAP3_PRM_RSTST_OFFSET) &
@@ -233,7 +233,7 @@ void omap3_clear_scratchpad_contents(void)
 /* Populate the scratchpad structure with restore structure */
 void omap3_save_scratchpad_contents(void)
 {
-	void  __iomem *scratchpad_address;
+	void * __iomem scratchpad_address;
 	u32 arm_context_addr;
 	struct omap3_scratchpad scratchpad_contents;
 	struct omap3_scratchpad_prcm_block prcm_block_contents;
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 8c8f1ac..af752ae 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -310,7 +310,7 @@ static void restore_control_register(u32 val)
 /* Function to restore the table entry that was modified for enabling MMU */
 static void restore_table_entry(void)
 {
-	void __iomem *scratchpad_address;
+	u32 *scratchpad_address;
 	u32 previous_value, control_reg_value;
 	u32 *address;

-- 
1.7.1
