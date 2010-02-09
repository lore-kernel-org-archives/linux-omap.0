From: "Ramos Falcon, Ernesto" <ernesto@ti.com>
Subject: [PATCH] DSPBRIDGE: Add BRD_SLEEP_TRANSITION in PROC_GetState
Date: Tue, 9 Feb 2010 13:19:52 -0600
Message-ID: <B852767254C5C94EBB1040EE0EFA06008C89EB85@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54066 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750942Ab0BITT6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Feb 2010 14:19:58 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, "Contreras Felipe (Nokia-D/Helsinki)" <felipe.contreras@nokia.com>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>

>From 40d5863c3d3f4091761fef8bff581d2a7b1f32fa Mon Sep 17 00:00:00 2001
From: Ernesto Ramos <ernesto@ti.com>
Date: Tue, 2 Feb 2010 20:30:19 -0600
Subject: [PATCH] DSPBRIDGE: Add BRD_SLEEP_TRANSITION in PROC_GetState.

When PROC_GetState checks for BRD status it is not taking into account
the state BRD_SLEEP_TRANSITION and it is returning DSP_EFAIL when this
happens, which is wrong. This fix adds this check to return ProcStatus as
PROC_RUNNING and status DSP_SOK when this happens.

Signed-off-by: Ernesto Ramos <ernesto@ti.com>
---
 drivers/dsp/bridge/rmgr/proc.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index a1d06dc..553c9a7 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -802,6 +802,7 @@ DSP_STATUS PROC_GetState(DSP_HPROCESSOR hProcessor,
 		case BRD_STOPPED:
 			pProcStatus->iState = PROC_STOPPED;
 			break;
+		case BRD_SLEEP_TRANSITION:
 		case BRD_DSP_HIBERNATION:
 			/* Fall through */
 		case BRD_RUNNING:
-- 
1.5.4.5

