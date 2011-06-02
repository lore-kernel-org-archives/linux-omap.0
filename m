From: Dmitry Kasatkin <dmitry.s.kasatkin@gmail.com>
Subject: [PATCH 10/11] omap-sham: clear device flags when finishing request
Date: Thu,  2 Jun 2011 21:10:12 +0300
Message-ID: <da998a599e8ccd2a231967afc8052d1fe9463de7.1306926921.git.dmitry.kasatkin@gmail.com>
References: <cover.1306926921.git.dmitry.kasatkin@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:48908 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754013Ab1FBSKp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Jun 2011 14:10:45 -0400
In-Reply-To: <cover.1306926921.git.dmitry.kasatkin@gmail.com>
In-Reply-To: <cover.1306926921.git.dmitry.kasatkin@gmail.com>
References: <cover.1306926921.git.dmitry.kasatkin@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: herbert@gondor.hengli.com.au
Cc: linux-crypto@vger.kernel.org, linux-omap@vger.kernel.org, Dmitry Kasatkin <dmitry.kasatkin@nokia.com>

From: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>

Signed-off-by: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>
---
 drivers/crypto/omap-sham.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index 7ca7075..804c16b 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -650,8 +650,10 @@ static void omap_sham_finish_req(struct ahash_request *req, int err)
 		ctx->flags |= BIT(FLAGS_ERROR);
 	}
 
+	/* atomic operation is not needed here */
+	dd->flags &= ~(BIT(FLAGS_BUSY) | BIT(FLAGS_FINAL) | BIT(FLAGS_CPU) |
+			BIT(FLAGS_DMA_READY) | BIT(FLAGS_OUTPUT_READY));
 	clk_disable(dd->iclk);
-	dd->flags &= ~BIT(FLAGS_BUSY);
 
 	if (req->base.complete)
 		req->base.complete(&req->base, err);
-- 
1.7.4.1

