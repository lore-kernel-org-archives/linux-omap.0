From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 17/25] ARM: pm: mach-s3c64xx: cleanup s3c_cpu_save
Date: Thu, 23 Jun 2011 20:14:47 +0100
Message-ID: <E1QZpMV-0005n5-2Q@rmk-PC.arm.linux.org.uk>
References: <20110623190900.GH9449@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20110623190900.GH9449@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

s3c_cpu_save does not need to save any registers with the new
cpu_suspend calling convention.  Remove these redundant instructions.

Acked-by: Frank Hofmann <frank.hofmann@tomtom.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-s3c64xx/sleep.S |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/sleep.S b/arch/arm/mach-s3c64xx/sleep.S
index dc4f582..2fd3433 100644
--- a/arch/arm/mach-s3c64xx/sleep.S
+++ b/arch/arm/mach-s3c64xx/sleep.S
@@ -35,10 +35,8 @@
 	*/
 
 ENTRY(s3c_cpu_save)
-	stmfd	sp!, { r4 - r12, lr }
 	adr	r3, BSYM(s3c64xx_finish_suspend)
-	bl	cpu_suspend
-	ldmfd	sp!, { r4 - r12, pc }
+	b	cpu_suspend
 
 s3c64xx_finish_suspend:
 	@@ call final suspend code
-- 
1.7.4.4
