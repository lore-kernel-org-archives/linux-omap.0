From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCHv5 02/20] OMAP: McBSP: Add IRQEN, IRQSTATUS, THRESHOLD2 and THRESHOLD1 registers.
Date: Thu, 20 Aug 2009 16:18:08 +0300
Message-ID: <1250774306-7581-2-git-send-email-eduardo.valentin@nokia.com>
References: <1250774306-7581-1-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:48197 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754382AbZHTNc5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Aug 2009 09:32:57 -0400
In-Reply-To: <1250774306-7581-1-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eduardo Valentin <eduardo.valentin@nokia.com>

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

