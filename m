From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCHv4 02/20] OMAP: McBSP: Add IRQEN, IRQSTATUS, THRESHOLD2 and THRESHOLD1 registers.
Date: Mon, 17 Aug 2009 17:13:18 +0300
Message-ID: <1250518398-13657-1-git-send-email-eduardo.valentin@nokia.com>
References: <20090817135301.GV7278@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:20316 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752928AbZHQO1X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Aug 2009 10:27:23 -0400
In-Reply-To: <20090817135301.GV7278@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, Jarkko Nikula <jhnikula@gmail.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eduardo Valentin <eduardo.valentin@nokia.com>

From: Eduardo Valentin <eduardo.valentin@nokia.com>

Adding McBSP register definition for IRQEN, IRQSTATUS, THRESHOLD2 and THRESHOLD1 registers.

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 arch/arm/plat-omap/include/mach/mcbsp.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h b/arch/arm/plat-omap/include/mach/mcbsp.h
index b85e6e6..ceaf9ee 100644
--- a/arch/arm/plat-omap/include/mach/mcbsp.h
+++ b/arch/arm/plat-omap/include/mach/mcbsp.h
@@ -134,6 +134,10 @@
 #define OMAP_MCBSP_REG_XCERG	0x74
 #define OMAP_MCBSP_REG_XCERH	0x78
 #define OMAP_MCBSP_REG_SYSCON	0x8C
+#define OMAP_MCBSP_REG_THRSH2	0x90
+#define OMAP_MCBSP_REG_THRSH1	0x94
+#define OMAP_MCBSP_REG_IRQST	0xA0
+#define OMAP_MCBSP_REG_IRQEN	0xA4
 #define OMAP_MCBSP_REG_XCCR	0xAC
 #define OMAP_MCBSP_REG_RCCR	0xB0
 
-- 
1.6.2.GIT

