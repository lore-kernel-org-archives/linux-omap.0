From: Andy Green <andy@warmcat.com>
Subject: [PATCH 2 06/18] I2C: OMAP1: set IP revision in platform data
Date: Tue, 08 Mar 2011 11:08:05 +0000
Message-ID: <20110308110804.23531.45336.stgit@otae.warmcat.com>
References: <20110308105934.23531.83540.stgit@otae.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52226 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753828Ab1CHLII (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Mar 2011 06:08:08 -0500
Received: by mail-ww0-f44.google.com with SMTP id 36so951436wwa.1
        for <linux-omap@vger.kernel.org>; Tue, 08 Mar 2011 03:08:07 -0800 (PST)
In-Reply-To: <20110308105934.23531.83540.stgit@otae.warmcat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: patches@linaro.org, Ben Dooks <ben-linux@fluff.org>, Andy Green <andy.green@linaro.org>

All OMAP1 are using "IP revision 1" in terms of register
layout.  We set this information in omap1_i2c_add_bus() so
we don't have to use cpu_is_xxx() any more in the omap i2c
driver.

Cc: patches@linaro.org
Cc: Ben Dooks <ben-linux@fluff.org>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
---

 arch/arm/plat-omap/i2c.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index 3341ca4..a938df0 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -108,6 +108,9 @@ static inline int omap1_i2c_add_bus(int bus_id)
 	res[1].start = INT_I2C;
 	pdata = &i2c_pdata[bus_id - 1];
 
+	/* all OMAP1 have IP version 1 register set */
+	pdata->rev = OMAP_I2C_IP_VERSION_1;
+
 	return platform_device_register(pdev);
 }
 

