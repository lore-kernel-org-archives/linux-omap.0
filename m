From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH] ASoC: davinci-evm: drop un-necessary remove function
Date: Thu, 26 Mar 2015 15:38:25 +0200
Message-ID: <1427377105-29044-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37588 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751807AbbCZNio (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Mar 2015 09:38:44 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, Manish Badarkhe <manishvb@ti.com>, Jyri Sarha <jsarha@ti.com>

From: Manish Badarkhe <manishvb@ti.com>

As davinci card gets registered using 'devm_' api
there is no need to unregister the card in 'remove'
function.
Hence drop the 'remove' function.

Signed-off-by: Manish Badarkhe <manishvb@ti.com>
Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 sound/soc/davinci/davinci-evm.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index b6bb594..8c2b9be 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -425,18 +425,8 @@ static int davinci_evm_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int davinci_evm_remove(struct platform_device *pdev)
-{
-	struct snd_soc_card *card = platform_get_drvdata(pdev);
-
-	snd_soc_unregister_card(card);
-
-	return 0;
-}
-
 static struct platform_driver davinci_evm_driver = {
 	.probe		= davinci_evm_probe,
-	.remove		= davinci_evm_remove,
 	.driver		= {
 		.name	= "davinci_evm",
 		.pm	= &snd_soc_pm_ops,
-- 
1.9.1

