From: Timo Kokkonen <timo.t.kokkonen@iki.fi>
Subject: [PATCHv2 6/8] ir-rx51: Replace module_{init,exit} macros with module_platform_driver
Date: Fri, 24 Aug 2012 18:09:44 +0300
Message-ID: <1345820986-4597-7-git-send-email-timo.t.kokkonen@iki.fi>
References: <1345820986-4597-1-git-send-email-timo.t.kokkonen@iki.fi>
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <1345820986-4597-1-git-send-email-timo.t.kokkonen@iki.fi>
Sender: linux-media-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

No reason to avoid using the existing helpers.

Signed-off-by: Timo Kokkonen <timo.t.kokkonen@iki.fi>
---
 drivers/media/rc/ir-rx51.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/media/rc/ir-rx51.c b/drivers/media/rc/ir-rx51.c
index 16b3c1f..6e1ffa6 100644
--- a/drivers/media/rc/ir-rx51.c
+++ b/drivers/media/rc/ir-rx51.c
@@ -495,17 +495,7 @@ struct platform_driver lirc_rx51_platform_driver = {
 	},
 };
 
-static int __init lirc_rx51_init(void)
-{
-	return platform_driver_register(&lirc_rx51_platform_driver);
-}
-module_init(lirc_rx51_init);
-
-static void __exit lirc_rx51_exit(void)
-{
-	platform_driver_unregister(&lirc_rx51_platform_driver);
-}
-module_exit(lirc_rx51_exit);
+module_platform_driver(lirc_rx51_platform_driver);
 
 MODULE_DESCRIPTION("LIRC TX driver for Nokia RX51");
 MODULE_AUTHOR("Nokia Corporation");
-- 
1.7.12
