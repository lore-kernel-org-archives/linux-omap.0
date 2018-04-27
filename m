From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] MAINTAINERS: update OMAP MMC entry
Date: Sat, 28 Apr 2018 00:22:28 +0300
Message-ID: <20180427212228.25426-1-aaro.koskinen@iki.fi>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jarkko Lavinen <jarkko.lavinen@nokia.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

Jarkko's e-mail address hasn't worked for a long time. We still want
to keep this driver working as it is critical for some of the OMAP boards.
I use and test this driver frequently, so add myself as a maintainer
with "Odd Fixes" status.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3e41e12a88a4..0dbac7e43b17 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10206,9 +10206,9 @@ F:	drivers/media/platform/omap3isp/
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
