From: Laurent Navet <laurent.navet@gmail.com>
Subject: [PATCH 03/10] gpio: gpio-omap.c: fix checkpatch error
Date: Wed, 20 Mar 2013 13:15:57 +0100
Message-ID: <1363781764-17330-4-git-send-email-laurent.navet@gmail.com>
References: <1363781764-17330-1-git-send-email-laurent.navet@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363781764-17330-1-git-send-email-laurent.navet@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: grant.likely@secretlab.ca, linus.walleij@linaro.org
Cc: santosh.shilimkar@ti.com, khilman@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Laurent Navet <laurent.navet@gmail.com>
List-Id: linux-omap@vger.kernel.org

Fix :
 gpio/gpio-omap.c:697: ERROR: space required before the open parenthesis '('

Signed-off-by: Laurent Navet <laurent.navet@gmail.com>
---
 drivers/gpio/gpio-omap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 159f5c5..7e8f791 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -694,7 +694,7 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	if (WARN_ON(!isr_reg))
 		goto exit;
 
-	while(1) {
+	while (1) {
 		u32 isr_saved, level_mask = 0;
 		u32 enabled;
 
-- 
1.7.10.4
