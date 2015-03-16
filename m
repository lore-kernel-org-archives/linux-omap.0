From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 21/35 linux-next] mfd: constify of_device_id array
Date: Mon, 16 Mar 2015 20:21:36 +0100
Message-ID: <1426533710-25687-2-git-send-email-fabf@skynet.be>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
 <1426533710-25687-1-git-send-email-fabf@skynet.be>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailrelay118.isp.belgacom.be ([195.238.20.145]:8331 "EHLO
	mailrelay118.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934729AbbCPTVz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Mar 2015 15:21:55 -0400
In-Reply-To: <1426533710-25687-1-git-send-email-fabf@skynet.be>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Fabian Frederick <fabf@skynet.be>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

of_device_id is always used as const.
(See driver.of_match_table and open firmware functions)

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/mfd/hi6421-pmic-core.c | 2 +-
 drivers/mfd/rk808.c            | 2 +-
 drivers/mfd/twl4030-power.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/hi6421-pmic-core.c b/drivers/mfd/hi6421-pmic-core.c
index 7210ae2..95b2ff8 100644
--- a/drivers/mfd/hi6421-pmic-core.c
+++ b/drivers/mfd/hi6421-pmic-core.c
@@ -93,7 +93,7 @@ static int hi6421_pmic_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id of_hi6421_pmic_match_tbl[] = {
+static const struct of_device_id of_hi6421_pmic_match_tbl[] = {
 	{ .compatible = "hisilicon,hi6421-pmic", },
 	{ },
 };
diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index 7cf25c7..4b1e439 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -246,7 +246,7 @@ static int rk808_remove(struct i2c_client *client)
 	return 0;
 }
 
-static struct of_device_id rk808_of_match[] = {
+static const struct of_device_id rk808_of_match[] = {
 	{ .compatible = "rockchip,rk808" },
 	{ },
 };
diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index 3935092..f440aed 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -829,7 +829,7 @@ static struct twl4030_power_data osc_off_idle = {
 	.board_config		= osc_off_rconfig,
 };
 
-static struct of_device_id twl4030_power_of_match[] = {
+static const struct of_device_id twl4030_power_of_match[] = {
 	{
 		.compatible = "ti,twl4030-power",
 	},
-- 
2.1.0

