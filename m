From: NeilBrown <neil@brown.name>
Subject: [PATCH 02/13] twl4030_charger: convert to module_platform_driver
 instead of ..._probe.
Date: Thu, 30 Jul 2015 10:11:24 +1000
Message-ID: <20150730001124.4012.45460.stgit@noble>
References: <20150730001113.4012.18086.stgit@noble>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150730001113.4012.18086.stgit@noble>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, real GTA04 owners <gta04-owner@goldelico.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org

=46rom: Pavel Machek <pavel@ucw.cz>

Drivers using module_platform_driver_probe cannot return
EPROBE_DEFER from the probe function, which makes them rather useless
these days...

Convert to module_platform_driver() so EPROBE_DEFER can be used.

Signed-off-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: NeilBrown <neil@brown.name>
---
 drivers/power/twl4030_charger.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_ch=
arger.c
index fe71c61109f5..045238370d3f 100644
--- a/drivers/power/twl4030_charger.c
+++ b/drivers/power/twl4030_charger.c
@@ -568,7 +568,7 @@ static const struct power_supply_desc twl4030_bci_u=
sb_desc =3D {
 	.get_property	=3D twl4030_bci_get_property,
 };
=20
-static int __init twl4030_bci_probe(struct platform_device *pdev)
+static int twl4030_bci_probe(struct platform_device *pdev)
 {
 	struct twl4030_bci *bci;
 	const struct twl4030_bci_platform_data *pdata =3D pdev->dev.platform_=
data;
@@ -692,14 +692,14 @@ static const struct of_device_id twl_bci_of_match=
[] =3D {
 MODULE_DEVICE_TABLE(of, twl_bci_of_match);
=20
 static struct platform_driver twl4030_bci_driver =3D {
+	.probe =3D twl4030_bci_probe,
 	.driver	=3D {
 		.name	=3D "twl4030_bci",
 		.of_match_table =3D of_match_ptr(twl_bci_of_match),
 	},
 	.remove	=3D __exit_p(twl4030_bci_remove),
 };
-
-module_platform_driver_probe(twl4030_bci_driver, twl4030_bci_probe);
+module_platform_driver(twl4030_bci_driver);
=20
 MODULE_AUTHOR("Gra=C5=BEvydas Ignotas");
 MODULE_DESCRIPTION("TWL4030 Battery Charger Interface driver");
