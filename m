From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [RFC/PATCH 2/3] i2c: Fall back to emulated SMBus if the operation isn't supported natively
Date: Tue, 26 Jun 2012 16:17:08 +0200
Message-ID: <1340720229-30356-3-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1340720229-30356-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:41564 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757596Ab2FZORK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jun 2012 10:17:10 -0400
In-Reply-To: <1340720229-30356-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Jean Delvare <khali@linux-fr.org>

Adapter drivers might support only a subset of the SMBus operations
natively. Those drivers currently have to manually emulate unsupported
operations using I2C.

Make the i2c_smbus_xfer() function fall back to
i2c_smbus_xfer_emulated() when the adapter's .smbus_xfer() operation
returns -EOPNOTSUPP, like it already does when the .smbus_xfer()
operation isn't available at all.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/i2c/i2c-core.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 8cfa660..16e750e 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -2113,8 +2113,8 @@ s32 i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr, unsigned short flags,
 		   union i2c_smbus_data *data)
 {
 	unsigned long orig_jiffies;
+	s32 res = -EOPNOTSUPP;
 	int try;
-	s32 res;
 
 	flags &= I2C_M_TEN | I2C_CLIENT_PEC | I2C_CLIENT_SCCB;
 
@@ -2134,7 +2134,12 @@ s32 i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr, unsigned short flags,
 				break;
 		}
 		i2c_unlock_adapter(adapter);
-	} else
+	}
+
+	/* Fall back to i2c_smbus_xfer_emulated of the adapter doesn't implement
+	 * native support for the SMBus operation.
+	 */
+	if (res == -EOPNOTSUPP && adapter->algo->master_xfer)
 		res = i2c_smbus_xfer_emulated(adapter, addr, flags, read_write,
 					      command, protocol, data);
 
-- 
1.7.3.4

