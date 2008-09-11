From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 28/29] PM FIX: convert TI io_p2v() usage to OMAP2_IO_ADDRESS()
Date: Thu, 11 Sep 2008 15:34:12 +0300
Message-ID: <1221136453-16697-28-git-send-email-khilman@deeprootsystems.com>
References: <87iqt2amoi.fsf@deeprootsystems.com>
 <1221136453-16697-1-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-2-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-3-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-4-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-5-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-6-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-7-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-8-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-9-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-10-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-11-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-12-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-13-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-14-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-15-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-16-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-17-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-18-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-19-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-20-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-21-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-22-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-23-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-24-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-25-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-26-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-27-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:19031 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755880AbYIKMfI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 08:35:08 -0400
In-Reply-To: <1221136453-16697-27-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 5242ba0..7436332 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -222,7 +222,7 @@ static void restore_table_entry(void)
 	u32 previous_value, control_reg_value;
 	u32 *address;
 	/* Get virtual address of SCRATCHPAD */
-	scratchpad_address = (u32 *) io_p2v(SCRATCHPAD);
+	scratchpad_address = (u32 *) OMAP2_IO_ADDRESS(SCRATCHPAD);
 	/* Get address of entry that was modified */
 	address = (u32 *) *(scratchpad_address + TABLE_ADDRESS_OFFSET);
 	/* Get the previous value which needs to be restored */
@@ -924,7 +924,7 @@ void clear_scratchpad_contents(void)
 	u32 max_offset = SCRATHPAD_ROM_OFFSET;
 	u32 offset = 0;
 	u32 v;
-	u32 v_addr = io_p2v(SCRATCHPAD_ROM);
+	u32 v_addr = OMAP2_IO_ADDRESS(SCRATCHPAD_ROM);
 	if (__raw_readl(OMAP3430_PRM_RSTST) & 0x1) {
 		for ( ; offset <= max_offset; offset += 0x4)
 			 __raw_writel(0x0, (v_addr + offset));
@@ -942,7 +942,7 @@ void save_scratchpad_contents(void)
 	u32 *sdram_context_address;
 
 	/* Get virtual address of SCRATCHPAD */
-	scratchpad_address = (u32 *) io_p2v(SCRATCHPAD);
+	scratchpad_address = (u32 *) OMAP2_IO_ADDRESS(SCRATCHPAD);
 	/* Get Restore pointer to jump to while waking up from OFF */
 	restore_address = get_restore_pointer();
 	/* Convert it to physical address */
-- 
1.6.0

