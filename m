From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/8] omap: Use resource_size
Date: Tue, 10 Nov 2009 19:00:45 -0800
Message-ID: <20091111030045.31793.89110.stgit@localhost>
References: <20091111025907.31793.84134.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:64858 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753253AbZKKDAl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Nov 2009 22:00:41 -0500
In-Reply-To: <20091111025907.31793.84134.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tobias Klauser <tklauser@distanz.ch>, linux-omap@vger.kernel.org

From: Tobias Klauser <tklauser@distanz.ch>

Use the resource_size function instead of manually calculating the
resource size. This reduces the chance of introducing off-by-one errors
and actually fixes one in mailbox.c.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/gpmc.c    |    2 +-
 arch/arm/mach-omap2/mailbox.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 1587682..f865756 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -366,7 +366,7 @@ int gpmc_cs_request(int cs, unsigned long size, unsigned long *base)
 	if (r < 0)
 		goto out;
 
-	gpmc_cs_enable_mem(cs, res->start, res->end - res->start + 1);
+	gpmc_cs_enable_mem(cs, res->start, resource_size(res));
 	*base = res->start;
 	gpmc_cs_set_reserved(cs, 1);
 out:
diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index c035ad3..ef57b38 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -300,7 +300,7 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "invalid mem resource\n");
 		return -ENODEV;
 	}
-	mbox_base = ioremap(res->start, res->end - res->start);
+	mbox_base = ioremap(res->start, resource_size(res));
 	if (!mbox_base)
 		return -ENOMEM;
 

