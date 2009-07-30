From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCH 05/20] OMAP: McBSP: Retain McBSP FCLK clockactivity
Date: Thu, 30 Jul 2009 15:49:28 +0300
Message-ID: <1248958183-15015-6-git-send-email-eduardo.valentin@nokia.com>
References: <1248958183-15015-1-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-2-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-3-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-4-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-5-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:25903 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146AbZG3NBC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Jul 2009 09:01:02 -0400
In-Reply-To: <1248958183-15015-5-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org
Cc: Jarkko Nikula <jhnikula@gmail.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Eero Nurkkala <ext-eero.nurkkala@nokia.com>, Eduardo Valentin <eduardo.valentin@nokia.com>

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
index 57157b4..e3b300c 100644
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
index b64896b..6b39656 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -266,8 +266,8 @@ int omap_mcbsp_request(unsigned int id)
 		u16 syscon;
 
 		syscon = OMAP_MCBSP_READ(mcbsp->io_base, SYSCON);
-		syscon &= ~(ENAWAKEUP | SIDLEMODE(0x03));
-		syscon |= (ENAWAKEUP | SIDLEMODE(0x02));
+		syscon &= ~(ENAWAKEUP | SIDLEMODE(0x03) | CLOCKACTIVITY(0x03));
+		syscon |= (ENAWAKEUP | SIDLEMODE(0x02) | CLOCKACTIVITY(0x02));
 		OMAP_MCBSP_WRITE(mcbsp->io_base, SYSCON, syscon);
 
 		OMAP_MCBSP_WRITE(mcbsp->io_base, WAKEUPEN, WAKEUPEN_ALL);
@@ -331,7 +331,7 @@ void omap_mcbsp_free(unsigned int id)
 		u16 syscon;
 
 		syscon = OMAP_MCBSP_READ(mcbsp->io_base, SYSCON);
-		syscon &= ~(ENAWAKEUP | SIDLEMODE(0x03));
+		syscon &= ~(ENAWAKEUP | SIDLEMODE(0x03) | CLOCKACTIVITY(0x03));
 		OMAP_MCBSP_WRITE(mcbsp->io_base, SYSCON, syscon);
 
 		wakeupen = OMAP_MCBSP_READ(mcbsp->io_base, WAKEUPEN);
-- 
1.6.2.GIT

