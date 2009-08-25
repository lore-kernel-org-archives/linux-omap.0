From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH v2 4/4] RTC MSECURE: mux configuration in board files
Date: Tue, 25 Aug 2009 23:54:14 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F996ECD8@dbde02.ent.ti.com>
References: <1251126455-27258-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45410 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755531AbZHYSY1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Aug 2009 14:24:27 -0400
In-Reply-To: <1251126455-27258-1-git-send-email-charu@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>, "david-b@pacbell.net" <david-b@pacbell.net>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "p_gortmaker@yahoo.com" <p_gortmaker@yahoo.com>, "Varadarajan, Charu Latha" <charu@ti.com>

Charu

>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
>charu@ti.com
>Sent: Monday, August 24, 2009 10:08 AM
>To: linux-omap@vger.kernel.org
>Cc: tony@atomide.com; david-b@pacbell.net; sameo@linux.intel.com; p_gortmaker@yahoo.com; Varadarajan,
>Charu Latha
>Subject: [PATCH v2 4/4] RTC MSECURE: mux configuration in board files
>
>
> static struct i2c_board_info __initdata sdp2430_i2c_boardinfo[] = {
>diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
>index 351e8c5..1bb79f5 100644
>--- a/arch/arm/mach-omap2/board-3430sdp.c
>+++ b/arch/arm/mach-omap2/board-3430sdp.c
>@@ -54,7 +54,7 @@
> #define ENABLE_VAUX3_DEDICATED	0x03
> #define ENABLE_VAUX3_DEV_GRP	0x20
>
>-#define TWL4030_MSECURE_GPIO 22
>+#define TWL4030_MSECURE_GPIO	22
>
> static int sdp3430_keymap[] = {
> 	KEY(0, 0, KEY_LEFT),
>@@ -574,8 +574,24 @@ static inline void board_smc91x_init(void)
>
> #endif
>
>+int sdp3430_rtc_init(void)
>+{
>+	struct twl4030_rtc_platform_data sdp3430_rtc_data;
>+	/* msecure mux cfg */
>+	if (omap_type() == OMAP2_DEVICE_TYPE_GP &&
>+			omap_rev() < OMAP3430_REV_ES2_0) {

What happens to msecure line on SDP/LDP with ES2.0 and above?

Is it that Triton MSECURE line gets pulled up by default, and hence no need for the patch?


>+		sdp3430_rtc_data.msecure_gpio = TWL4030_MSECURE_GPIO;
>+		sdp3430_twldata.rtc = &sdp3430_rtc_data;
>+		return omap_cfg_reg(AF9_34XX_V1_X_GPIO22_OUT);
>+	} else
>+		return 0;
>+};
>+
