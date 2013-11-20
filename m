From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP2+: Fix populating the hwmod data from device tree
Date: Tue, 19 Nov 2013 18:56:20 -0800
Message-ID: <20131120025620.GF10317@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:31918 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234Ab3KTC4X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Nov 2013 21:56:23 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Paul Walmsley <paul@pwsan.com>

We have some device tree properties where the ti,hwmod has multiple
values:

am33xx.dtsi:	ti,hwmods =3D "tpcc", "tptc0", "tptc1", "tptc2";
am4372.dtsi:	ti,hwmods =3D "tpcc", "tptc0", "tptc1", "tptc2";
dra7.dtsi:	ti,hwmods =3D "l3_main_1", "l3_main_2";
omap3.dtsi:	ti,hwmods =3D "mcbsp2", "mcbsp2_sidetone";
omap3.dtsi:	ti,hwmods =3D "mcbsp3", "mcbsp3_sidetone";
omap4.dtsi:	ti,hwmods =3D "l3_main_1", "l3_main_2", "l3_main_3";
omap5.dtsi:	ti,hwmods =3D "l3_main_1", "l3_main_2", "l3_main_3";

So we need to handle the whole string array instead of just the
first string to find the related hwmod entry.

Cc: "Beno=C3=AEt Cousson" <bcousson@baylibre.com>
Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2228,11 +2228,23 @@ static struct device_node *of_dev_hwmod_lookup(=
struct device_node *np,
 						struct omap_hwmod *oh)
 {
 	struct device_node *np0 =3D NULL, *np1 =3D NULL;
-	const char *p;
=20
 	for_each_child_of_node(np, np0) {
-		if (of_find_property(np0, "ti,hwmods", NULL)) {
-			p =3D of_get_property(np0, "ti,hwmods", NULL);
+		int count, i;
+
+		count =3D of_property_count_strings(np0, "ti,hwmods");
+		if (count < 1)
+			continue;
+
+		for (i =3D 0; i < count; i++) {
+			const char *p;
+			int res;
+
+			res =3D of_property_read_string_index(np0, "ti,hwmods",
+							    i, &p);
+			if (res)
+				continue;
+
 			if (!strcmp(p, oh->name))
 				return np0;
 			np1 =3D of_dev_hwmod_lookup(np0, oh);
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
