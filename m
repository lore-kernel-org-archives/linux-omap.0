From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 1/3] ARM: OMAP2+: return -ENODEV if GPMC child device creation fails
Date: Thu, 14 Mar 2013 16:09:20 +0100
Message-ID: <1363273762-17441-2-git-send-email-javier.martinez@collabora.co.uk>
References: <1363273762-17441-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:46305 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089Ab3CNPJh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Mar 2013 11:09:37 -0400
In-Reply-To: <1363273762-17441-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, Enric Balletbo i Serra <eballetbo@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

gpmc_probe_nor_child() calls of_platform_device_create() to create a
platform device for the NOR child. If this function fails the value
of ret is returned to the caller but this value is zero since it was
assigned the return of a previous call to gpmc_cs_program_settings()
that had to succeed or otherwise gpmc_probe_nor_child() would have
returned before.

This means that if of_platform_device_create() fails, 0 will be returned
to the caller instead of an appropriate error code.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/mach-omap2/gpmc.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index d594e1d..8799aed 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1505,6 +1505,7 @@ static int gpmc_probe_nor_child(struct platform_device *pdev,
 		return 0;
 
 	dev_err(&pdev->dev, "failed to create gpmc child %s\n", child->name);
+	ret = -ENODEV;
 
 err:
 	gpmc_cs_free(cs);
-- 
1.7.7.6

