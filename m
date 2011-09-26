From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 04/13] irq: Add stub for none DT build in irqdomain.h
Date: Mon, 26 Sep 2011 18:50:12 +0200
Message-ID: <1317055821-20652-5-git-send-email-b-cousson@ti.com>
References: <1317055821-20652-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48681 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751511Ab1IZQvI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Sep 2011 12:51:08 -0400
In-Reply-To: <1317055821-20652-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, grant.likely@secretlab.ca
Cc: paul@pwsan.com, khilman@ti.com, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>

Add an empty funtion to allow building a file without
adding some #ifdef CONFIG_OF around of APIs.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Grant Likely <grant.likely@secretlab.ca>
---
 include/linux/irqdomain.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index e807ad6..6fa08ab 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -84,6 +84,8 @@ extern void irq_domain_add_simple(struct device_node *controller, int irq_base);
 extern void irq_domain_generate_simple(const struct of_device_id *match,
 					u64 phys_base, unsigned int irq_start);
 #else /* CONFIG_IRQ_DOMAIN && CONFIG_OF_IRQ */
+static inline void irq_domain_add_simple(struct device_node *controller,
+					 int irq_base) { }
 static inline void irq_domain_generate_simple(const struct of_device_id *match,
 					u64 phys_base, unsigned int irq_start) { }
 #endif /* CONFIG_IRQ_DOMAIN && CONFIG_OF_IRQ */
-- 
1.7.0.4

