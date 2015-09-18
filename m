From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/2] mfd: twl6040: Fix deferred probe handling for clk32k
Date: Fri, 18 Sep 2015 09:29:04 -0700
Message-ID: <1442593745-16725-2-git-send-email-tony@atomide.com>
References: <1442593745-16725-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1442593745-16725-1-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Samuel Ortiz <sameo@linux.intel.com>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, Grazvydas Ignotas <notasas@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Sourav Poddar <sourav.poddar@ti.com>, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Commit 68bab8662f49 ("mfd: twl6040: Optional clk32k clock handling")
added clock handling for the 32k clock from palmas-clk. However, that
patch did not consider a typical situation where twl6040 is built-in,
and palmas-clk is a loadable module like we have in omap2plus_defconfig.

If palmas-clk is not loaded before twl6040 probes, we will get a
"clk32k is not handled" warning during booting. This means that any
drivers relying on this clock will mysteriously fail, including
omap5-uevm WLAN and audio.

Note that for WLAN, we probably should also eventually get
the clk32kgaudio for MMC3 directly as that's shared between
audio and WLAN SDIO at least for omap5-uevm. It seems the
WLAN chip cannot get it as otherwise MMC3 won't get properly
probed.

Fixes: 68bab8662f49 ("mfd: twl6040: Optional clk32k clock handling")
Cc: Benoit Cousson <bcousson@baylibre.com>
Cc: Dr. H. Nikolaus Schaller <hns@goldelico.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Sourav Poddar <sourav.poddar@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mfd/twl6040.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/mfd/twl6040.c
+++ b/drivers/mfd/twl6040.c
@@ -647,6 +647,8 @@ static int twl6040_probe(struct i2c_client *client,
 
 	twl6040->clk32k = devm_clk_get(&client->dev, "clk32k");
 	if (IS_ERR(twl6040->clk32k)) {
+		if (PTR_ERR(twl6040->clk32k) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
 		dev_info(&client->dev, "clk32k is not handled\n");
 		twl6040->clk32k = NULL;
 	}
-- 
2.1.4
