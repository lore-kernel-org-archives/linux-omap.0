From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 6/6] OMAP: Fix compile break in serial with CONFIG_PM disabled
Date: Fri, 19 Feb 2010 17:57:17 +0530
Message-ID: <1266582437-22398-6-git-send-email-rnayak@ti.com>
References: <1266582437-22398-1-git-send-email-rnayak@ti.com>
 <1266582437-22398-2-git-send-email-rnayak@ti.com>
 <1266582437-22398-3-git-send-email-rnayak@ti.com>
 <1266582437-22398-4-git-send-email-rnayak@ti.com>
 <1266582437-22398-5-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:32816 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753088Ab0BSM10 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Feb 2010 07:27:26 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o1JCRMVZ015531
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 19 Feb 2010 06:27:25 -0600
In-Reply-To: <1266582437-22398-5-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com
Cc: Rajendra Nayak <rnayak@ti.com>

omap_h4_2420_defconfig breaks in serial because on the below issue.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/serial.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index ac8262d..3905574 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -527,7 +527,12 @@ static ssize_t sleep_timeout_store(struct device *dev,
 DEVICE_ATTR(sleep_timeout, 0644, sleep_timeout_show, sleep_timeout_store);
 #define DEV_CREATE_FILE(dev, attr) WARN_ON(device_create_file(dev, attr))
 #else
-static inline void omap_uart_idle_init(struct omap_uart_state *uart) {}
+static inline void omap_uart_idle_init(struct omap_uart_state *uart)
+{
+}
+static void omap_uart_block_sleep(struct omap_uart_state *uart)
+{
+}
 #define DEV_CREATE_FILE(dev, attr)
 #endif /* CONFIG_PM */
 
-- 
1.5.4.7

