From: Laurent Navet <laurent.navet@gmail.com>
Subject: [PATCH 09/10] gpio: gpio-timberdale.c: fix checkpatch error
Date: Wed, 20 Mar 2013 13:16:03 +0100
Message-ID: <1363781764-17330-10-git-send-email-laurent.navet@gmail.com>
References: <1363781764-17330-1-git-send-email-laurent.navet@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363781764-17330-1-git-send-email-laurent.navet@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: grant.likely@secretlab.ca, linus.walleij@linaro.org
Cc: santosh.shilimkar@ti.com, khilman@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Laurent Navet <laurent.navet@gmail.com>
List-Id: linux-omap@vger.kernel.org

Fix :
 gpio/gpio-timberdale.c:171: ERROR: else should follow close brace '}'

Signed-off-by: Laurent Navet <laurent.navet@gmail.com>
---
 drivers/gpio/gpio-timberdale.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-timberdale.c b/drivers/gpio/gpio-timberdale.c
index 702cca9..4377405 100644
--- a/drivers/gpio/gpio-timberdale.c
+++ b/drivers/gpio/gpio-timberdale.c
@@ -167,8 +167,7 @@ static int timbgpio_irq_type(struct irq_data *d, unsigned trigger)
 		if (ver < 3) {
 			ret = -EINVAL;
 			goto out;
-		}
-		else {
+		} else {
 			flr |= 1 << offset;
 			bflr |= 1 << offset;
 		}
-- 
1.7.10.4
