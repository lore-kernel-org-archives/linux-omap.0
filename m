From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/4] I2C: Ensure write posting for critical i2c-omap writes
Date: Fri, 31 Oct 2008 12:21:12 -0700
Message-ID: <1225480873-30835-4-git-send-email-tony@atomide.com>
References: <1225480873-30835-1-git-send-email-tony@atomide.com>
 <1225480873-30835-2-git-send-email-tony@atomide.com>
 <1225480873-30835-3-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59157 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866AbYJaTVX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Oct 2008 15:21:23 -0400
In-Reply-To: <1225480873-30835-3-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

Otherwise we may race, or will get spurious I2C interrupts:

i2c_omap.1: XDR IRQ while no data to send
...

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/i2c/busses/i2c-omap.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index a999606..8468280 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -689,6 +689,9 @@ omap_i2c_isr(int this_irq, void *dev_id)
 					break;
 				}
 				omap_i2c_write_reg(dev, OMAP_I2C_DATA_REG, w);
+
+				/* Ensure write posting of the write */
+				omap_i2c_read_reg(dev, OMAP_I2C_DATA_REG);
 			}
 			omap_i2c_ack_stat(dev,
 				stat & (OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR));
-- 
1.5.6.rc3.21.g8c6b5

