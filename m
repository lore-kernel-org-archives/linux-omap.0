From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/9] OMAP: DSS2: Change DSI platform device name from
 "omapdss_dsi1" to "omapdss_dsi"
Date: Thu, 05 May 2011 16:03:22 +0300
Message-ID: <1304600602.30935.30.camel@deskari>
References: <1304494704-7285-1-git-send-email-archit@ti.com>
	 <1304494704-7285-2-git-send-email-archit@ti.com>
	 <20110504094050.GI27860@atomide.com> <1304595408.30935.16.camel@deskari>
	 <20110505115007.GF2092@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:58194 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751599Ab1EEND2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 May 2011 09:03:28 -0400
Received: by ewy28 with SMTP id 28so938454ewy.39
        for <linux-omap@vger.kernel.org>; Thu, 05 May 2011 06:03:25 -0700 (PDT)
In-Reply-To: <20110505115007.GF2092@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org

On Thu, 2011-05-05 at 04:50 -0700, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [110505 04:33]:
> > On Wed, 2011-05-04 at 12:40 +0300, Tony Lindgren wrote:
> > > 
> > > Looks like we should first combine all this cut and paste data
> > > for each board file into some common init function to cut
> > > down the "crazy churn".
> > 
> > Sorry, I don't see how this would be possible with the regulator
> > framework. What we would need is to setup some
> > regulator_consumer_supplies dynamically depending on the omap and on the
> > given parameters.
> > 
> > Adding Liam and Mark for possible comments. A short summary of the
> > situation:
> > 
> > OMAP display subsystem (DSS) HW needs a few power supplies (vdds_dsi,
> > vdds_sdi, vdda_dac), depending on the OMAP version. All the known boards
> > have the standard TWL power chip which provides these powers, and they
> > are connected almost always the same way. However, there's no reason
> > that the powers for DSS couldn't be provided from some other source.
> > 
> > As an example, on OMAP3 we could have:
> > (regulator -> name -> driver)
> > VDDA_DAC -> "vdda_dac" -> omapdss_venc
> > VPLL2 -> "vdds_dsi" -> omapdss
> > VPLL2 -> "vdds_dsi" -> omapdss_dsi
> > 
> > So currently we have REGULATOR_SUPPLY defines for each board in all the
> > board files which support display. It would be much better to have an
> > overrideable standard setup for the DSS powers, but this would require
> > dynamically setting up the regulator_consumer_supplies. And I can't see
> > how this could be done, except dynamically creating the
> > regulator_consumer_supply array before initializing the TWL chip, but as
> > DSS is not the only user of those powers the end result could be quite a
> > mess with changes needed in every board file.
> 
> What if you just do all common DSS REGULATOR_SUPPLY entries in the common
> platform init code for DSS? Then just set the regulator_init_data pointers
> based on the desired configuration.
> 
> Or maybe I misunderstood your problem..

I made a test patch for this (below), but after looking at OMAP3 and 4
TRMs, I don't think this is going to be very good solution. It looks
like on OMAP3 the VPLL2 is used (at least) for DSI and CSI. On OMAP4
VCXIO is used for vdda_dpll_mpu, vdda_dpll_core_audio,
vdda_dpll_iva_per, vdda_dsi[1:2], vdda_csi2[1:2], vdda_usba0otg_1p8v.

VPLL2 and VCXIO do not look like to be dedicated for DSS, so I'm
guessing it's more than normal to have more users for the regulators
than just DSS (but they just aren't implemented currently).

Another option that came to my mind is defining simple macros like:

#define OMAP_DSS_REG_SUPPLY_DSS REGULATOR_SUPPLY("vdds_dsi", "omapdss")
#define OMAP_DSS_REG_SUPPLY_DSI1 REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi1")

And then use them instead:

static struct regulator_consumer_supply sdp3430_vpll2_supplies[] = {
	OMAP_DSS_REG_SUPPLY_DSS,
	OMAP_DSS_REG_SUPPLY_DSI1,
};

But that is quite minor improvement, and I'm not even sure if it's an
improvement...

 Tomi


diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 9afd087..dedc150 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -394,16 +394,6 @@ static struct regulator_consumer_supply sdp3430_vaux3_supplies[] = {
 	REGULATOR_SUPPLY("vcc", "spi1.0"),
 };
 
-static struct regulator_consumer_supply sdp3430_vdda_dac_supplies[] = {
-	REGULATOR_SUPPLY("vdda_dac", "omapdss_venc"),
-};
-
-/* VPLL2 for digital video outputs */
-static struct regulator_consumer_supply sdp3430_vpll2_supplies[] = {
-	REGULATOR_SUPPLY("vdds_dsi", "omapdss"),
-	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi1"),
-};
-
 static struct regulator_consumer_supply sdp3430_vmmc1_supplies[] = {
 	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0"),
 };
@@ -531,8 +521,8 @@ static struct regulator_init_data sdp3430_vdac = {
 		.valid_ops_mask		= REGULATOR_CHANGE_MODE
 					| REGULATOR_CHANGE_STATUS,
 	},
-	.num_consumer_supplies	= ARRAY_SIZE(sdp3430_vdda_dac_supplies),
-	.consumer_supplies	= sdp3430_vdda_dac_supplies,
+	.num_consumer_supplies	= ARRAY_SIZE(omap_std_vdda_dac_supplies),
+	.consumer_supplies	= omap_std_vdda_dac_supplies,
 };
 
 static struct regulator_init_data sdp3430_vpll2 = {
@@ -546,8 +536,8 @@ static struct regulator_init_data sdp3430_vpll2 = {
 		.valid_ops_mask		= REGULATOR_CHANGE_MODE
 					| REGULATOR_CHANGE_STATUS,
 	},
-	.num_consumer_supplies	= ARRAY_SIZE(sdp3430_vpll2_supplies),
-	.consumer_supplies	= sdp3430_vpll2_supplies,
+	.num_consumer_supplies	= ARRAY_SIZE(omap_std_vdds_dsi_supplies),
+	.consumer_supplies	= omap_std_vdds_dsi_supplies,
 };
 
 static struct twl4030_codec_audio_data sdp3430_audio;
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 570e83f..bef42bb 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -373,10 +373,6 @@ static struct regulator_consumer_supply sdp4430_vmmc_supply[] = {
 		.dev_name = "omap_hsmmc.0",
 	},
 };
-static struct regulator_consumer_supply sdp4430_vcxio_supply[] = {
-	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dss"),
-	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi1"),
-};
 
 static int omap4_twl6030_hsmmc_late_init(struct device *dev)
 {
@@ -525,8 +521,8 @@ static struct regulator_init_data sdp4430_vcxio = {
 					| REGULATOR_CHANGE_STATUS,
 		.always_on	= true,
 	},
-	.num_consumer_supplies	= ARRAY_SIZE(sdp4430_vcxio_supply),
-	.consumer_supplies	= sdp4430_vcxio_supply,
+	.num_consumer_supplies	= ARRAY_SIZE(omap_std_vdds_dsi_supplies),
+	.consumer_supplies	= omap_std_vdds_dsi_supplies,
 };
 
 static struct regulator_init_data sdp4430_vdac = {
diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 7dc836e..98a4863 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -21,11 +21,22 @@
 #include <linux/io.h>
 #include <linux/clk.h>
 #include <linux/err.h>
+#include <linux/regulator/machine.h>
 
 #include <plat/display.h>
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
 
+struct regulator_consumer_supply omap_std_vdda_dac_supplies[] = {
+	REGULATOR_SUPPLY("vdda_dac", "omapdss_venc"),
+};
+
+struct regulator_consumer_supply omap_std_vdds_dsi_supplies[] = {
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dss"),
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi1"),
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi2"),
+};
+
 static struct platform_device omap_display_device = {
 	.name          = "omapdss",
 	.id            = -1,
diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index bd0f08e..bd8c302 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -24,6 +24,7 @@
 #include <linux/kobject.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/machine.h>
 #include <asm/atomic.h>
 
 #define DISPC_IRQ_FRAMEDONE		(1 << 0)
@@ -248,6 +249,9 @@ static inline int omap_display_init(struct omap_dss_board_info *board_data)
 }
 #endif
 
+extern struct regulator_consumer_supply omap_std_vdda_dac_supplies[1];
+extern struct regulator_consumer_supply omap_std_vdds_dsi_supplies[3];
+
 struct omap_display_platform_data {
 	struct omap_dss_board_info *board_data;
 	/* TODO: Additional members to be added when PM is considered */


