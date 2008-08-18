From: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Subject: [PATCH] OMAP: HSMMC: Check wether board specific suspend / resume exists
Date: Mon, 18 Aug 2008 18:13:15 +0300
Message-ID: <1219072400-7814-2-git-send-email-jarkko.lavinen@nokia.com>
References: <1219072400-7814-1-git-send-email-jarkko.lavinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:55333 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984AbYHRPQ3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Aug 2008 11:16:29 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m7IFGBkG015871
	for <linux-omap@vger.kernel.org>; Mon, 18 Aug 2008 10:16:27 -0500
In-Reply-To: <1219072400-7814-1-git-send-email-jarkko.lavinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: =?utf-8?q?H=C3=B6gander=20Jouni?= <jouni.hogander@nokia.com>, Jarkko Lavinen <jarkko.lavinen@nokia.com>

=46rom: H=C3=B6gander Jouni <jouni.hogander@nokia.com>

Do not try to call board specific suspend / resume functions if there
is no such.

Signed-off-by: Jouni H=C3=B6gander <jouni.hogander@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmm=
c.c
index af34871..9462e4c 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -960,11 +960,13 @@ static int omap_mmc_suspend(struct platform_devic=
e *pdev, pm_message_t state)
 			OMAP_HSMMC_WRITE(host->base, ISE, 0);
 			OMAP_HSMMC_WRITE(host->base, IE, 0);
=20
-			ret =3D host->pdata->suspend(&pdev->dev, host->slot_id);
-			if (ret)
-				dev_dbg(mmc_dev(host->mmc),
-					"Unable to handle MMC board"
-					" level suspend\n");
+			if (host->pdata->suspend) {
+				ret =3D host->pdata->suspend(&pdev->dev, host->slot_id);
+				if (ret)
+					dev_dbg(mmc_dev(host->mmc),
+						"Unable to handle MMC board"
+						" level suspend\n");
+			}
=20
 			if (!(OMAP_HSMMC_READ(host->base, HCTL) & SDVSDET)) {
 				OMAP_HSMMC_WRITE(host->base, HCTL,
@@ -1013,10 +1015,12 @@ static int omap_mmc_resume(struct platform_devi=
ce *pdev)
 			dev_dbg(mmc_dev(host->mmc),
 					"Enabling debounce clk failed\n");
=20
-		ret =3D host->pdata->resume(&pdev->dev, host->slot_id);
-		if (ret)
-			dev_dbg(mmc_dev(host->mmc),
+		if (host->pdata->resume) {
+			ret =3D host->pdata->resume(&pdev->dev, host->slot_id);
+			if (ret)
+				dev_dbg(mmc_dev(host->mmc),
 					"Unmask interrupt failed\n");
+		}
=20
 		/* Notify the core to resume the host */
 		ret =3D mmc_resume_host(host->mmc);
--=20
1.5.6.3

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
