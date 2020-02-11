From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv6 13/14] remoteproc/omap: report device exceptions and trigger recovery
Date: Tue, 11 Feb 2020 17:21:24 +0200
Message-ID: <20200211152125.23819-14-t-kristo@ti.com>
References: <20200211152125.23819-1-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lelv0142.ext.ti.com ([198.47.23.249]:48688 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730470AbgBKPWM (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 11 Feb 2020 10:22:12 -0500
In-Reply-To: <20200211152125.23819-1-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bjorn.andersson@linaro.org, ohad@wizery.com, linux-remoteproc@vger.kernel.org, afd@ti.com
Cc: linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org, linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>

From: Suman Anna <s-anna@ti.com>

The OMAP remote processors send a special mailbox message
(RP_MBOX_CRASH) when they crash and detect an internal device
exception.

Add support to the mailbox handling function upon detection of
this special message to report this crash to the remoteproc core.
The remoteproc core can trigger a recovery using the prevailing
recovery mechanism, already in use for MMU Fault recovery.

Co-developed-by: Subramaniam Chanderashekarapuram <subramaniam.ca@ti.com>
Signed-off-by: Subramaniam Chanderashekarapuram <subramaniam.ca@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/remoteproc/omap_remoteproc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
index 490a242130f9..2cc87af0c582 100644
--- a/drivers/remoteproc/omap_remoteproc.c
+++ b/drivers/remoteproc/omap_remoteproc.c
@@ -381,8 +381,12 @@ static void omap_rproc_mbox_callback(struct mbox_client *client, void *data)
 
 	switch (msg) {
 	case RP_MBOX_CRASH:
-		/* just log this for now. later, we'll also do recovery */
+		/*
+		 * remoteproc detected an exception, notify the rproc core.
+		 * The remoteproc core will handle the recovery.
+		 */
 		dev_err(dev, "omap rproc %s crashed\n", name);
+		rproc_report_crash(oproc->rproc, RPROC_FATAL_ERROR);
 		break;
 	case RP_MBOX_ECHO_REPLY:
 		dev_info(dev, "received echo reply from %s\n", name);
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
