From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [Kernel] [PATCH v2 4/5] ARM: dts: omap5: describe control for
 ckobuffer
Date: Mon, 9 May 2016 15:32:04 +0300
Message-ID: <f66cd508-fe53-af58-bda5-822c8213cf7d@ti.com>
References: <cover.1461003660.git.hns@goldelico.com>
 <a5fb89737594a656318896a8e43814c21ca992eb.1461003660.git.hns@goldelico.com>
 <20160426172710.GI5995@atomide.com>
 <70572DA1-BEB4-4681-BA6C-2E1C9002D730@goldelico.com>
 <5720B107.4000907@ti.com>
 <A90F1BFC-A834-4EC0-81F9-2C8222AAA010@goldelico.com>
 <5720C85B.9010701@ti.com> <ce9a7840-e86f-0d0c-3ed6-a571eec6659d@ti.com>
 <40536322-073F-48BD-9D07-32B9A9F07AF2@goldelico.com>
 <5721C3D4.7040401@ti.com>
 <2A9D82CD-9ACA-49F6-9D2B-9EACFC517914@goldelico.com>
 <57220EDD.7080903@ti.com>
 <F2BCD4BA-E4E4-43F4-B65C-B625ED3B2D13@goldelico.com>
 <573079F5.7050507@ti.com> <145c9917-6a85-292b-c3c9-cf85ceb26f21@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------49F46B4D2B0AD0B2C511B7EF"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <145c9917-6a85-292b-c3c9-cf85ceb26f21@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Russell King <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tony Lindgren <tony@atomide.com>, kernel@pyra-handheld.com, LKML <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Kumar Gala <galak@codeaurora.org>, Marek Belisko <marek@goldelico.com>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

--------------49F46B4D2B0AD0B2C511B7EF
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On 05/09/16 15:10, Peter Ujfalusi wrote:

>>> finally I found some time to apply your patches. Sorry for the long time.
>>>
>>> Unfortunately, it does not work. Neither on omap5evm nor on our omap5 hardware.
>>> I get no sound on the twl6040 - just white noise (which can be controlled in
>>> level through
>>> amixer so it is created on the digital input side of the twl6040).
>>>
>>> So I think your patch is missing a detail compared to my simple solution.
>>
>> Did you implement anything on the audio driver side? The audio driver must
>> enable the clock implemented by this patch.
> 
> I did, can test it in 10 minutes or so...

might work, but linux-next is not booting on omap5-uevm :o I don't know why...

In any case I have attached the 3 patches I have for this, including Tero's
ported to linux-next.

Patch 3 might need to be done per board probably, but this should be good for
testing.

-- 
Péter

--------------49F46B4D2B0AD0B2C511B7EF
Content-Type: text/x-patch;
	name="0001-ARM-omap5-add-support-for-fref_xtal_ck.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-ARM-omap5-add-support-for-fref_xtal_ck.patch"

>From d492ada3f7734eb1e4999c68ef0950c1ace9a6c8 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Mon, 9 May 2016 15:17:50 +0300
Subject: [PATCH 1/3] ARM: omap5: add support for fref_xtal_ck

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi           | 22 ++++++++++++++++++++++
 arch/arm/boot/dts/omap54xx-clocks.dtsi | 10 ++++++++++
 arch/arm/mach-omap2/control.c          | 20 ++++++++++++++++----
 include/linux/clk/ti.h                 |  1 +
 4 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 84c10195e79b..d0d6a6c6fcc3 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -198,6 +198,28 @@
 						};
 					};
 				};
+
+				omap5_scm_wkup_pad_conf: omap5_scm_wkup_pad_conf@cda0 {
+					compatible = "ti,omap5-scm-wkup-pad-conf",
+						     "simple-bus";
+					reg = <0xcda0 0x60>;
+					#address-cells = <1>;
+					#size-cells = <1>;
+					ranges = <0 0xcda0 0x60>;
+
+					scm_wkup_pad_conf: scm_conf@0 {
+						compatible = "syscon", "simple-bus";
+						reg = <0x0 0x60>;
+						#address-cells = <1>;
+						#size-cells = <1>;
+						ranges = <0 0x0 0x60>;
+
+						scm_wkup_pad_conf_clocks: clocks@0 {
+							#address-cells = <1>;
+							#size-cells = <0>;
+						};
+					};
+				};
 			};
 
 			cm_core_aon: cm_core_aon@4000 {
diff --git a/arch/arm/boot/dts/omap54xx-clocks.dtsi b/arch/arm/boot/dts/omap54xx-clocks.dtsi
index 4899c2359d0a..2450ea635c65 100644
--- a/arch/arm/boot/dts/omap54xx-clocks.dtsi
+++ b/arch/arm/boot/dts/omap54xx-clocks.dtsi
@@ -1388,3 +1388,13 @@
 		reg = <0x021c>;
 	};
 };
+
+&scm_wkup_pad_conf_clocks {
+	fref_xtal_ck: fref_xtal_ck {
+		#clocks-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&sys_clkin>;
+		ti,bit-shift = <28>;
+		reg = <0x14>;
+	};
+};
diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 1662071bb2cc..595664173e49 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -623,6 +623,7 @@ void __init omap3_ctrl_init(void)
 
 struct control_init_data {
 	int index;
+	void __iomem *mem;
 	s16 offset;
 };
 
@@ -635,6 +636,10 @@ static const struct control_init_data omap2_ctrl_data = {
 	.offset = -OMAP2_CONTROL_GENERAL,
 };
 
+static const struct control_init_data ctrl_aux_data = {
+	.index = TI_CLKM_CTRL_AUX,
+};
+
 static const struct of_device_id omap_scrm_dt_match_table[] = {
 	{ .compatible = "ti,am3-scm", .data = &ctrl_data },
 	{ .compatible = "ti,am4-scm", .data = &ctrl_data },
@@ -644,6 +649,7 @@ static const struct of_device_id omap_scrm_dt_match_table[] = {
 	{ .compatible = "ti,dm816-scrm", .data = &ctrl_data },
 	{ .compatible = "ti,omap4-scm-core", .data = &ctrl_data },
 	{ .compatible = "ti,omap5-scm-core", .data = &ctrl_data },
+	{ .compatible = "ti,omap5-scm-wkup-pad-conf", .data = &ctrl_aux_data },
 	{ .compatible = "ti,dra7-scm-core", .data = &ctrl_data },
 	{ }
 };
@@ -660,15 +666,21 @@ int __init omap2_control_base_init(void)
 	struct device_node *np;
 	const struct of_device_id *match;
 	struct control_init_data *data;
+	void __iomem *mem;
 
 	for_each_matching_node_and_match(np, omap_scrm_dt_match_table, &match) {
 		data = (struct control_init_data *)match->data;
 
-		omap2_ctrl_base = of_iomap(np, 0);
-		if (!omap2_ctrl_base)
+		mem = of_iomap(np, 0);
+		if (!mem)
 			return -ENOMEM;
 
-		omap2_ctrl_offset = data->offset;
+		if (data->index == TI_CLKM_CTRL) {
+			omap2_ctrl_base = mem;
+			omap2_ctrl_offset = data->offset;
+		}
+
+		data->mem = mem;
 	}
 
 	return 0;
@@ -713,7 +725,7 @@ int __init omap_control_init(void)
 		} else {
 			/* No scm_conf found, direct access */
 			ret = omap2_clk_provider_init(np, data->index, NULL,
-						      omap2_ctrl_base);
+						      data->mem);
 			if (ret)
 				return ret;
 		}
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 6110fe09ed18..5431f17a36bc 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -197,6 +197,7 @@ enum {
 	TI_CLKM_PRM,
 	TI_CLKM_SCRM,
 	TI_CLKM_CTRL,
+	TI_CLKM_CTRL_AUX,
 	TI_CLKM_PLLSS,
 	CLK_MAX_MEMMAPS
 };
-- 
2.8.2


--------------49F46B4D2B0AD0B2C511B7EF
Content-Type: text/x-patch;
	name="0002-mfd-twl6040-Handle-mclk-for-HPPLL-via-clock-API.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0002-mfd-twl6040-Handle-mclk-for-HPPLL-via-clock-API.patch"

>From d1099793e9189c6bb9514cfbed38638f0873a53d Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Mon, 9 May 2016 15:24:40 +0300
Subject: [PATCH 2/3] mfd: twl6040: Handle mclk (for HPPLL) via clock API

Support for mclk handling via clock API

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/mfd/twl6040.c       | 27 ++++++++++++++++++++-------
 include/linux/mfd/twl6040.h |  3 ++-
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
index 08a693cd38cc..32b72b65a0f0 100644
--- a/drivers/mfd/twl6040.c
+++ b/drivers/mfd/twl6040.c
@@ -291,7 +291,9 @@ int twl6040_power(struct twl6040 *twl6040, int on)
 		if (twl6040->power_count++)
 			goto out;
 
-		clk_prepare_enable(twl6040->clk32k);
+		clk_prepare_enable(twl6040->clk32k_clk);
+		if (twl6040->pll == TWL6040_SYSCLK_SEL_HPPLL)
+			clk_prepare_enable(twl6040->mclk_clk);
 
 		/* Allow writes to the chip */
 		regcache_cache_only(twl6040->regmap, false);
@@ -349,7 +351,10 @@ int twl6040_power(struct twl6040 *twl6040, int on)
 		twl6040->sysclk = 0;
 		twl6040->mclk = 0;
 
-		clk_disable_unprepare(twl6040->clk32k);
+		if (twl6040->pll == TWL6040_SYSCLK_SEL_HPPLL)
+			clk_disable_unprepare(twl6040->mclk_clk);
+
+		clk_disable_unprepare(twl6040->clk32k_clk);
 	}
 
 out:
@@ -645,12 +650,20 @@ static int twl6040_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, twl6040);
 
-	twl6040->clk32k = devm_clk_get(&client->dev, "clk32k");
-	if (IS_ERR(twl6040->clk32k)) {
-		if (PTR_ERR(twl6040->clk32k) == -EPROBE_DEFER)
+	twl6040->clk32k_clk = devm_clk_get(&client->dev, "clk32k_clk");
+	if (IS_ERR(twl6040->clk32k_clk)) {
+		if (PTR_ERR(twl6040->clk32k_clk) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		dev_info(&client->dev, "clk32k_clk is not handled\n");
+		twl6040->clk32k_clk = NULL;
+	}
+
+	twl6040->mclk_clk = devm_clk_get(&client->dev, "mclk");
+	if (IS_ERR(twl6040->mclk_clk)) {
+		if (PTR_ERR(twl6040->mclk_clk) == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
-		dev_info(&client->dev, "clk32k is not handled\n");
-		twl6040->clk32k = NULL;
+		dev_info(&client->dev, "mclk is not handled\n");
+		twl6040->mclk_clk = NULL;
 	}
 
 	twl6040->supplies[0].supply = "vio";
diff --git a/include/linux/mfd/twl6040.h b/include/linux/mfd/twl6040.h
index 8f9fc3d26e6d..a7c50e54f3e0 100644
--- a/include/linux/mfd/twl6040.h
+++ b/include/linux/mfd/twl6040.h
@@ -224,7 +224,8 @@ struct twl6040 {
 	struct regmap *regmap;
 	struct regmap_irq_chip_data *irq_data;
 	struct regulator_bulk_data supplies[2]; /* supplies for vio, v2v1 */
-	struct clk *clk32k;
+	struct clk *clk32k_clk;
+	struct clk *mclk_clk;
 	struct mutex mutex;
 	struct mutex irq_mutex;
 	struct mfd_cell cells[TWL6040_CELLS];
-- 
2.8.2


--------------49F46B4D2B0AD0B2C511B7EF
Content-Type: text/x-patch;
	name="0003-ARM-dts-omap5-board-common-Add-phandle-for-mclk-cloc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0003-ARM-dts-omap5-board-common-Add-phandle-for-mclk-cloc.pa";
	filename*1="tch"

>From 87714553b1f803f9c08d32c2c61dc980ddbb1b78 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Mon, 9 May 2016 15:26:11 +0300
Subject: [PATCH 3/3] ARM: dts: omap5-board-common: Add phandle for mclk clock
 for twl6040

it is used for hppll.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap5-board-common.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-board-common.dtsi b/arch/arm/boot/dts/omap5-board-common.dtsi
index a3a631fb77aa..4caad4dc5d41 100644
--- a/arch/arm/boot/dts/omap5-board-common.dtsi
+++ b/arch/arm/boot/dts/omap5-board-common.dtsi
@@ -649,8 +649,8 @@
 		v2v1-supply = <&smps9_reg>;
 		enable-active-high;
 
-		clocks = <&clk32kgaudio>;
-		clock-names = "clk32k";
+		clocks = <&clk32kgaudio>, <&fref_xtal_ck>;
+		clock-names = "clk32k", "mclk";
 	};
 };
 
-- 
2.8.2


--------------49F46B4D2B0AD0B2C511B7EF--
