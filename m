From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 2/2] ARM: omap: hwmod: Make omap_hwmod_softreset wait for reset status
Date: Tue, 13 Mar 2012 19:33:55 +0530
Message-ID: <1331647435-31666-3-git-send-email-rnayak@ti.com>
References: <1331647435-31666-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49424 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754647Ab2CMOEE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Mar 2012 10:04:04 -0400
In-Reply-To: <1331647435-31666-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com, paul@pwsan.com
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
index ae56939..489f82d 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1907,20 +1907,10 @@ void omap_hwmod_write(u32 v, struct omap_hwmod *oh, u16 reg_offs)
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

