From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: linux-next: manual merge of the omap tree with the arm tree
Date: Mon, 27 Dec 2010 09:41:56 +1100
Message-ID: <20101227094156.5750aa6e.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
Sender: linux-next-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Jean-Christop PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Russell King <rmk@arm.linux.org.uk>, Ben Gamari <bgamari.foss@gmail.com>
List-Id: linux-omap@vger.kernel.org

Hi all,

Today's linux-next merge of the omap tree got a conflict in
arch/arm/plat-omap/Kconfig between commit
6d803ba736abb5e122dede70a4720e4843dd6df4 ("ARM: 6483/1: arm & sh:
factorised duplicated clkdev.c") from the arm tree and commit
dc69d1af9e8d9cbbabff88bb35a6782187a22229 ("omap2: Make OMAP2PLUS select
OMAP_DM_TIMER") from the omap tree.

Just context changes.  I fixed it up (see below) and can carry the fix as
necessary.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --cc arch/arm/plat-omap/Kconfig
index c940843,bc0c7aa..0000000
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@@ -17,7 -17,8 +17,8 @@@ config ARCH_OMAP
  
  config ARCH_OMAP2PLUS
  	bool "TI OMAP2/3/4"
 -	select COMMON_CLKDEV
 +	select CLKDEV_LOOKUP
+ 	select OMAP_DM_TIMER
  	help
  	  "Systems based on OMAP2, OMAP3 or OMAP4"
  
