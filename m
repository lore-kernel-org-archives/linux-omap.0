From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 06/11] omap4: Fix omap_l2_cache_init not to run for other omaps
Date: Fri, 30 Apr 2010 13:33:59 -0700
Message-ID: <20100430203359.25812.56284.stgit@baageli.muru.com>
References: <20100430202603.25812.41834.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:65233 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933164Ab0D3UeA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Apr 2010 16:34:00 -0400
In-Reply-To: <20100430202603.25812.41834.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

In multi-omap configuration all the initcalls run. To avoid
bad things from happening with 44xx specific initcalls on
other omaps, we need to check that the booted system is
omap4 before running.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index b88f28c..e603b00 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -55,6 +55,9 @@ static int __init omap_l2_cache_init(void)
 	extern void omap_smc1(u32 fn, u32 arg);
 	void __iomem *l2cache_base;
 
+	if (!cpu_is_omap44xx())
+		return -ENODEV;
+
 	/* To avoid code running on other OMAPs in
 	 * multi-omap builds
 	 */

