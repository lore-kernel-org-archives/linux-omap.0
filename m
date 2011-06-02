From: Dmitry Kasatkin <dmitry.s.kasatkin@gmail.com>
Subject: [PATCH 06/11] omap-sham: remove unnecessary local variable
Date: Thu,  2 Jun 2011 21:10:08 +0300
Message-ID: <34981be4c02475c2e77401d27b6b6951adf6ec6d.1306926921.git.dmitry.kasatkin@gmail.com>
References: <cover.1306926921.git.dmitry.kasatkin@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:59166 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753841Ab1FBSKi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Jun 2011 14:10:38 -0400
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
 drivers/crypto/omap-sham.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index b959dc6..84e5890 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -1033,7 +1033,6 @@ static struct ahash_alg algs[] = {
 static void omap_sham_done_task(unsigned long data)
 {
 	struct omap_sham_dev *dd = (struct omap_sham_dev *)data;
-	struct ahash_request *req = dd->req;
 	int ready = 0, err = 0;
 
 	if (test_and_clear_bit(FLAGS_OUTPUT_READY, &dd->flags))
@@ -1050,7 +1049,7 @@ static void omap_sham_done_task(unsigned long data)
 	if (err != -EINPROGRESS && (ready || err)) {
 		dev_dbg(dd->dev, "update done: err: %d\n", err);
 		/* finish curent request */
-		omap_sham_finish_req(req, err);
+		omap_sham_finish_req(dd->req, err);
 		/* start new request */
 		omap_sham_handle_queue(dd, NULL);
 	}
-- 
1.7.4.1

