From: Sergio Aguirre <saaguirre@ti.com>
Subject: [PATCH v3 01/10] mfd: twl6040: Fix wrong TWL6040_GPO3 bitfield value
Date: Wed,  2 May 2012 10:15:40 -0500
Message-ID: <1335971749-21258-2-git-send-email-saaguirre@ti.com>
References: <1335971749-21258-1-git-send-email-saaguirre@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:49982 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754281Ab2EBPQE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 May 2012 11:16:04 -0400
Received: by obceq6 with SMTP id eq6so1538352obc.37
        for <linux-omap@vger.kernel.org>; Wed, 02 May 2012 08:16:01 -0700 (PDT)
In-Reply-To: <1335971749-21258-1-git-send-email-saaguirre@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-media@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Sergio Aguirre <saaguirre@ti.com>

The define should be the result of 1 << Bit number.

Bit number for GPOCTL.GPO3 field is 2, which results
in 0x4 value.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 include/linux/mfd/twl6040.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/mfd/twl6040.h b/include/linux/mfd/twl6040.h
index b15b5f0..df86c14 100644
--- a/include/linux/mfd/twl6040.h
+++ b/include/linux/mfd/twl6040.h
@@ -142,7 +142,7 @@
 
 #define TWL6040_GPO1			0x01
 #define TWL6040_GPO2			0x02
-#define TWL6040_GPO3			0x03
+#define TWL6040_GPO3			0x04
 
 /* ACCCTL (0x2D) fields */
 
-- 
1.7.5.4

