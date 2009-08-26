From: "Varadarajan, Charu Latha" <charu@ti.com>
Subject: RE: [PATCH v2 4/4] RTC MSECURE: mux configuration in board files
Date: Wed, 26 Aug 2009 10:53:35 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BA31ACEB@dbde02.ent.ti.com>
References: <19F8576C6E063C45BE387C64729E73940436A49FB0@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55791 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753273AbZHZFXo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Aug 2009 01:23:44 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E73940436A49FB0@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "david-b@pacbell.net" <david-b@pacbell.net>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "p_gortmaker@yahoo.com" <p_gortmaker@yahoo.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Vikram,
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Pandita, Vikram
> Sent: Tuesday, August 25, 2009 11:54 PM
> To: Varadarajan, Charu Latha; linux-omap@vger.kernel.org
> Cc: tony@atomide.com; david-b@pacbell.net; sameo@linux.intel.com;
> p_gortmaker@yahoo.com; Varadarajan, Charu Latha
> Subject: RE: [PATCH v2 4/4] RTC MSECURE: mux configuration in board files
>
> Charu
>
> >-----Original Message-----
> >From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of
> >charu@ti.com
> >Sent: Monday, August 24, 2009 10:08 AM
> >To: linux-omap@vger.kernel.org
> >Cc: tony@atomide.com; david-b@pacbell.net; sameo@linux.intel.com;
> p_gortmaker@yahoo.com; Varadarajan,
> >Charu Latha
> >Subject: [PATCH v2 4/4] RTC MSECURE: mux configuration in board files
> >
> >
> > static struct i2c_board_info __initdata sdp2430_i2c_boardinfo[] = {
> >diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-
> 3430sdp.c
> >index 351e8c5..1bb79f5 100644
> >--- a/arch/arm/mach-omap2/board-3430sdp.c
> >+++ b/arch/arm/mach-omap2/board-3430sdp.c
> >@@ -54,7 +54,7 @@
> > #define ENABLE_VAUX3_DEDICATED      0x03
> > #define ENABLE_VAUX3_DEV_GRP        0x20
> >
> >-#define TWL4030_MSECURE_GPIO 22
> >+#define TWL4030_MSECURE_GPIO        22
> >
> > static int sdp3430_keymap[] = {
> >     KEY(0, 0, KEY_LEFT),
> >@@ -574,8 +574,24 @@ static inline void board_smc91x_init(void)
> >
> > #endif
> >
> >+int sdp3430_rtc_init(void)
> >+{
> >+    struct twl4030_rtc_platform_data sdp3430_rtc_data;
> >+    /* msecure mux cfg */
> >+    if (omap_type() == OMAP2_DEVICE_TYPE_GP &&
> >+                    omap_rev() < OMAP3430_REV_ES2_0) {
>
> What happens to msecure line on SDP/LDP with ES2.0 and above?
The default value is NULL, hence no need to reinitialize. FYI, the patch was tested on 
SDP boards with greater than ES2.0 version silicon. 
>
> Is it that Triton MSECURE line gets pulled up by default, and hence no need
> for the patch?
>
Msecure initialization is not required for such boards.
>
> >+            sdp3430_rtc_data.msecure_gpio = TWL4030_MSECURE_GPIO;
> >+            sdp3430_twldata.rtc = &sdp3430_rtc_data;
> >+            return omap_cfg_reg(AF9_34XX_V1_X_GPIO22_OUT);
> >+    } else
> >+            return 0;
> >+};
> >+
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
p