From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V3 18/18] ARM: OMAP2+: return -ENODEV if GPMC child device creation fails
Date: Fri, 15 Mar 2013 10:21:16 -0500
Message-ID: <1363360876-13617-19-git-send-email-jon-hunter@ti.com>
References: <1363360876-13617-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51070 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755709Ab3COPWQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Mar 2013 11:22:16 -0400
In-Reply-To: <1363360876-13617-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Daniel Mack <zonque@gmail.com>, Ezequiel Garcia <elezegarcia@gmail.com>, Mark Jackson <mpfj-list@mimc.co.uk>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Jon Hunter <jon-hunter@ti.com>

From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

gpmc_probe_nor_child() calls of_platform_device_create() to create a
platform device for the NOR child. If this function fails the value
of ret is returned to the caller but this value is zero since it was
assigned the return of a previous call to gpmc_cs_program_settings()
that had to succeed or otherwise gpmc_probe_nor_child() would have
returned before.

This means that if of_platform_device_create() fails, 0 will be returned
to the caller instead of an appropriate error code.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/gpmc.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index ee6601c..d4ec5bb 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1504,6 +1504,7 @@ static int gpmc_probe_nor_child(struct platform_device *pdev,
 		return 0;
 
 	dev_err(&pdev->dev, "failed to create gpmc child %s\n", child->name);
+	ret = -ENODEV;
 
 err:
 	gpmc_cs_free(cs);
-- 
1.7.10.4

