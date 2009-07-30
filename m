From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCH 03/20] OMAP: McBSP: Change wakeup signals
Date: Thu, 30 Jul 2009 15:49:26 +0300
Message-ID: <1248958183-15015-4-git-send-email-eduardo.valentin@nokia.com>
References: <1248958183-15015-1-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-2-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-3-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:25904 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbZG3NBC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Jul 2009 09:01:02 -0400
In-Reply-To: <1248958183-15015-3-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org
Cc: Jarkko Nikula <jhnikula@gmail.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Eduardo Valentin <eduardo.valentin@nokia.com>

Configure only XRDYEN and RRDYEN wakeup signals
in order to get better power consumption.

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 arch/arm/plat-omap/include/mach/mcbsp.h |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h b/arch/arm/plat-omap/include/mach/mcbsp.h
index 758ad5c..89d1bea 100644
--- a/arch/arm/plat-omap/include/mach/mcbsp.h
+++ b/arch/arm/plat-omap/include/mach/mcbsp.h
@@ -264,9 +264,7 @@
 #define REOFEN			0x0004
 #define RFSREN			0x0002
 #define RSYNCERREN		0x0001
-#define WAKEUPEN_ALL		(XEMPTYEOFEN | XRDYEN | XEOFEN | XFSXEN | \
-				 XSYNCERREN | RRDYEN | REOFEN | RFSREN | \
-				 RSYNCERREN)
+#define WAKEUPEN_ALL		(XRDYEN | RRDYEN)
 
 /* we don't do multichannel for now */
 struct omap_mcbsp_reg_cfg {
-- 
1.6.2.GIT

