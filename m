From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [RFC 01/12] ASoC: OMAP: McBSP: fix build breakage on OMAP1
Date: Fri,  1 Jul 2011 11:52:25 +0300
Message-ID: <1309510356-27147-2-git-send-email-jhnikula@gmail.com>
References: <1309510356-27147-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58452 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755646Ab1GAIw4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 04:52:56 -0400
Received: by mail-bw0-f46.google.com with SMTP id 5so2453487bwd.19
        for <linux-omap@vger.kernel.org>; Fri, 01 Jul 2011 01:52:55 -0700 (PDT)
In-Reply-To: <1309510356-27147-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>

From: Paul Walmsley <paul@pwsan.com>

After commits d13586574d373ef40acd4725c9a269daa355e412 ("OMAP: McBSP:
implement functional clock switching via clock framework") and
cf4c87abe238ec17cd0255b4e21abd949d7f811e ("OMAP: McBSP: implement
McBSP CLKR and FSR signal muxing via mach-omap2/mcbsp.c"), any OMAP1
board (such as the AMS Delta) that uses the ASoC McBSP driver will no
longer build:

sound/built-in.o: In function `omap_mcbsp_dai_set_dai_sysclk':
last.c:(.text+0x24ff8): undefined reference to `omap2_mcbsp1_mux_clkr_src'
last.c:(.text+0x2500c): undefined reference to `omap2_mcbsp1_mux_fsr_src'
make: *** [vmlinux] Error 1

Fix by defining three OMAP1-only dummy functions for
omap2_mcbsp1_mux_clkr_src(), omap2_mcbsp1_mux_fsr_src(), and
omap2_mcbsp_set_clks_src().

Normally, code that is OMAP SoC-revision-specific like this should go
under the arch/arm/*omap* directories, and get abstracted away from
drivers via struct platform_data function pointers.  This doesn't work
in this case since there doesn't appear to be any convenient way to access
struct platform_data (or something like it) in the current design of
the sound/soc/omap/omap-mcbsp.c driver.

Reported by Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> and Tony Lindgren
<tony@atomide.com>.  Janusz also posted a patch to fix this at:

   http://www.spinics.net/lists/linux-omap/msg39560.html

(among other places), but the following approach seems less dependent
on compiler behavior.

This patch passes build tests for ams_delta_defconfig and omap2plus_defconfig,
but since I don't have an AMS Delta here, I can't boot test it on that
platform.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>
---
 arch/arm/plat-omap/mcbsp.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 455eadc..2a3587e 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -969,6 +969,33 @@ void omap_mcbsp_stop(unsigned int id, int tx, int rx)
 }
 EXPORT_SYMBOL(omap_mcbsp_stop);
 
+/*
+ * The following functions are only required on an OMAP1-only build.
+ * mach-omap2/mcbsp.c contains the real functions
+ */
+#ifndef CONFIG_ARCH_OMAP2PLUS
+int omap2_mcbsp_set_clks_src(u8 id, u8 fck_src_id)
+{
+	WARN(1, "%s: should never be called on an OMAP1-only kernel\n",
+	     __func__);
+	return -EINVAL;
+}
+
+void omap2_mcbsp1_mux_clkr_src(u8 mux)
+{
+	WARN(1, "%s: should never be called on an OMAP1-only kernel\n",
+	     __func__);
+	return;
+}
+
+void omap2_mcbsp1_mux_fsr_src(u8 mux)
+{
+	WARN(1, "%s: should never be called on an OMAP1-only kernel\n",
+	     __func__);
+	return;
+}
+#endif
+
 #ifdef CONFIG_ARCH_OMAP3
 #define max_thres(m)			(mcbsp->pdata->buffer_size)
 #define valid_threshold(m, val)		((val) <= max_thres(m))
-- 
1.7.0.4

