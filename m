From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v3 1/4] MFD: Palmas: Check if irq is valid
Date: Wed, 19 Jun 2013 11:27:47 +0530
Message-ID: <1371621470-22279-2-git-send-email-j-keerthy@ti.com>
References: <1371621470-22279-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1371621470-22279-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: broonie@kernel.org, j-keerthy@ti.com, ldewangan@nvidia.com, sameo@linux.intel.com, grant.likely@secretlab.ca, swarren@nvidia.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, gg@slimlogic.co.uk
List-Id: linux-omap@vger.kernel.org

From: J Keerthy <j-keerthy@ti.com>

Check if irq value obtained is valid. If it is not valid
then skip the irq request step and go ahead with the probe.

Signed-off-by: J Keerthy <j-keerthy@ti.com>
---
 drivers/mfd/palmas.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
index 62fa728..b24bee3 100644
--- a/drivers/mfd/palmas.c
+++ b/drivers/mfd/palmas.c
@@ -290,6 +290,11 @@ static int palmas_i2c_probe(struct i2c_client *i2c,
 		}
 	}
 
+	if (!palmas->irq) {
+		dev_warn(palmas->dev, "IRQ missing: skipping irq request\n");
+		goto no_irq;
+	}
+
 	/* Change interrupt line output polarity */
 	if (pdata->irq_flags & IRQ_TYPE_LEVEL_HIGH)
 		reg = PALMAS_POLARITY_CTRL_INT_POLARITY;
@@ -316,6 +321,7 @@ static int palmas_i2c_probe(struct i2c_client *i2c,
 	if (ret < 0)
 		goto err;
 
+no_irq:
 	slave = PALMAS_BASE_TO_SLAVE(PALMAS_PU_PD_OD_BASE);
 	addr = PALMAS_BASE_TO_REG(PALMAS_PU_PD_OD_BASE,
 			PALMAS_PRIMARY_SECONDARY_PAD1);
-- 
1.7.5.4
