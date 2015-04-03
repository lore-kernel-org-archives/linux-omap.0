From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 13/14] ASoC: migor: use clkdev_create()
Date: Fri, 03 Apr 2015 18:13:29 +0100
Message-ID: <E1Ye59t-0001Bl-8o@rmk-PC.arm.linux.org.uk>
References: <20150403171149.GC13898@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:33808 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753882AbbDCRNg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Apr 2015 13:13:36 -0400
In-Reply-To: <20150403171149.GC13898@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>

clkdev_create() is a shorter way to write clkdev_alloc() followed by
clkdev_add().  Use this instead.

Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/soc/sh/migor.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/sh/migor.c b/sound/soc/sh/migor.c
index 82f582344fe7..672bcd4c252b 100644
--- a/sound/soc/sh/migor.c
+++ b/sound/soc/sh/migor.c
@@ -162,12 +162,11 @@ static int __init migor_init(void)
 	if (ret < 0)
 		return ret;
 
-	siumckb_lookup = clkdev_alloc(&siumckb_clk, "siumckb_clk", NULL);
+	siumckb_lookup = clkdev_create(&siumckb_clk, "siumckb_clk", NULL);
 	if (!siumckb_lookup) {
 		ret = -ENOMEM;
 		goto eclkdevalloc;
 	}
-	clkdev_add(siumckb_lookup);
 
 	/* Port number used on this machine: port B */
 	migor_snd_device = platform_device_alloc("soc-audio", 1);
-- 
1.8.3.1

