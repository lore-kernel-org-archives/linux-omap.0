From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 02/15] cbus: retu: replace BUG_ON with WARN
Date: Tue, 15 Feb 2011 10:45:49 +0200
Message-ID: <1297759562-25682-3-git-send-email-balbi@ti.com>
References: <1297759562-25682-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:35162 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751178Ab1BOIqY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Feb 2011 03:46:24 -0500
Received: by mail-gw0-f50.google.com with SMTP id a20so2689575gwa.37
        for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 00:46:24 -0800 (PST)
In-Reply-To: <1297759562-25682-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

Instead of breaking the entire thing, just
WARN() about it.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/retu.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
index 5886b00..032864a 100644
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -82,7 +82,7 @@ static struct retu *the_retu;
  */
 int retu_read_reg(unsigned reg)
 {
-	BUG_ON(!the_retu);
+	WARN(!the_retu, "Retu not initialized\n");
 	return cbus_read_reg(RETU_ID, reg);
 }
 EXPORT_SYMBOL(retu_read_reg);
@@ -96,7 +96,7 @@ EXPORT_SYMBOL(retu_read_reg);
  */
 void retu_write_reg(unsigned reg, u16 val)
 {
-	BUG_ON(!the_retu);
+	WARN(!the_retu, "Retu not initialized\n");
 	cbus_write_reg(RETU_ID, reg, val);
 }
 EXPORT_SYMBOL(retu_write_reg);
-- 
1.7.4.rc2

