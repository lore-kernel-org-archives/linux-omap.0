From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 06/11] gpio/omap: add clk_prepare and clk_unprepare
Date: Fri, 22 Jun 2012 19:18:05 +0530
Message-ID: <1340372890-10091-7-git-send-email-rnayak@ti.com>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36859 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762179Ab2FVNsb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Jun 2012 09:48:31 -0400
In-Reply-To: <1340372890-10091-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, mturquette@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Grant Likely <grant.likely@secretlab.ca>

In preparation of OMAP moving to Common Clk Framework(CCF) add clk_prepare()
for omap gpio debounce clock.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 drivers/gpio/gpio-omap.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index c4ed172..6a73b01 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -893,6 +893,8 @@ static int gpio_debounce(struct gpio_chip *chip, unsigned offset,
 		bank->dbck = clk_get(bank->dev, "dbclk");
 		if (IS_ERR(bank->dbck))
 			dev_err(bank->dev, "Could not get gpio dbck\n");
+		else
+			clk_prepare(bank->dbck);
 	}
 
 	spin_lock_irqsave(&bank->lock, flags);
-- 
1.7.1

