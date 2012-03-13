From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 2/2] ARM: omap: hwmod: Make omap_hwmod_softreset wait for reset status
Date: Tue, 13 Mar 2012 22:55:24 +0530
Message-ID: <1331659524-7635-3-git-send-email-rnayak@ti.com>
References: <1331659524-7635-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36389 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758772Ab2CMR1M (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Mar 2012 13:27:12 -0400
In-Reply-To: <1331659524-7635-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, b-cousson@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Anand Gadiyar <gadiyar@ti.com>, Shubhrajyoti D <shubhrajyoti@ti.com>

omap_hwmod_softreset() does not seem to wait for reset status
after doing a softreset. Make it use _ocp_softreset() instead
which does this correctly.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Anand Gadiyar <gadiyar@ti.com>
Cc: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   14 ++------------
 1 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 6c0e7eb..0c64853 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2423,20 +2423,10 @@ void omap_hwmod_write(u32 v, struct omap_hwmod *oh, u16 reg_offs)
  */
 int omap_hwmod_softreset(struct omap_hwmod *oh)
 {
-	u32 v;
-	int ret;
-
-	if (!oh || !(oh->_sysc_cache))
+	if (!oh)
 		return -EINVAL;
 
-	v = oh->_sysc_cache;
-	ret = _set_softreset(oh, &v);
-	if (ret)
-		goto error;
-	_write_sysconfig(v, oh);
-
-error:
-	return ret;
+	return _ocp_softreset(oh);
 }
 
 /**
-- 
1.7.1

