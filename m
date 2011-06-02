From: Dmitry Kasatkin <dmitry.s.kasatkin@gmail.com>
Subject: [PATCH 01/11] omap-sham: remove extra reference
Date: Thu,  2 Jun 2011 21:10:03 +0300
Message-ID: <52fd01bd74e867ad0d8b7ef59f32e52adec5abaa.1306926921.git.dmitry.kasatkin@gmail.com>
References: <cover.1306926921.git.dmitry.kasatkin@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:58398 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753841Ab1FBSKa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Jun 2011 14:10:30 -0400
In-Reply-To: <cover.1306926921.git.dmitry.kasatkin@gmail.com>
In-Reply-To: <cover.1306926921.git.dmitry.kasatkin@gmail.com>
References: <cover.1306926921.git.dmitry.kasatkin@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: herbert@gondor.hengli.com.au
Cc: linux-crypto@vger.kernel.org, linux-omap@vger.kernel.org, Dmitry Kasatkin <dmitry.kasatkin@nokia.com>

From: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>

Request pointer is already available in the function.

Signed-off-by: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>
---
 drivers/crypto/omap-sham.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index ba8f1ea..8a45fb7 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -639,7 +639,7 @@ static void omap_sham_finish_req(struct ahash_request *req, int err)
 	struct omap_sham_dev *dd = ctx->dd;
 
 	if (!err) {
-		omap_sham_copy_hash(ctx->dd->req, 1);
+		omap_sham_copy_hash(req, 1);
 		if (ctx->flags & FLAGS_FINAL)
 			err = omap_sham_finish(req);
 	} else {
-- 
1.7.4.1

