From: Pantelis Antoniou <panto@antoniou-consulting.com>
Subject: [PATCH 1/2] pinctrl: pinctrl-single must be initialized early.
Date: Thu, 20 Sep 2012 09:34:48 +0300
Message-ID: <1348122889-28271-2-git-send-email-panto@antoniou-consulting.com>
References: <50596F8F.60506@ti.com>
 <1348122889-28271-1-git-send-email-panto@antoniou-consulting.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1348122889-28271-1-git-send-email-panto@antoniou-consulting.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Matt Porter <mporter@ti.com>, Koen Kooi <koen@dominion.thruhere.net>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Pantelis Antoniou <panto@antoniou-consulting.com>
List-Id: linux-omap@vger.kernel.org

When using pinctrl-single to handle i2c initialization, it has
to be done early.
On the beaglebone the regulator is connected to the i2c0 bus,
and for sure that's the case for many other am33xx boards.

Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>
---
 drivers/pinctrl/pinctrl-single.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 76a4260..3acf7f9 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -980,7 +980,17 @@ static struct platform_driver pcs_driver = {
 	},
 };
 
-module_platform_driver(pcs_driver);
+static int __init pcs_init(void)
+{
+	return platform_driver_register(&pcs_driver);
+}
+postcore_initcall(pcs_init);
+
+static void __exit pcs_exit(void)
+{
+	platform_driver_unregister(&pcs_driver);
+}
+module_exit(pcs_exit);
 
 MODULE_AUTHOR("Tony Lindgren <tony@atomide.com>");
 MODULE_DESCRIPTION("One-register-per-pin type device tree based pinctrl driver");
-- 
1.7.12
