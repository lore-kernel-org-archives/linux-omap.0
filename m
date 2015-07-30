From: NeilBrown <neil@brown.name>
Subject: [PATCH 03/13] twl4030_charger: correctly handle -EPROBE_DEFER from
 devm_usb_get_phy_by_node
Date: Thu, 30 Jul 2015 10:11:24 +1000
Message-ID: <20150730001124.4012.31980.stgit@noble>
References: <20150730001113.4012.18086.stgit@noble>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150730001113.4012.18086.stgit@noble>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, real GTA04 owners <gta04-owner@goldelico.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org

Now that twl4030_bci_probe can safely return -EPROBE_DEFER,
do so when devm_usb_get_phy_by_node returns that error.

Signed-off-by: NeilBrown <neil@brown.name>
---
 drivers/power/twl4030_charger.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_charger.c
index 045238370d3f..ffc123fb7158 100644
--- a/drivers/power/twl4030_charger.c
+++ b/drivers/power/twl4030_charger.c
@@ -636,9 +636,13 @@ static int twl4030_bci_probe(struct platform_device *pdev)
 
 		phynode = of_find_compatible_node(bci->dev->of_node->parent,
 						  NULL, "ti,twl4030-usb");
-		if (phynode)
+		if (phynode) {
 			bci->transceiver = devm_usb_get_phy_by_node(
 				bci->dev, phynode, &bci->usb_nb);
+			if (IS_ERR(bci->transceiver) &&
+			    PTR_ERR(bci->transceiver) == -EPROBE_DEFER)
+				return -EPROBE_DEFER;
+		}
 	}
 
 	/* Enable interrupts now. */
