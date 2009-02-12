From: "Gupta, Ramesh" <grgupta@ti.com>
Subject: [PATCH 1/1] DSPBRIDGE Fix condition statement for Global Flush
Date: Thu, 12 Feb 2009 17:58:58 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02A40C11FF@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55230 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756304AbZBLM3f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Feb 2009 07:29:35 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n1CCTSeM027667
	for <linux-omap@vger.kernel.org>; Thu, 12 Feb 2009 06:29:34 -0600
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n1CCTRQ5024030
	for <linux-omap@vger.kernel.org>; Thu, 12 Feb 2009 17:59:27 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From c04f200032378b9b56a1ac8e66f80c953f5707a5 Mon Sep 17 00:00:00 2001
From: Ramesh Gupta G <grgupta@ti.com>
Date: Thu, 12 Feb 2009 17:57:21 +0530
Subject: [PATCH 1/1] DSPBRIDGE Fix condition statement for Global Flush

This fixes the condition statement with the original patch
set.

Signed-off-by: Ramesh Gupta G <grgupta@ti.com>
---
 drivers/dsp/bridge/wmd/tiomap3430.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index 23fefcf..b093640 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -1472,7 +1472,8 @@ func_cont:
                WakeDSP(pDevContext, NULL);
                HW_MMU_TLBFlushAll(pDevContext->dwDSPMmuBase);
                CLK_Disable(SERVICESCLK_iva2_ck);
-       }
+       } else
+               HW_MMU_TLBFlushAll(pDevContext->dwDSPMmuBase);
        DBG_Trace(DBG_ENTER, "< WMD_BRD_MemMap status %x\n", status);
        return status;
 }
--
1.5.3.2