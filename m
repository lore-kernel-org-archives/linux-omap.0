From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 08/14] omap: mailbox: remove unecessary fields
Date: Sat, 22 May 2010 20:14:19 +0300
Message-ID: <1274548465-20208-9-git-send-email-felipe.contreras@gmail.com>
References: <1274548465-20208-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57665 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755880Ab0EVROu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 22 May 2010 13:14:50 -0400
Received: by mail-bw0-f46.google.com with SMTP id 7so383738bwz.19
        for <linux-omap@vger.kernel.org>; Sat, 22 May 2010 10:14:49 -0700 (PDT)
In-Reply-To: <1274548465-20208-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Tony Lindgren <tony@atomide.com>, Felipe Contreras <felipe.contreras@gmail.com>

Nobody is using them.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/plat-omap/include/plat/mailbox.h |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/mailbox.h b/arch/arm/plat-omap/include/plat/mailbox.h
index 0c3c4a5..aad8bf8 100644
--- a/arch/arm/plat-omap/include/plat/mailbox.h
+++ b/arch/arm/plat-omap/include/plat/mailbox.h
@@ -52,19 +52,11 @@ struct omap_mbox_queue {
 struct omap_mbox {
 	char			*name;
 	unsigned int		irq;
-
 	struct omap_mbox_queue	*txq, *rxq;
-
 	struct omap_mbox_ops	*ops;
-
-	mbox_msg_t		seq_snd, seq_rcv;
-
 	struct device		*dev;
-
 	struct omap_mbox	*next;
 	void			*priv;
-
-	void			(*err_notify)(void);
 };
 
 int omap_mbox_msg_send(struct omap_mbox *, mbox_msg_t msg);
-- 
1.7.1

