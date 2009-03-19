From: "Gupta, Ramesh" <grgupta@ti.com>
Subject: [PATCH 1/1] DSPBRIDGE Fix flush_workque
Date: Thu, 19 Mar 2009 09:55:06 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02A91ACA75@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40606 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751423AbZCSE0E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Mar 2009 00:26:04 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2J4PsCd011461
	for <linux-omap@vger.kernel.org>; Wed, 18 Mar 2009 23:26:00 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Menon, Nishanth" <nm@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Varide, Nischal" <nischal.varide@ti.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>

>From a8aabc6233329998d0ac62be42ade5a77f03ef2a Mon Sep 17 00:00:00 2001
From: Ramesh Gupta <x0023949@ti.com>
Date: Thu, 19 Mar 2009 09:56:30 +0530
Subject: [PATCH 1/1] DSPBRIDGE Fix flush_workque

Observed some crash with flush_workque after 
multiple load and unload.
Replaced flush_workque with destroy_workque

Signed-off-by: Varide Nischal <x0102224@ti.com>
---
 drivers/dsp/bridge/wmd/io_sm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 0eb9893..ea802d0 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -391,7 +391,7 @@ DSP_STATUS WMD_IO_Destroy(struct IO_MGR *hIOMgr)
                       &hWmdContext)))
                                DBC_Assert(hWmdContext);
                (void)CHNLSM_DisableInterrupt(hWmdContext);
-               flush_workqueue(bridge_workqueue);
+               destroy_workqueue(bridge_workqueue);
                /* Linux function to uninstall ISR */
                free_irq(INT_MAIL_MPU_IRQ, (void *)hIOMgr);
                (void)DPC_Destroy(hIOMgr->hDPC);
-- 
1.5.3.2
