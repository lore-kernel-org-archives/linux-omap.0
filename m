From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 5/6] mfd: smsc-ece1099: Delete an unnecessary variable
 initialisation in smsc_i2c_probe()
Date: Sun, 26 Jun 2016 15:51:36 +0200
Message-ID: <1b29f010-5617-3862-23f5-42a5e6a1bc81@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <5682D228.7070902@users.sourceforge.net> <20160111082922.GB14104@x1>
 <05b7db2a-437a-60ac-d289-71d2150e7f5f@users.sourceforge.net>
 <de3598c4-f85a-6807-303a-55ee0ac707f2@users.sourceforge.net>
 <20160608111442.GB14888@dell>
 <e4eaf0b4-e539-b400-c8a2-70f210cee1fa@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <e4eaf0b4-e539-b400-c8a2-70f210cee1fa@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-omap@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 26 Jun 2016 14:14:54 +0200

The variable "ret" will be set to an appropriate value a bit later.
Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/mfd/smsc-ece1099.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/smsc-ece1099.c b/drivers/mfd/smsc-ece1099.c
index 7f89e89..2aaf89f 100644
--- a/drivers/mfd/smsc-ece1099.c
+++ b/drivers/mfd/smsc-ece1099.c
@@ -36,7 +36,7 @@ static int smsc_i2c_probe(struct i2c_client *i2c,
 {
 	struct smsc *smsc;
 	int devid, rev, venid_l, venid_h;
-	int ret = 0;
+	int ret;
 
 	smsc = devm_kzalloc(&i2c->dev, sizeof(struct smsc),
 				GFP_KERNEL);
-- 
2.9.0

