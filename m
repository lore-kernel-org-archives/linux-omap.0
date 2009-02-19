From: Felipe Balbi <me@felipebalbi.com>
Subject: [PATCH 5/5] input: keyboard: removed unused lm8323_set_platform_data
Date: Thu, 19 Feb 2009 14:29:43 +0200
Message-ID: <1235046583-29696-6-git-send-email-me@felipebalbi.com>
References: <1235046583-29696-1-git-send-email-me@felipebalbi.com>
 <1235046583-29696-2-git-send-email-me@felipebalbi.com>
 <1235046583-29696-3-git-send-email-me@felipebalbi.com>
 <1235046583-29696-4-git-send-email-me@felipebalbi.com>
 <1235046583-29696-5-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:56004 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753714AbZBSMaF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Feb 2009 07:30:05 -0500
In-Reply-To: <1235046583-29696-5-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Felipe Balbi <me@felipebalbi.com>

that's unused prototype, remove it.

Signed-off-by: Felipe Balbi <me@felipebalbi.com>
---
 include/linux/i2c/lm8323.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/include/linux/i2c/lm8323.h b/include/linux/i2c/lm8323.h
index 17d6b33..5eae5cc 100644
--- a/include/linux/i2c/lm8323.h
+++ b/include/linux/i2c/lm8323.h
@@ -32,6 +32,4 @@ struct lm8323_platform_data {
 	char *name; /* Device name. */
 };
 
-void __init lm8323_set_platform_data(struct lm8323_platform_data *pdata);
-
 #endif /* __LINUX_LM8323_H */
-- 
1.6.1.3

