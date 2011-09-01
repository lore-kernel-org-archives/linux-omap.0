From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 02/11] ARM: pm: arm920/926: fix number of registers saved
Date: Thu, 01 Sep 2011 13:48:58 +0100
Message-ID: <E1Qz6hW-00078F-VZ@rmk-PC.arm.linux.org.uk>
References: <20110901124752.GE29729@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57091 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757553Ab1IAOCs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Sep 2011 10:02:48 -0400
In-Reply-To: <20110901124752.GE29729@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.orglinux-arm-kernel@lists.infradead.orglinux-omap@vger.kernel.org

ARM920 and ARM926 save four registers, not three.  Fix the size of
the suspend region required.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/proc-arm920.S |    2 +-
 arch/arm/mm/proc-arm926.S |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/proc-arm920.S b/arch/arm/mm/proc-arm920.S
index 92bd102..2e6849b 100644
--- a/arch/arm/mm/proc-arm920.S
+++ b/arch/arm/mm/proc-arm920.S
@@ -379,7 +379,7 @@ ENTRY(cpu_arm920_set_pte_ext)
 
 /* Suspend/resume support: taken from arch/arm/plat-s3c24xx/sleep.S */
 .globl	cpu_arm920_suspend_size
-.equ	cpu_arm920_suspend_size, 4 * 3
+.equ	cpu_arm920_suspend_size, 4 * 4
 #ifdef CONFIG_PM_SLEEP
 ENTRY(cpu_arm920_do_suspend)
 	stmfd	sp!, {r4 - r7, lr}
diff --git a/arch/arm/mm/proc-arm926.S b/arch/arm/mm/proc-arm926.S
index 2bbcf05..cd8f79c 100644
--- a/arch/arm/mm/proc-arm926.S
+++ b/arch/arm/mm/proc-arm926.S
@@ -394,7 +394,7 @@ ENTRY(cpu_arm926_set_pte_ext)
 
 /* Suspend/resume support: taken from arch/arm/plat-s3c24xx/sleep.S */
 .globl	cpu_arm926_suspend_size
-.equ	cpu_arm926_suspend_size, 4 * 3
+.equ	cpu_arm926_suspend_size, 4 * 4
 #ifdef CONFIG_PM_SLEEP
 ENTRY(cpu_arm926_do_suspend)
 	stmfd	sp!, {r4 - r7, lr}
-- 
1.7.4.4

