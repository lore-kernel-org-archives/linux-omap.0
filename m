From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 1/3] DSPBRIDGE: fix checkpatch error introduced with mailbox patches
Date: Tue, 23 Mar 2010 16:48:28 -0600
Message-ID: <1269384510-1526-2-git-send-email-omar.ramirez@ti.com>
References: <1269384510-1526-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58458 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753677Ab0CWWdJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Mar 2010 18:33:09 -0400
In-Reply-To: <1269384510-1526-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, Ameya Palande <ameya.palande@nokia.com>, Guzman Lugo Fernando <x0095840@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

This fixes:
ERROR: "foo* bar" should be "foo *bar"
218: FILE: drivers/dsp/bridge/wmd/_tiomap.h:374:
+dsp_status sm_interrupt_dsp(struct wmd_dev_context* dev_context, u16 mb_val);

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/wmd/_tiomap.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/_tiomap.h b/drivers/dsp/bridge/wmd/_tiomap.h
index 7a884f4..e853777 100644
--- a/drivers/dsp/bridge/wmd/_tiomap.h
+++ b/drivers/dsp/bridge/wmd/_tiomap.h
@@ -371,6 +371,6 @@ extern dsp_status wmd_tlb_dsp_va_to_mpu_pa(struct wmd_dev_context *dev_context,
  *  Requires:
  *  Ensures:
  */
-dsp_status sm_interrupt_dsp(struct wmd_dev_context* dev_context, u16 mb_val);
+dsp_status sm_interrupt_dsp(struct wmd_dev_context *dev_context, u16 mb_val);
 
 #endif /* _TIOMAP_ */
-- 
1.6.2.4

