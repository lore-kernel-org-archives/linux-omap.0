From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH] DSPBRIDGE: slab corruption in resource cleanup fix
Date: Wed, 20 May 2009 11:01:10 -0500
Message-ID: <496565EC904933469F292DDA3F1663E60293106FD4@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45905 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752761AbZETQBU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2009 12:01:20 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>

>From 8c873e2168fdcfd9638b7ccd9c51fb1a6d6b25c2 Mon Sep 17 00:00:00 2001
From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Tue, 19 May 2009 17:45:17 -0500
Subject: [PATCH] DSPBRIDGE: slab corruption in resource cleanup fix

resource cleanup modifying memory already freed was provoking
a Slab corruption fault.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
Sigend-off-by: Ernesto Ramos <ernesto@ti.com>
---
 drivers/dsp/bridge/rmgr/drv.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)
 mode change 100644 => 100755 drivers/dsp/bridge/rmgr/drv.c

diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
old mode 100644
new mode 100755
index 256ce12..4d26c76
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -462,7 +462,6 @@ static DSP_STATUS DRV_ProcFreeNodeRes(HANDLE hPCtxt)
 					status = NODE_Delete(pNodeRes->hNode);
 			}
 		}
-		pNodeRes->nodeAllocated = 0;
 	}
 	return status;
 }
-- 
1.5.6.4
