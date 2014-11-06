From: Manish Badarkhe <manishvb@ti.com>
Subject: [PATCH] ASoC: tlv320aic3x: Remove '.owner' field of
	driver
Date: Thu, 6 Nov 2014 10:46:56 +0530
Message-ID: <1415251016-3730-1-git-send-email-manishvb@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, tiwai@suse.de, manishvb@ti.com, jsarha@ti.com
List-Id: linux-omap@vger.kernel.org

Remove '.owner' field of driver structure as it is
going to be filled via "module_i2c_driver" call.

Signed-off-by: Manish Badarkhe <manishvb@ti.com>
---
:100644 100644 0307909... 191b423... M	sound/soc/codecs/tlv320aic31xx.c
 sound/soc/codecs/tlv320aic31xx.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 0307909..191b423 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -1303,7 +1303,6 @@ MODULE_DEVICE_TABLE(i2c, aic31xx_i2c_id);
 static struct i2c_driver aic31xx_i2c_driver = {
 	.driver = {
 		.name	= "tlv320aic31xx-codec",
-		.owner	= THIS_MODULE,
 		.of_match_table = of_match_ptr(tlv320aic31xx_of_match),
 	},
 	.probe		= aic31xx_i2c_probe,
-- 
1.7.9.5
