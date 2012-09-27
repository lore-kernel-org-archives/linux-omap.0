From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/6] staging: tidspbridge: remove unnecessary include of
 <plat/clock.h>
Date: Thu, 27 Sep 2012 10:33:31 -0600
Message-ID: <20120927163330.21755.54156.stgit@dusk.lan>
References: <20120927162800.21755.62891.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:46748 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650Ab2I0Qf4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Sep 2012 12:35:56 -0400
In-Reply-To: <20120927162800.21755.62891.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The DSPBridge driver includes arch/arm/plat-omap/include/plat/clock.h.
All of the <plat/ ...> includes are causing problems with the ARM
single image kernel effort.  Remove this one.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 .../tidspbridge/include/dspbridge/host_os.h        |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/tidspbridge/include/dspbridge/host_os.h b/drivers/staging/tidspbridge/include/dspbridge/host_os.h
index ed00d3d..896f157 100644
--- a/drivers/staging/tidspbridge/include/dspbridge/host_os.h
+++ b/drivers/staging/tidspbridge/include/dspbridge/host_os.h
@@ -40,7 +40,6 @@
 #include <linux/vmalloc.h>
 #include <linux/ioport.h>
 #include <linux/platform_device.h>
-#include <plat/clock.h>
 #include <linux/clk.h>
 #include <plat/mailbox.h>
 #include <linux/pagemap.h>


