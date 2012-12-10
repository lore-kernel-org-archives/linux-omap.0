From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 1/9] memory: emif: Correct the lpmode timeout calculation
Date: Mon, 10 Dec 2012 12:39:10 +0530
Message-ID: <1355123358-5273-2-git-send-email-lokeshvutla@ti.com>
References: <1355123358-5273-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45115 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752174Ab2LJHJb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Dec 2012 02:09:31 -0500
In-Reply-To: <1355123358-5273-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, gregkh@linuxfoundation.org, b-cousson@ti.com, lokeshvutla@ti.com

The driver tries to round up the specified timeout cycles to
next power of 2 value. But this is done wrongly.
Correcting this here.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 drivers/memory/emif.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/emif.c b/drivers/memory/emif.c
index 06d31c9..8589aba 100644
--- a/drivers/memory/emif.c
+++ b/drivers/memory/emif.c
@@ -731,9 +731,9 @@ static u32 get_pwr_mgmt_ctrl(u32 freq, struct emif_data *emif, u32 ip_rev)
 	if (timeout < 16) {
 		timeout = 0;
 	} else {
-		timeout = __fls(timeout) - 3;
 		if (timeout & (timeout - 1))
-			timeout++;
+			timeout <<= 1;
+		timeout = __fls(timeout) - 3;
 	}
 
 	switch (lpmode) {
-- 
1.7.9.5

