From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCHv2 2/3] OMAP: McBSP: Swap CLKS source definition
Date: Wed,  6 Oct 2010 08:50:41 +0300
Message-ID: <1286344242-430-3-git-send-email-jhnikula@gmail.com>
References: <1286344242-430-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:64717 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754007Ab0JFFuX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Oct 2010 01:50:23 -0400
Received: by mail-ew0-f46.google.com with SMTP id 23so2731852ewy.19
        for <linux-omap@vger.kernel.org>; Tue, 05 Oct 2010 22:50:23 -0700 (PDT)
In-Reply-To: <1286344242-430-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org, Jarkko Nikula <jhnikula@gmail.com>

This is just a readability and debugging improvement. As selection bit in
DEVCONF register is cleared when using 96 MHz PRCM source and set when using
external CLKS pin, change definitions to be sync with these.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Acked-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/include/plat/mcbsp.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index 4da6f94..e19abf2 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -321,8 +321,8 @@
 #define FSR_SRC_FSX		1
 
 /* McBSP functional clock sources */
-#define MCBSP_CLKS_PAD_SRC	0
-#define MCBSP_CLKS_PRCM_SRC	1
+#define MCBSP_CLKS_PRCM_SRC	0
+#define MCBSP_CLKS_PAD_SRC	1
 
 /* we don't do multichannel for now */
 struct omap_mcbsp_reg_cfg {
-- 
1.7.1

