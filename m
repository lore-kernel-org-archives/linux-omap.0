From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2.6.37-rc1] ASoC: OMAP: fix OMAP1 compilation problem
Date: Mon, 22 Nov 2010 17:48:24 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1011221745490.20215@utopia.booyaka.com>
References: <201011021550.34885.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51397 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932339Ab0KWAsZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Nov 2010 19:48:25 -0500
In-Reply-To: <201011021550.34885.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Liam Girdwood <lrg@slimlogic.co.uk>, tony@atomide.com, alsa-devel@alsa-project.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, e3-hacking@earth.li

Hello Janusz, Mark,

On Tue, 2 Nov 2010, Janusz Krzysztofik wrote:

> In the new code introduced with commit cf4c87abe238ec17cd0255b4e21abd949d7f811e,
> "OMAP: McBSP: implement McBSP CLKR and FSR signal muxing via mach-omap2/mcbsp.c",
> the way omap1 build is supposed to bypass omap2 specific functionality doesn't 
> optimize out all omap2 specific stuff. This breaks linking phase for omap1 
> machines, giving "undefined reference to `omap2_mcbsp1_mux_clkr_src'" 
> and "undefined reference to `omap2_mcbsp1_mux_fsr_src'" errors. Fix it.
> 
> Created and tested against linux-2.6.37-rc1.
> 
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

Thanks for fixing this.  What do you think about the following patch 
instead?  It should avoid any compiler issues.


- Paul


From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] ASoC: OMAP: McBSP: fix build breakage on OMAP1

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
index fdecd33..1fbfcf3 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -1466,6 +1466,33 @@ void omap_mcbsp_set_spi_mode(unsigned int id,
 }
 EXPORT_SYMBOL(omap_mcbsp_set_spi_mode);
 
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
1.7.2.3

