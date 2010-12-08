From: Bryan Wu <bryan.wu@canonical.com>
Subject: [PATCH] MFD: TWL/TPS: fix twl_probe section mismatch warning in mfd/twl-core.c
Date: Wed,  8 Dec 2010 10:42:04 +0800
Message-ID: <1291776124-9570-1-git-send-email-bryan.wu@canonical.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:49281 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754770Ab0LHCmB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 21:42:01 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, linux-omap@vger.kernel.org, sameo@linux.intel.com

Fix the following section mismatch warning when building omap2plus_defconfig:

WARNING: vmlinux.o(.data+0x47d7c): Section mismatch in reference from the variable twl_driver to the function .init.text:twl_probe()

Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 drivers/mfd/twl-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 35275ba..3aa46ff 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -969,7 +969,7 @@ static int twl_remove(struct i2c_client *client)
 }
 
 /* NOTE:  this driver only handles a single twl4030/tps659x0 chip */
-static int __init
+static int __devinit
 twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
 	int				status;
-- 
1.7.1

