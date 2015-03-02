From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 06/10] ASOC: migor: use clkdev_create()
Date: Mon, 02 Mar 2015 17:06:32 +0000
Message-ID: <E1YSTnc-0001Jo-1U@rmk-PC.arm.linux.org.uk>
References: <20150302170538.GQ8656@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20150302170538.GQ8656@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-sh-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
List-Id: linux-omap@vger.kernel.org

clkdev_create() is a shorter way to write clkdev_alloc() followed by
clkdev_add().  Use this instead.

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

