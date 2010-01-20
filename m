From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 1/8] PM: Increase the cpu idle max state.
Date: Wed, 20 Jan 2010 21:00:35 +0530
Message-ID: <1264001442-20078-2-git-send-email-thara@ti.com>
References: <1264001442-20078-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35260 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753368Ab0ATPat (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Jan 2010 10:30:49 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o0KFUjcP023601
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 20 Jan 2010 09:30:47 -0600
In-Reply-To: <1264001442-20078-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thara Gopinath <thara@ti.com>

This patch increases the maximum number of C states possible
in a system in the cpuidle framework. This is necessary for
OMAP3/OMAP4 when support for open switch retention of
powerdomains are added in the cpuidle path.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 include/linux/cpuidle.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index dcf77fa..8ec8300 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -17,7 +17,7 @@
 #include <linux/kobject.h>
 #include <linux/completion.h>
 
-#define CPUIDLE_STATE_MAX	8
+#define CPUIDLE_STATE_MAX	16
 #define CPUIDLE_NAME_LEN	16
 #define CPUIDLE_DESC_LEN	32
 
-- 
1.5.6.3

