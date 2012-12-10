From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 6/9] memory: emif: debugfs: Remove MR4= string print
Date: Mon, 10 Dec 2012 12:39:15 +0530
Message-ID: <1355123358-5273-7-git-send-email-lokeshvutla@ti.com>
References: <1355123358-5273-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54894 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752174Ab2LJHJ3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Dec 2012 02:09:29 -0500
In-Reply-To: <1355123358-5273-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, gregkh@linuxfoundation.org, b-cousson@ti.com, lokeshvutla@ti.com, Severine Glock <s-glock@ti.com>

From: Severine Glock <s-glock@ti.com>

MR4 is reported under debugfs with following format MR4=%d.
Remove MR4= string for better convenience.

Signed-off-by: Severine Glock <s-glock@ti.com>
---
 drivers/memory/emif.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/emif.c b/drivers/memory/emif.c
index 625732d..32ce601 100644
--- a/drivers/memory/emif.c
+++ b/drivers/memory/emif.c
@@ -147,7 +147,7 @@ static int emif_mr4_show(struct seq_file *s, void *unused)
 {
 	struct emif_data *emif = s->private;
 
-	seq_printf(s, "MR4=%d\n", emif->temperature_level);
+	seq_printf(s, "%d\n", emif->temperature_level);
 	return 0;
 }
 
-- 
1.7.9.5

