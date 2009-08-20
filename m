From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCHv5 11/20] OMAP: McBSP: Retain McBSP FCLK clockactivity
Date: Thu, 20 Aug 2009 16:18:17 +0300
Message-ID: <1250774306-7581-11-git-send-email-eduardo.valentin@nokia.com>
References: <1250774306-7581-1-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:48242 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754522AbZHTNdO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Aug 2009 09:33:14 -0400
In-Reply-To: <1250774306-7581-1-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eero Nurkkala <ext-eero.nurkkala@nokia.com>, Eduardo Valentin <eduardo.valentin@nokia.com>

From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

FCLK may get autogated so that it prevents the McBSP
to work properly. It is the bit 9 that must be set
for maintaining the McBSP FCLK.

Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
Acked-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 arch/arm/plat-omap/include/mach/mcbsp.h |    1 +
 arch/arm/plat-omap/mcbsp.c              |    6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h b/arch/arm/plat-omap/include/mach/mcbsp.h
index fe10ae8..70e950e 100644
--- a/arch/arm/plat-omap/include/mach/mcbsp.h
+++ b/arch/arm/plat-omap/include/mach/mcbsp.h
@@ -254,6 +254,7 @@
 #define RDISABLE		0x0001
 
 /********************** McBSP SYSCONFIG bit definitions ********************/
+#define CLOCKACTIVITY(value)	((value)<<8)
 #define SIDLEMODE(value)	((value)<<3)
 #define ENAWAKEUP		0x0004
 #define SOFTRST			0x0002
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 86bfad8..2c274e6 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -316,8 +316,8 @@ static inline void omap34xx_mcbsp_request(struct omap_mcbsp *mcbsp)
 		u16 syscon;
 
 		syscon = OMAP_MCBSP_READ(mcbsp->io_base, SYSCON);
-		syscon &= ~(ENAWAKEUP | SIDLEMODE(0x03));
-		syscon |= (ENAWAKEUP | SIDLEMODE(0x02));
+		syscon &= ~(ENAWAKEUP | SIDLEMODE(0x03) | CLOCKACTIVITY(0x03));
+		syscon |= (ENAWAKEUP | SIDLEMODE(0x02) | CLOCKACTIVITY(0x02));
 		OMAP_MCBSP_WRITE(mcbsp->io_base, SYSCON, syscon);
 
 		OMAP_MCBSP_WRITE(mcbsp->io_base, WAKEUPEN, XRDYEN | RRDYEN);
@@ -333,7 +333,7 @@ static inline void omap34xx_mcbsp_free(struct omap_mcbsp *mcbsp)
 		u16 syscon;
 
 		syscon = OMAP_MCBSP_READ(mcbsp->io_base, SYSCON);
-		syscon &= ~(ENAWAKEUP | SIDLEMODE(0x03));
+		syscon &= ~(ENAWAKEUP | SIDLEMODE(0x03) | CLOCKACTIVITY(0x03));
 		OMAP_MCBSP_WRITE(mcbsp->io_base, SYSCON, syscon);
 
 		OMAP_MCBSP_WRITE(mcbsp->io_base, WAKEUPEN, 0);
-- 
1.6.2.GIT

