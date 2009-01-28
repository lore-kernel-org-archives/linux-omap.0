From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/9] ARM: OMAP: DMA: Fix uninitialized channel flags
Date: Wed, 28 Jan 2009 10:26:58 -0800
Message-ID: <20090128182658.21007.3757.stgit@localhost>
References: <20090128181931.21007.73744.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:57378 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbZA1S1D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jan 2009 13:27:03 -0500
In-Reply-To: <20090128181931.21007.73744.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@nokia.com>

From: Jarkko Nikula <jarkko.nikula@nokia.com>

This has similar symptoms than 66c23551b1b774e2be3c7bdf91c0ebf2c7a3519e
where just omap_request_dma, omap_dma_link_lch and omap_dma_unlink_lch
can cause incorrect dump_stack(). Here it can happen if channel has been
used before and the channel flags variable holds old status.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/dma.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index bec8e36..47ec77a 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -709,6 +709,7 @@ int omap_request_dma(int dev_id, const char *dev_name,
 	chan->dev_name = dev_name;
 	chan->callback = callback;
 	chan->data = data;
+	chan->flags = 0;
 
 #ifndef CONFIG_ARCH_OMAP1
 	if (cpu_class_is_omap2()) {

