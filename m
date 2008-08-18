From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH] ARM: OMAP: DMA: Fix uninitialized channel flags
Date: Mon, 18 Aug 2008 12:28:22 +0300
Message-ID: <1219051702-25944-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:55727 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792AbYHRJxK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Aug 2008 05:53:10 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m7I9qdMQ018486
	for <linux-omap@vger.kernel.org>; Mon, 18 Aug 2008 04:53:08 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>

This has similar symptoms than 66c23551b1b774e2be3c7bdf91c0ebf2c7a3519e
where just omap_request_dma, omap_dma_link_lch and omap_dma_unlink_lch
can cause incorrect dump_stack(). Here it can happen if channel has been
used before and the channel flags variable holds old status.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 arch/arm/plat-omap/dma.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index a63b644..1c6b905 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -712,6 +712,7 @@ int omap_request_dma(int dev_id, const char *dev_name,
 	chan->dev_name = dev_name;
 	chan->callback = callback;
 	chan->data = data;
+	chan->flags = 0;
 
 #ifndef CONFIG_ARCH_OMAP1
 	if (cpu_class_is_omap2()) {
-- 
1.5.6.3

