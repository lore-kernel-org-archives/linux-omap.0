From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCH] DSPBRIDGE: Removal of unreachable code
Date: Thu, 21 May 2009 12:25:10 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602931073D0@dlee06.ent.ti.com>
References: <1242731876-16119-1-git-send-email-ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33319 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752836AbZEURZV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 May 2009 13:25:21 -0400
In-Reply-To: <1242731876-16119-1-git-send-email-ameya.palande@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



Hi Ameya,

	The patch is ok. I think this was introduced by error in a patch.

Regards,
Fernando.

-----Original Message-----
From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Ameya Palande
Sent: Tuesday, May 19, 2009 6:18 AM
To: linux-omap@vger.kernel.org
Subject: [PATCH] DSPBRIDGE: Removal of unreachable code

From: Ameya Palande <ameya.palande@nokia.com>

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 drivers/dsp/bridge/wmd/io_sm.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 8d106e1..6f7e338 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -1742,9 +1742,6 @@ DSP_STATUS IO_SHMsetting(IN struct IO_MGR *hIOMgr, IN enum SHM_DESCTYPE desc,
 		break;
 	default:
 		break;
-
-				queue_work(bridge_workqueue,
-							 &(hIOMgr->io_workq));
 	}
 #endif
 	return DSP_SOK;
-- 
1.6.2.4

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

