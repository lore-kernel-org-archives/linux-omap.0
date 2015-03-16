From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 02/35 linux-next] regulator: constify of_device_id array
Date: Mon, 16 Mar 2015 20:17:08 +0100
Message-ID: <1426533469-25458-3-git-send-email-fabf@skynet.be>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426533469-25458-1-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Fabian Frederick <fabf@skynet.be>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

of_device_id is always used as const.
(See driver.of_match_table and open firmware functions)

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/regulator/palmas-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/palmas-regulator.c b/drivers/regulator/palmas-regulator.c
index 9205f43..eecce1e 100644
--- a/drivers/regulator/palmas-regulator.c
+++ b/drivers/regulator/palmas-regulator.c
@@ -1505,7 +1505,7 @@ static void palmas_dt_to_pdata(struct device *dev,
 	pdata->ldo6_vibrator = of_property_read_bool(node, "ti,ldo6-vibrator");
 }
 
-static struct of_device_id of_palmas_match_tbl[] = {
+static const struct of_device_id of_palmas_match_tbl[] = {
 	{
 		.compatible = "ti,palmas-pmic",
 		.data = &palmas_ddata,
-- 
2.1.0
