From: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v4] regulator: lp873x: Add support for populating input supply
Date: Thu, 10 Nov 2016 10:59:15 +0530
Message-ID: <20161110052915.4898-1-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Linux ARM Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

In order to have a proper topology of regulators for a platform, each
registering regulator needs to populate supply_name field for identifying
its supply's name. Add supply_name field for lp873x regulators.

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
---
Changes since v3:
- Applied Rob's ack.
- Sending this patch separately so that this can be merged via Regulator tree.
- Link to v3: https://patchwork.kernel.org/patch/9408545/

 Documentation/devicetree/bindings/mfd/lp873x.txt | 8 ++++++++
 drivers/regulator/lp873x-regulator.c             | 1 +
 2 files changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/lp873x.txt b/Documentation/devicetree/bindings/mfd/lp873x.txt
index 52766c2..ae9cf39 100644
--- a/Documentation/devicetree/bindings/mfd/lp873x.txt
+++ b/Documentation/devicetree/bindings/mfd/lp873x.txt
@@ -7,6 +7,9 @@ Required properties:
   - #gpio-cells:	Should be two.  The first cell is the pin number and
 			the second cell is used to specify flags.
 			See ../gpio/gpio.txt for more information.
+  - xxx-in-supply:	Phandle to parent supply node of each regulator
+			populated under regulators node. xxx can be
+			buck0, buck1, ldo0 or ldo1.
   - regulators:	List of child nodes that specify the regulator
 			initialization data.
 Example:
@@ -17,6 +20,11 @@ pmic: lp8733@60 {
 	gpio-controller;
 	#gpio-cells = <2>;
 
+	buck0-in-supply = <&vsys_3v3>;
+	buck1-in-supply = <&vsys_3v3>;
+	ldo0-in-supply = <&vsys_3v3>;
+	ldo1-in-supply = <&vsys_3v3>;
+
 	regulators {
 		lp8733_buck0: buck0 {
 			regulator-name = "lp8733-buck0";
diff --git a/drivers/regulator/lp873x-regulator.c b/drivers/regulator/lp873x-regulator.c
index e504b91..70e3df6 100644
--- a/drivers/regulator/lp873x-regulator.c
+++ b/drivers/regulator/lp873x-regulator.c
@@ -24,6 +24,7 @@
 	[_id] = {							\
 		.desc = {						\
 			.name			= _name,		\
+			.supply_name		= _of "-in",		\
 			.id			= _id,			\
 			.of_match		= of_match_ptr(_of),	\
 			.regulators_node	= of_match_ptr("regulators"),\
-- 
2.10.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
