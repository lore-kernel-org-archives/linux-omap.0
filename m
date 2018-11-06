From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH v2] MAINTAINERS: update OMAP MMC entry
Date: Wed,  7 Nov 2018 00:27:50 +0200
Message-ID: <20181106222750.12939-1-aaro.koskinen@iki.fi>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Tony Lindgren <tony@atomide.com>, Jarkko Lavinen <jarkko.lavinen@nokia.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

Jarkko's e-mail address hasn't worked for a long time. We still want
to keep this driver working as it is critical for some of the OMAP boards.
I use and test this driver frequently, so change myself as a maintainer
with "Odd Fixes" status.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 CREDITS     | 4 ++++
 MAINTAINERS | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

	v2: Add Jarkko to CREDITS.

	v1: https://patchwork.kernel.org/patch/10369861/

diff --git a/CREDITS b/CREDITS
index 5befd2d714d0..84cbec4c6211 100644
--- a/CREDITS
+++ b/CREDITS
@@ -2138,6 +2138,10 @@ E: paul@laufernet.com
 D: Soundblaster driver fixes, ISAPnP quirk
 S: California, USA
 
+N: Jarkko Lavinen
+E: jarkko.lavinen@nokia.com
+D: OMAP MMC support
+
 N: Jonathan Layes
 D: ARPD support
 
diff --git a/MAINTAINERS b/MAINTAINERS
index f4855974f325..1c2badfec2ec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10793,9 +10793,9 @@ F:	drivers/media/platform/omap3isp/
 F:	drivers/staging/media/omap4iss/
 
 OMAP MMC SUPPORT
-M:	Jarkko Lavinen <jarkko.lavinen@nokia.com>
+M:	Aaro Koskinen <aaro.koskinen@iki.fi>
 L:	linux-omap@vger.kernel.org
-S:	Maintained
+S:	Odd Fixes
 F:	drivers/mmc/host/omap.c
 
 OMAP POWER MANAGEMENT SUPPORT
-- 
2.17.0
