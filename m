From: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Subject: [PATCH] MMC: OMAP: Disable smartidle mode while suspending (workaround)
Date: Mon, 18 Aug 2008 18:13:16 +0300
Message-ID: <1219072400-7814-3-git-send-email-jarkko.lavinen@nokia.com>
References: <1219072400-7814-1-git-send-email-jarkko.lavinen@nokia.com>
 <1219072400-7814-2-git-send-email-jarkko.lavinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:55419 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885AbYHRPRI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Aug 2008 11:17:08 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m7IFGBkc015871
	for <linux-omap@vger.kernel.org>; Mon, 18 Aug 2008 10:17:06 -0500
In-Reply-To: <1219072400-7814-2-git-send-email-jarkko.lavinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: =?utf-8?q?H=C3=B6gander=20Jouni?= <jouni.hogander@nokia.com>, Jarkko Lavinen <jarkko.lavinen@nokia.com>

=46rom: H=C3=B6gander Jouni <jouni.hogander@nokia.com>

=46or some reason mmc doesn't ack idle request if smartidle mode is use=
d. This is just workaround. There is something wrong in driver code or =
in hw(omap).

Signed-off-by: Jouni H=C3=B6gander <jouni.hogander@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmm=
c.c
index 9462e4c..e361213 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -58,6 +58,7 @@
 #define SDVSCLR			0xFFFFF1FF
 #define SDVSDET			0x00000400
 #define AUTOIDLE		0x1
+#define SMARTIDLE		(2 << 3)
 #define SDBP			(1<<8)
 #define DTO			0xe
 #define ICE			0x1
@@ -980,6 +981,11 @@ static int omap_mmc_suspend(struct platform_device=
 *pdev, pm_message_t state)
 					| SDBP);
 			}
=20
+			/* XXX Disable smartidle mode. For some reason
+			 * this is preventing core retention */
+			OMAP_HSMMC_WRITE(host->base, SYSCONFIG,
+					 OMAP_HSMMC_READ(host->base, SYSCONFIG) & ~SMARTIDLE);
+
 			clk_disable(host->fclk);
 			clk_disable(host->iclk);
 			clk_disable(host->dbclk);
@@ -1015,6 +1021,11 @@ static int omap_mmc_resume(struct platform_devic=
e *pdev)
 			dev_dbg(mmc_dev(host->mmc),
 					"Enabling debounce clk failed\n");
=20
+		/* XXX Enable smartidle mode. For some reason
+		 * this is preventing core retention */
+		OMAP_HSMMC_WRITE(host->base, SYSCONFIG,
+				 OMAP_HSMMC_READ(host->base, SYSCONFIG) | SMARTIDLE);
+
 		if (host->pdata->resume) {
 			ret =3D host->pdata->resume(&pdev->dev, host->slot_id);
 			if (ret)
--=20
1.5.6.3

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
