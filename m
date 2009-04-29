From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: [PATCH] OMAP OneNAND: add missing __devexit_p wrappers
Date: Wed, 29 Apr 2009 16:15:23 +0300
Message-ID: <49F852EB.1080701@nokia.com>
References: <7948530904290459q36d9c3fcq2db0dedcf88549d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060606050107020605040104"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:26839 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760652AbZD2NOk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Apr 2009 09:14:40 -0400
In-Reply-To: <7948530904290459q36d9c3fcq2db0dedcf88549d2@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mika Korhonen <mika.j.korhonen@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, linux-mtd Mailing List <linux-mtd@lists.infradead.org>

This is a multi-part message in MIME format.
--------------060606050107020605040104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Mika Korhonen wrote:
> The patch follows as attachment as gmail damages whitespaces and
> git-send-mail is right now out of question.

This goes via MTD mailing list.


--------------060606050107020605040104
Content-Type: text/x-diff;
 name="0001-OMAP-OneNAND-add-missing-__devexit_p-wrappers.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-OMAP-OneNAND-add-missing-__devexit_p-wrappers.patch"

>From b72b537ff229a8d62540569bc543c419702ecb05 Mon Sep 17 00:00:00 2001
From: Mika Korhonen <mika.j.korhonen@gmail.com>
Date: Wed, 29 Apr 2009 14:10:34 +0300
Subject: [PATCH] OMAP OneNAND: add missing __devexit_p wrappers

Fixes build in configurations where devexit functions get discarded

Signed-off-by: Mika Korhonen <mika.j.korhonen@gmail.com>
---
 drivers/mtd/onenand/omap2.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
index f2e9de1..4882935 100644
--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -778,8 +778,8 @@ static int __devexit omap2_onenand_remove(struct platform_device *pdev)
 
 static struct platform_driver omap2_onenand_driver = {
 	.probe		= omap2_onenand_probe,
-	.remove		= omap2_onenand_remove,
-	.shutdown	= omap2_onenand_shutdown,
+	.remove		= __devexit_p(omap2_onenand_remove),
+	.shutdown	= __devexit_p(omap2_onenand_shutdown),
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.owner  = THIS_MODULE,
-- 
1.5.6.5


--------------060606050107020605040104--
