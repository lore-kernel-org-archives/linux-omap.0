From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 14/23] USB: MUSB: checkpatch.pl fixes to musb_virthub.c
Date: Fri, 11 Apr 2008 11:28:27 +0300
Message-ID: <1207902516-6374-15-git-send-email-felipe.balbi@nokia.com>
References: <1207902516-6374-1-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-2-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-3-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-4-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-5-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-6-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-7-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-8-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-9-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-10-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-11-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-12-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-13-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-14-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:26604 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757392AbYDKIaM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Apr 2008 04:30:12 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3B8TpF8021901
	for <linux-omap@vger.kernel.org>; Fri, 11 Apr 2008 11:30:09 +0300
In-Reply-To: <1207902516-6374-14-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

Misc cleanup patch.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/musb_virthub.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/musb_virthub.c b/drivers/usb/musb/musb_virthub.c
index 10b9089..e0e9ce5 100644
--- a/drivers/usb/musb/musb_virthub.c
+++ b/drivers/usb/musb/musb_virthub.c
@@ -299,7 +299,7 @@ int musb_hub_control(
 		break;
 	case GetHubStatus:
 		temp = 0;
-		*(__le32 *) buf = cpu_to_le32 (temp);
+		*(__le32 *) buf = cpu_to_le32(temp);
 		break;
 	case GetPortStatus:
 		if (wIndex != 1)
@@ -340,7 +340,7 @@ int musb_hub_control(
 				(__le32 *) buf);
 
 		/* port change status is more interesting */
-		DBG(get_unaligned((u16*)(buf+2)) ? 2 : 5, "port status %08x\n",
+		DBG(get_unaligned((u16 *)(buf+2)) ? 2 : 5, "port status %08x\n",
 				musb->port1_status);
 		break;
 	case SetPortFeature:
-- 
1.5.5.23.g2a5fe

