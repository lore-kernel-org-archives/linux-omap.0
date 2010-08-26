From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH 11/11] TWL4030: Codec: Fix fucntion declaration error
Date: Fri, 27 Aug 2010 02:26:49 +0530
Message-ID: <1282856209-15645-12-git-send-email-manjugk@ti.com>
References: <1282856209-15645-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41803 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753103Ab0HZU60 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Aug 2010 16:58:26 -0400
In-Reply-To: <1282856209-15645-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Manjunatha GK <manjugk@ti.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>

From: Manjunatha GK <manjugk@ti.com>

Fixes sparse warning for the below error

drivers/mfd/twl4030-codec.c:118:5: error: symbol 'twl4030_codec_disable_resource'
redeclared with different type (originally declared at include/linux/mfd/twl4030-
codec.h:268) - incompatible argument 1 (different signedness)

Signed-off-by: Manjunatha GK <manjugk@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>
---
 include/linux/mfd/twl4030-codec.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/mfd/twl4030-codec.h b/include/linux/mfd/twl4030-codec.h
index 2ec317c..0f7300e 100644
--- a/include/linux/mfd/twl4030-codec.h
+++ b/include/linux/mfd/twl4030-codec.h
@@ -265,7 +265,7 @@ enum twl4030_codec_res {
 	TWL4030_CODEC_RES_MAX,
 };
 
-int twl4030_codec_disable_resource(enum twl4030_codec_res id);
+int twl4030_codec_disable_resource(unsigned id);
 int twl4030_codec_enable_resource(enum twl4030_codec_res id);
 unsigned int twl4030_codec_get_mclk(void);
 
-- 
1.7.0.4

