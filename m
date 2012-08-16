From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 1/3] mfd: twl6040: Fix GPO mask
Date: Thu, 16 Aug 2012 15:13:13 +0300
Message-ID: <1345119195-7490-2-git-send-email-peter.ujfalusi@ti.com>
References: <1345119195-7490-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:37043 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753855Ab2HPMNE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Aug 2012 08:13:04 -0400
Received: by obhx4 with SMTP id x4so4181239obh.0
        for <linux-omap@vger.kernel.org>; Thu, 16 Aug 2012 05:13:03 -0700 (PDT)
In-Reply-To: <1345119195-7490-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, peter.ujfalusi@ti.com

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/linux/mfd/twl6040.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/mfd/twl6040.h b/include/linux/mfd/twl6040.h
index eaad49f..269b706 100644
--- a/include/linux/mfd/twl6040.h
+++ b/include/linux/mfd/twl6040.h
@@ -143,7 +143,7 @@
 
 #define TWL6040_GPO1			0x01
 #define TWL6040_GPO2			0x02
-#define TWL6040_GPO3			0x03
+#define TWL6040_GPO3			0x04
 
 /* ACCCTL (0x2D) fields */
 
-- 
1.7.8.6

