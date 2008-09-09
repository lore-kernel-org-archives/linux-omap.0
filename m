From: "Arun KS" <arunks@mistralsolutions.com>
Subject: [PATCH] This patch fixes the typo which breaks the build on OMAP1
Date: Tue, 9 Sep 2008 13:10:59 +0530
Message-ID: <dfeb90390809090040r59b401eciafb005f7d31cd398@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.190]:64859 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753475AbYIIHlB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Sep 2008 03:41:01 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1151835tic.23
        for <linux-omap@vger.kernel.org>; Tue, 09 Sep 2008 00:40:59 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Signed-off-by: Arun KS <arunks@mistralsolutions.com>
---
 sound/soc/omap/omap-mcbsp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index a217cf2..3a4cc4b 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -96,7 +96,7 @@ static const int omap24xx_dma_reqs[][2] = {
 #endif
 };
 #else
-static const int omap2420_dma_reqs[][2] = {};
+static const int omap24xx_dma_reqs[][2] = {};
 #endif

 #if defined(CONFIG_ARCH_OMAP2420)
-- 
1.5.3.4
