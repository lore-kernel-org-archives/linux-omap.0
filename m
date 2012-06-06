From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/3] ARM: OMAP2+: Fix compile for CONFIG_TIDSPBRIDGE
 platform init code
Date: Wed, 06 Jun 2012 01:22:50 -0700
Message-ID: <20120606082250.727.88234.stgit@muffinssi.local>
References: <20120606082156.727.42730.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63764 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752936Ab2FFIWw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jun 2012 04:22:52 -0400
In-Reply-To: <20120606082156.727.42730.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, linux-omap@vger.kernel.org

Commit 7f28427b (ARM: OMAP2+: Move omap_dsp_reserve_sdram_memblock() to mach-omap2)
moved DSP platform init code, but failed to include memblock.h causing:

arch/arm/mach-omap2/dsp.c: In function 'omap_dsp_reserve_sdram_memblock':
arch/arm/mach-omap2/dsp.c:58: error: implicit declaration of function 'arm_memblock_steal'

Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/dsp.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap2/dsp.c b/arch/arm/mach-omap2/dsp.c
index 845309f..88ffa1e 100644
--- a/arch/arm/mach-omap2/dsp.c
+++ b/arch/arm/mach-omap2/dsp.c
@@ -20,6 +20,9 @@
 
 #include <linux/module.h>
 #include <linux/platform_device.h>
+
+#include <asm/memblock.h>
+
 #include "cm2xxx_3xxx.h"
 #include "prm2xxx_3xxx.h"
 #ifdef CONFIG_BRIDGE_DVFS

