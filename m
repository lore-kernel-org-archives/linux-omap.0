From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/3] ARM: OMAP2+: io: fix compilation breakage on 2420-only
 configs
Date: Sun, 22 Jan 2012 04:02:32 -0700
Message-ID: <20120122110231.6508.89652.stgit@dusk>
References: <20120122105942.6508.82335.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46339 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816Ab2AVLDV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 Jan 2012 06:03:21 -0500
In-Reply-To: <20120122105942.6508.82335.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>

Commit 7b250aff1ce346b6c7bc0329a2350334d1c66525 ("ARM: OMAP: Avoid
cpu_is_omapxxxx usage until map_io is done") breaks the build on a
2420-only config on v3.3-rc1:

arch/arm/mach-omap2/built-in.o: In function `omap2430_init_early':
arch/arm/mach-omap2/io.c:406: undefined reference to `omap2_set_globals_243x'
arch/arm/mach-omap2/io.c:410: undefined reference to `omap243x_clockdomains_init'
arch/arm/mach-omap2/io.c:411: undefined reference to `omap2430_hwmod_init'

Fix by only compiling omap2420_init_early() when CONFIG_SOC_OMAP2420
is selected, and only compiling omap2430_init_early() when
CONFIG_SOC_OMAP2430 is selected.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/io.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 3f174d5..eb50c29 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -388,7 +388,7 @@ static void __init omap_hwmod_init_postsetup(void)
 	omap_pm_if_early_init();
 }
 
-#ifdef CONFIG_ARCH_OMAP2
+#ifdef CONFIG_SOC_OMAP2420
 void __init omap2420_init_early(void)
 {
 	omap2_set_globals_242x();
@@ -400,7 +400,9 @@ void __init omap2420_init_early(void)
 	omap_hwmod_init_postsetup();
 	omap2420_clk_init();
 }
+#endif
 
+#ifdef CONFIG_SOC_OMAP2430
 void __init omap2430_init_early(void)
 {
 	omap2_set_globals_243x();


