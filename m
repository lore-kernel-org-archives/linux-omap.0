From: ext-eero.nurkkala@nokia.com
Subject: [PATCH 1/2] OMAP: McBSP: Always maintain McBSP fclk while active
Date: Mon,  9 Mar 2009 09:05:11 +0200
Message-ID: <12365823142066-git-send-email-ext-eero.nurkkala@nokia.com>
References: <12365823123402-git-send-email-ext-eero.nurkkala@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:61301 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989AbZCIHIc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Mar 2009 03:08:32 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n29778TR011084
	for <linux-omap@vger.kernel.org>; Mon, 9 Mar 2009 02:08:29 -0500
In-Reply-To: <12365823123402-git-send-email-ext-eero.nurkkala@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

McBSP fclk must be maintained for the duration of
audio playback or recording. Otherwise the fclk
may get autogated when the PER96M clk is no longer
required by other modules. This results in audio
playback being hang. Fix this phenomenom by 
enabling the McBSP fclk clockactivity bit for
the entire active duration of McBSP usage

Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
---
 arch/arm/plat-omap/include/mach/mcbsp.h |    1 +
 arch/arm/plat-omap/mcbsp.c              |    6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h b/arch/arm/plat-omap/include/mach/mcbsp.h
index 26bde05..ec61b89 100644
--- a/arch/arm/plat-omap/include/mach/mcbsp.h
+++ b/arch/arm/plat-omap/include/mach/mcbsp.h
@@ -252,6 +252,7 @@
 #define RDISABLE		0x0001
 
 /********************** McBSP SYSCONFIG bit definitions ********************/
+#define CLOCKACTIVITY(value)	((value)<<8)
 #define SIDLEMODE(value)	((value)<<3)
 #define ENAWAKEUP		0x0004
 #define SOFTRST			0x0002
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index a94d03e..59850c2 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -248,8 +248,8 @@ int omap_mcbsp_request(unsigned int id)
 		u16 w;
 
 		w = OMAP_MCBSP_READ(mcbsp->io_base, SYSCON);
-		w &= ~(ENAWAKEUP | SIDLEMODE(0x03));
-		w |= (ENAWAKEUP | SIDLEMODE(0x02));
+		w &= ~(ENAWAKEUP | SIDLEMODE(0x03) | CLOCKACTIVITY(0x03));
+		w |= (ENAWAKEUP | SIDLEMODE(0x02) | CLOCKACTIVITY(0x01));
 		OMAP_MCBSP_WRITE(mcbsp->io_base, SYSCON, w);
 
 		OMAP_MCBSP_WRITE(mcbsp->io_base, WAKEUPEN, WAKEUPEN_ALL);
@@ -308,7 +308,7 @@ void omap_mcbsp_free(unsigned int id)
 		u16 w;
 
 		w = OMAP_MCBSP_READ(mcbsp->io_base, SYSCON);
-		w &= ~(ENAWAKEUP | SIDLEMODE(0x03));
+		w &= ~(ENAWAKEUP | SIDLEMODE(0x03) | CLOCKACTIVITY(0x03));
 		OMAP_MCBSP_WRITE(mcbsp->io_base, SYSCON, w);
 
 		w = OMAP_MCBSP_READ(mcbsp->io_base, WAKEUPEN);
-- 
1.5.2

