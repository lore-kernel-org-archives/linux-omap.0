Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BA7C0018A
	for <linux-omap@archiver.kernel.org>; Thu,  2 Nov 2023 15:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbjKBPVE (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 2 Nov 2023 11:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjKBPVD (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Thu, 2 Nov 2023 11:21:03 -0400
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107571A8;
        Thu,  2 Nov 2023 08:20:50 -0700 (PDT)
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id A56FD83FE9;
        Thu,  2 Nov 2023 16:20:48 +0100 (CET)
From:   =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Leo Yan <leoy@marvell.com>,
        Zhangfei Gao <zhangfei.gao@marvell.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-hardening@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Karel Balej <balejk@matfyz.cz>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v7 06/10] ASoC: pxa: Suppress SSPA on ARM64
Date:   Thu,  2 Nov 2023 16:20:29 +0100
Message-ID: <20231102152033.5511-1-duje.mihanovic@skole.hr>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

The SSPA driver currently seems to generate ARM32 assembly, which causes
build errors when building a kernel for an ARM64 ARCH_MMP platform.

Fixes: fa375d42f0e5 ("ASoC: mmp: add sspa support")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310230518.zs9Qpg3j-lkp@intel.com/
Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 sound/soc/pxa/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index e6bca9070953..8ebce669e4a7 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -33,7 +33,7 @@ config SND_PXA_SOC_SSP
 
 config SND_MMP_SOC_SSPA
 	tristate "SoC Audio via MMP SSPA ports"
-	depends on ARCH_MMP
+	depends on ARCH_MMP && ARM
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	select SND_ARM
 	help
-- 
2.42.0


