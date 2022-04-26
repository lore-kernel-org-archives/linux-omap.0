Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA7CC43219
	for <linux-omap@archiver.kernel.org>; Tue, 26 Apr 2022 08:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344930AbiDZIfN (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 26 Apr 2022 04:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345173AbiDZIeL (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 26 Apr 2022 04:34:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6026EB21;
        Tue, 26 Apr 2022 01:26:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3437E617AE;
        Tue, 26 Apr 2022 08:26:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69BCCC385AE;
        Tue, 26 Apr 2022 08:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650961580;
        bh=krMZrWvMwPJVI9cTHoDUkWLh2zEvMrbq5TmpSLtJPAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tjQ7bSIznqmBOQFk1emU7ZaPRo5WntOb36802ej6rLrPmcesjyaPm03Y0SxAoq79u
         7nfLo3v9xICM5AB3Mz04uAJpSGDgGXTbO3ZR/U4enJEkH/dlHzMGnd1zVlqkCpjIWj
         f2J2uZGRJdJT7sxDY+z5sLAzkk0vlhRtnrsgkKVc+2lNYo970wGYg47c7jJTw1Ea74
         NQL4MgrXWK5WDmQc+pO+l7q1CUM3VSGun4Gwz5gA3dGtbECRfkLipK0ekqIo9UCw4G
         mEOoV5ErocHqJ3ViMSeNRO5YcKuzd5wEa/bidK8Znt1H5Sni6ZD20aXDC7kjMSSH/7
         5UlTDiqWewXQg==
From:   Roger Quadros <rogerq@kernel.org>
To:     krzk@kernel.org
Cc:     miquel.raynal@bootlin.com, tony@atomide.com, vigneshr@ti.com,
        kishon@ti.com, nm@ti.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v4 1/2] memory: omap-gpmc: Make OMAP_GPMC config visible and selectable
Date:   Tue, 26 Apr 2022 11:26:10 +0300
Message-Id: <20220426082611.24427-2-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220426082611.24427-1-rogerq@kernel.org>
References: <20220426082611.24427-1-rogerq@kernel.org>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

So far for armv7 TI platforms, GPMC was being selected by
arch/arm/mach-* architecture Kconfig files.

For K3 platforms, GPMC is no longer required for basic boot
and cannot be always enabled by default by mach- Kconfig.

We need a way for user (or board defconfig) to enable
it if required so make OMAP_GPMC Kconfig option always visible.

Drop COMPILE_TEST as build fails if IRQ_DOMAIN is not enabled.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/memory/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index 30bff6cb1b8d..da9634daad04 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -103,7 +103,7 @@ config TI_EMIF
 	  temperature changes
 
 config OMAP_GPMC
-	bool "Texas Instruments OMAP SoC GPMC driver" if COMPILE_TEST
+	bool "Texas Instruments OMAP SoC GPMC driver"
 	depends on OF_ADDRESS
 	select GPIOLIB
 	help
-- 
2.17.1

