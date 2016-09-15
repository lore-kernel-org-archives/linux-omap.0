From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 7/7] mfd: cros_ec_spi: Remove unused variable 'request'
Date: Thu, 15 Sep 2016 11:45:21 +0100
Message-ID: <20160915104521.14286-8-lee.jones@linaro.org>
References: <20160915104521.14286-1-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160915104521.14286-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linus.walleij@linaro.org, tony@atomide.com, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/cros_ec_spi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mfd/cros_ec_spi.c b/drivers/mfd/cros_ec_spi.c
index ebe9b94..a518832 100644
--- a/drivers/mfd/cros_ec_spi.c
+++ b/drivers/mfd/cros_ec_spi.c
@@ -366,7 +366,6 @@ static int cros_ec_spi_receive_response(struct cros_ec_device *ec_dev,
 static int cros_ec_pkt_xfer_spi(struct cros_ec_device *ec_dev,
 				struct cros_ec_command *ec_msg)
 {
-	struct ec_host_request *request;
 	struct ec_host_response *response;
 	struct cros_ec_spi *ec_spi = ec_dev->priv;
 	struct spi_transfer trans, trans_delay;
@@ -378,7 +377,6 @@ static int cros_ec_pkt_xfer_spi(struct cros_ec_device *ec_dev,
 	int ret = 0, final_ret;
 
 	len = cros_ec_prepare_tx(ec_dev, ec_msg);
-	request = (struct ec_host_request *)ec_dev->dout;
 	dev_dbg(ec_dev->dev, "prepared, len=%d\n", len);
 
 	/* If it's too soon to do another transaction, wait */
-- 
2.9.3
