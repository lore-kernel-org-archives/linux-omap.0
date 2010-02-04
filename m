From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH/RFC 2/4] OMAP3EVM: MMC: enable power-saving mode
Date: Wed,  3 Feb 2010 16:51:26 -0800
Message-ID: <1265244688-4055-3-git-send-email-khilman@deeprootsystems.com>
References: <1265244688-4055-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f189.google.com ([209.85.210.189]:54207 "EHLO
	mail-yx0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932716Ab0BDAvn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Feb 2010 19:51:43 -0500
Received: by mail-yx0-f189.google.com with SMTP id 27so1717780yxe.4
        for <linux-omap@vger.kernel.org>; Wed, 03 Feb 2010 16:51:43 -0800 (PST)
In-Reply-To: <1265244688-4055-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 346c448..ff849b9 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -191,6 +191,7 @@ static struct omap2_hsmmc_info mmc[] = {
 		.wires		= 4,
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= 63,
+		.power_saving	= true,
 	},
 	{}	/* Terminator */
 };
-- 
1.6.6

