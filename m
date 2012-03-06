From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 3/5] Revert "ASoC: Remove twl6040 dependency on twl4030 from Kconfig"
Date: Tue,  6 Mar 2012 14:35:14 +0200
Message-ID: <1331037316-7375-4-git-send-email-peter.ujfalusi@ti.com>
References: <1331037316-7375-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:35389 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030579Ab2CFMfh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Mar 2012 07:35:37 -0500
Received: by mail-lpp01m010-f43.google.com with SMTP id r15so7354243lag.2
        for <linux-omap@vger.kernel.org>; Tue, 06 Mar 2012 04:35:36 -0800 (PST)
In-Reply-To: <1331037316-7375-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Tony Lindgren <tony@atomide.com>, Liam Girdwood <lrg@ti.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-next@vger.kernel.org, paul.gortmaker@windriver.com

This reverts commit 36229729d92f903a7311f1c040b33d5bab0af60b.

Reverting changes regarding to twl6040 in MFD tree since the patches will go
via the audio tree.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index f1a1197..7c205e7 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -56,7 +56,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_TPA6130A2 if I2C
 	select SND_SOC_TLV320DAC33 if I2C
 	select SND_SOC_TWL4030 if TWL4030_CORE
-	select SND_SOC_TWL6040 if I2C
+	select SND_SOC_TWL6040 if TWL4030_CORE
 	select SND_SOC_UDA134X
 	select SND_SOC_UDA1380 if I2C
 	select SND_SOC_WL1273 if MFD_WL1273_CORE
-- 
1.7.8.5

