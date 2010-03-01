From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: linux-next: manual merge of the omap tree with the  tree
Date: Mon, 1 Mar 2010 11:20:41 +1100
Message-ID: <20100301112041.0c92179b.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Hi all,

Today's linux-next merge of the omap tree got a conflict in
arch/arm/plat-omap/Kconfig between commit
d6d502fa4be1acd01971476fc732c95a4da16d90 ("ARM: 5952/1: ARM: MM: Add
ARM_L1_CACHE_SHIFT_6 for handle inside each ARCH Kconfig") from the arm
tree and commits 56213ca4e440c0b6e56a48f5901c55c4ce3cf1ba ("omap2/3:
Multiboot compile fixes to compile in omap2 and omap3") and
a8eb7ca0cbb41c9cd379b8d2a2a5efb503aa65e9 ("omap3: Replace ARCH_OMAP34XX
with ARCH_OMAP3") from the omap tree.

I fixed it up (see below) and can carry the fix as necessary.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --cc arch/arm/plat-omap/Kconfig
index 2e3eec6,be9484a..0000000
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@@ -19,10 -28,9 +28,10 @@@ config ARCH_OMAP
  
  config ARCH_OMAP3
  	bool "TI OMAP3"
+ 	depends on ARCH_OMAP2PLUS
  	select CPU_V7
- 	select COMMON_CLKDEV
 +	select ARM_L1_CACHE_SHIFT_6
+ 	select USB_ARCH_HAS_EHCI
  
  config ARCH_OMAP4
  	bool "TI OMAP4"
