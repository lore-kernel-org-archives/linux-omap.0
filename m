From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 1/2] ARM: omap: hwmod: Restore sysc after a reset
Date: Tue, 13 Mar 2012 19:33:54 +0530
Message-ID: <1331647435-31666-2-git-send-email-rnayak@ti.com>
References: <1331647435-31666-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49423 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754454Ab2CMOEE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Mar 2012 10:04:04 -0400
In-Reply-To: <1331647435-31666-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com, paul@pwsan.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Shubhrajyoti D <shubhrajyoti@ti.com>

After a softreset, make sure the sysc settings are correctly
restored.

Reported-by: Anand Gadiyar <gadiyar@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index eba6cd3..ae56939 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2270,6 +2270,10 @@ int omap_hwmod_reset(struct omap_hwmod *oh)
 
 	spin_lock_irqsave(&oh->_lock, flags);
 	r = _reset(oh);
+	if (oh->class->sysc) {
+		_update_sysc_cache(oh);
+		_enable_sysc(oh);
+	}
 	spin_unlock_irqrestore(&oh->_lock, flags);
 
 	return r;
-- 
1.7.1

