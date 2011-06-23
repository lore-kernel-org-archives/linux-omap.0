From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 03/25] ARM: pm: sa1100: no need to re-enable clock switching
Date: Thu, 23 Jun 2011 20:10:03 +0100
Message-ID: <E1QZpHv-0005lo-6u@rmk-PC.arm.linux.org.uk>
References: <20110623190900.GH9449@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20110623190900.GH9449@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This is now taken care of by calling cpu_proc_init() in the resume
path, so eliminate this unnecessary call.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-sa1100/sleep.S |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-sa1100/sleep.S b/arch/arm/mach-sa1100/sleep.S
index 04f2a61..122ab3c 100644
--- a/arch/arm/mach-sa1100/sleep.S
+++ b/arch/arm/mach-sa1100/sleep.S
@@ -147,5 +147,4 @@ sa1110_sdram_controller_fix:
  */
 	.align 5
 sa1100_cpu_resume:
-	mcr	p15, 0, r1, c15, c1, 2		@ enable clock switching
 	ldmfd	sp!, {r4 - r12, pc}		@ return to caller
-- 
1.7.4.4
