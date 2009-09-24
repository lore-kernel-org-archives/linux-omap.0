From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 12/12] omap: rng: Use resource_size instead of manual
	calculation
Date: Thu, 24 Sep 2009 16:47:04 -0700
Message-ID: <20090924234704.6065.77419.stgit@localhost>
References: <20090924233027.6065.95725.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58166 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752837AbZIXXrF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Sep 2009 19:47:05 -0400
In-Reply-To: <20090924233027.6065.95725.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tobias Klauser <tklauser@distanz.ch>, linux-omap@vger.kernel.org

From: Tobias Klauser <tklauser@distanz.ch>

Use the resource_size function instead of manually calculating the
resource size. This reduces the chance of introducing off-by-one-errors.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/char/hw_random/omap-rng.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/hw_random/omap-rng.c b/drivers/char/hw_random/omap-rng.c
index 00dd3de..06aad08 100644
--- a/drivers/char/hw_random/omap-rng.c
+++ b/drivers/char/hw_random/omap-rng.c
@@ -116,7 +116,7 @@ static int __devinit omap_rng_probe(struct platform_device *pdev)
 	if (!res)
 		return -ENOENT;
 
-	mem = request_mem_region(res->start, res->end - res->start + 1,
+	mem = request_mem_region(res->start, resource_size(res),
 				 pdev->name);
 	if (mem == NULL) {
 		ret = -EBUSY;
@@ -124,7 +124,7 @@ static int __devinit omap_rng_probe(struct platform_device *pdev)
 	}
 
 	dev_set_drvdata(&pdev->dev, mem);
-	rng_base = ioremap(res->start, res->end - res->start + 1);
+	rng_base = ioremap(res->start, resource_size(res));
 	if (!rng_base) {
 		ret = -ENOMEM;
 		goto err_ioremap;

