From: J Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2 1/4] MFD: Palmas: Check if interrupts property exists and then only request irq
Date: Tue, 18 Jun 2013 15:31:29 +0530
Message-ID: <1371549692-7361-2-git-send-email-j-keerthy@ti.com>
References: <1371549692-7361-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1371549692-7361-1-git-send-email-j-keerthy@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: broonie@kernel.org, j-keerthy@ti.com, ldewangan@nvidia.com, sameo@linux.intel.com, grant.likely@secretlab.ca, swarren@nvidia.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, gg@slimlogic.co.uk
List-Id: linux-omap@vger.kernel.org

Check if interrupts property exists and then only request irq.
On some boards INT line might not be connected to a valid
irq line on the application processor. Hence keeping a check
before requesting irq.

Boot tested on OMAP5-UEVM board.

Signed-off-by: J Keerthy <j-keerthy@ti.com>
---
 drivers/mfd/palmas.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
index 62fa728..69c4e62 100644
--- a/drivers/mfd/palmas.c
+++ b/drivers/mfd/palmas.c
@@ -236,6 +236,7 @@ static int palmas_i2c_probe(struct i2c_client *i2c,
 {
 	struct palmas *palmas;
 	struct palmas_platform_data *pdata;
+	struct device_node *regnode = NULL;
 	struct device_node *node = i2c->dev.of_node;
 	int ret = 0, i;
 	unsigned int reg, addr;
@@ -262,7 +263,6 @@ static int palmas_i2c_probe(struct i2c_client *i2c,
 	i2c_set_clientdata(i2c, palmas);
 	palmas->dev = &i2c->dev;
 	palmas->id = id->driver_data;
-	palmas->irq = i2c->irq;
 
 	for (i = 0; i < PALMAS_NUM_CLIENTS; i++) {
 		if (i == 0)
@@ -290,6 +290,15 @@ static int palmas_i2c_probe(struct i2c_client *i2c,
 		}
 	}
 
+	regnode = of_parse_phandle(node, "interrupts", 0);
+
+	if (!regnode) {
+		dev_warn(palmas->dev, "IRQ missing: skipping irq request\n");
+		goto no_irq;
+	} else {
+		palmas->irq = i2c->irq;
+	}
+
 	/* Change interrupt line output polarity */
 	if (pdata->irq_flags & IRQ_TYPE_LEVEL_HIGH)
 		reg = PALMAS_POLARITY_CTRL_INT_POLARITY;
@@ -316,6 +325,7 @@ static int palmas_i2c_probe(struct i2c_client *i2c,
 	if (ret < 0)
 		goto err;
 
+no_irq:
 	slave = PALMAS_BASE_TO_SLAVE(PALMAS_PU_PD_OD_BASE);
 	addr = PALMAS_BASE_TO_REG(PALMAS_PU_PD_OD_BASE,
 			PALMAS_PRIMARY_SECONDARY_PAD1);
-- 
1.7.5.4

