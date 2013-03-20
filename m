From: Laurent Navet <laurent.navet@gmail.com>
Subject: [PATCH 04/10] gpio: gpio-pca953x.c: fix checkpatch error
Date: Wed, 20 Mar 2013 13:15:58 +0100
Message-ID: <1363781764-17330-5-git-send-email-laurent.navet@gmail.com>
References: <1363781764-17330-1-git-send-email-laurent.navet@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363781764-17330-1-git-send-email-laurent.navet@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: grant.likely@secretlab.ca, linus.walleij@linaro.org
Cc: santosh.shilimkar@ti.com, khilman@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Laurent Navet <laurent.navet@gmail.com>
List-Id: linux-omap@vger.kernel.org

Fix :
 gpio/gpio-pca953x.c:150: ERROR: else should follow close brace '}'

Signed-off-by: Laurent Navet <laurent.navet@gmail.com>
---
 drivers/gpio/gpio-pca953x.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 2405946..15dbc36 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -146,8 +146,7 @@ static int pca953x_write_regs(struct pca953x_chip *chip, int reg, u8 *val)
 		ret = i2c_smbus_write_i2c_block_data(chip->client,
 					(reg << bank_shift) | REG_ADDR_AI,
 					NBANK(chip), val);
-	}
-	else {
+	} else {
 		switch (chip->chip_type) {
 		case PCA953X_TYPE:
 			ret = i2c_smbus_write_word_data(chip->client,
-- 
1.7.10.4
