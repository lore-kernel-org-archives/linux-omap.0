From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 12/13] ARM: OMAP2+: hwmod: call to _omap4_disable_module()
 should use the SoC-specific call
Date: Thu, 25 Oct 2012 17:21:22 -0600
Message-ID: <20121025232121.17558.53104.stgit@dusk.lan>
References: <20121025231818.17558.57884.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:38298 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752326Ab2JYXYF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 19:24:05 -0400
In-Reply-To: <20121025231818.17558.57884.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The hwmod code unconditionally calls _omap4_disable_module() on all
SoCs when a module doesn't enable correctly.  This "worked" due to the
weak function omap4_cminst_wait_module_idle() in
arch/arm/mach-omap2/prcm.c, which was a no-op.  But now those weak
functions are going away - they should not be used.  So this patch
will now call the SoC-specific disable_module code, assuming it
exists.

Needs to be done before the weak function is removed, otherwise AM33xx
will crash early in boot.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index bc891e9..85e8874 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2062,7 +2062,8 @@ static int _enable(struct omap_hwmod *oh)
 			_enable_sysc(oh);
 		}
 	} else {
-		_omap4_disable_module(oh);
+		if (soc_ops.disable_module)
+			soc_ops.disable_module(oh);
 		_disable_clocks(oh);
 		pr_debug("omap_hwmod: %s: _wait_target_ready: %d\n",
 			 oh->name, r);


