From: Ernesto Ramos <ernesto@ti.com>
Subject: [PATCH 5/5] DSPBRIDGE: Replace simple_strtoul by strict_strtoul
Date: Mon, 21 Jun 2010 17:07:14 -0500
Message-ID: <1277158034-21843-5-git-send-email-ernesto@ti.com>
References: <1277158034-21843-1-git-send-email-ernesto@ti.com>
 <1277158034-21843-2-git-send-email-ernesto@ti.com>
 <1277158034-21843-3-git-send-email-ernesto@ti.com>
 <1277158034-21843-4-git-send-email-ernesto@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43109 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751837Ab0FUWEN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Jun 2010 18:04:13 -0400
In-Reply-To: <1277158034-21843-4-git-send-email-ernesto@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: felipe.contreras@nokia.com, ameya.palande@nokia.com, hiroshi.doyu@nokia.com, Ernesto Ramos <ernesto@ti.com>

Replace simple_strtoul by strict_strtoul in atoi function.

Signed-off-by: Ernesto Ramos <ernesto@ti.com>
---
 drivers/dsp/bridge/rmgr/dbdcd.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/dbdcd.c b/drivers/dsp/bridge/rmgr/dbdcd.c
index e014600..ae85dc2 100644
--- a/drivers/dsp/bridge/rmgr/dbdcd.c
+++ b/drivers/dsp/bridge/rmgr/dbdcd.c
@@ -1010,6 +1010,8 @@ static s32 atoi(char *psz_buf)
 {
 	char *pch = psz_buf;
 	s32 base = 0;
+	unsigned long res;
+	int ret_val;
 
 	while (isspace(*pch))
 		pch++;
@@ -1021,7 +1023,9 @@ static s32 atoi(char *psz_buf)
 		base = 16;
 	}
 
-	return simple_strtoul(pch, NULL, base);
+	ret_val = strict_strtoul(pch, base, &res);
+
+	return ret_val ? : res;
 }
 
 /*
-- 
1.5.4.5

