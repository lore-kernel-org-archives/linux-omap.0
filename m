From: Paul Bolle <pebolle@tiscali.nl>
Subject: [PATCH] ARM: OMAP: drop "select MACH_NOKIA_RM696"
Date: Fri, 08 Mar 2013 11:29:56 +0100
Message-ID: <1362738596.5994.48.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

When support was added for Nokia N9 (RM-696), with commit
63fc5f3bb3d0ca9ab4767a801b518aa6335f87ad ("ARM: OMAP: add minimal
support for Nokia RM-696"), a select statement for MACH_NOKIA_RM696 was
added to the tree. But there's no Kconfig symbol with that name. That
symbol would be superfluous, since support for that machine piggybacks
on MACH_NOKIA_RM680. So drop that select.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
0) Tested with "git grep".

1) Some searching on the web didn't return a "config MACH_NOKIA_RM696".
So apparently there's not even a development tree that uses this symbol.

 arch/arm/mach-omap2/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 49ac3df..5cafa77 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -296,7 +296,6 @@ config MACH_NOKIA_RM680
 	bool "Nokia N950 (RM-680) / N9 (RM-696) phones"
 	depends on ARCH_OMAP3
 	default y
-	select MACH_NOKIA_RM696
 	select OMAP_PACKAGE_CBB
 
 config MACH_NOKIA_RX51
-- 
1.7.11.7
