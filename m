From: "arun c" <arun.edarath@gmail.com>
Subject: Re: OMAP3EVM LCD red tint
Date: Sat, 27 Sep 2008 03:46:18 -0400
Message-ID: <c656a4d20809270046u341aec27k6d896d4b42e799d4@mail.gmail.com>
References: <48DD441F.6080106@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.186]:25868 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397AbYI0HqU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 27 Sep 2008 03:46:20 -0400
Received: by ti-out-0910.google.com with SMTP id b6so530086tic.23
        for <linux-omap@vger.kernel.org>; Sat, 27 Sep 2008 00:46:18 -0700 (PDT)
In-Reply-To: <48DD441F.6080106@timesys.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Schaeffer <daniel.schaeffer@timesys.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Daniel Schaeffer

On Fri, Sep 26, 2008 at 4:20 PM, Daniel Schaeffer
<daniel.schaeffer@timesys.com> wrote:
> Has anyone looked into why the LCD display on the OMAP3EVM is always tinted
> red? I created a couple of color test images that I cat'ed to /dev/fb and it
> looks like the blue color channel is completely ignored.  I was testing on
> v2.6.26-omap2 but is doesn't look like there have been any changes to the fb
> driver since then so I'm assuming the issue is also present in the head of
> the git tree.
>
> Regards,
>
> Daniel Schaeffer
>

Try the patch below(Remember that you may have to manually edit because
this patch is against current HEAD)


diff --git a/drivers/video/omap/lcd_omap3evm.c
b/drivers/video/omap/lcd_omap3evm.c
index a564ca5..821bafe 100644
--- a/drivers/video/omap/lcd_omap3evm.c
+++ b/drivers/video/omap/lcd_omap3evm.c
@@ -44,6 +44,8 @@
 #define ENABLE_VDAC_DEV_GRP	0x20
 #define ENABLE_VPLL2_DEDICATED	0x05
 #define ENABLE_VPLL2_DEV_GRP	0xE0
+#define TWL4030_VPLL2_DEV_GRP	0x33
+#define TWL4030_VPLL2_DEDICATED	0x36

 #define TWL_LED_LEDEN		0x00
 #define TWL_PWMA_PWMAON		0x00
@@ -86,12 +88,24 @@ static void omap3evm_panel_cleanup(struct lcd_panel *panel)

 static int omap3evm_panel_enable(struct lcd_panel *panel)
 {
+	if (system_rev > OMAP3430_REV_ES1_0) {
+		twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+			ENABLE_VPLL2_DEDICATED, TWL4030_VPLL2_DEDICATED);
+		twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+			ENABLE_VPLL2_DEV_GRP, TWL4030_VPLL2_DEV_GRP);
+	}
 	omap_set_gpio_dataout(LCD_PANEL_ENABLE_GPIO, 0);
 	return 0;
 }

 static void omap3evm_panel_disable(struct lcd_panel *panel)
 {
+	if (system_rev > OMAP3430_REV_ES1_0) {
+		twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0x0,
+			TWL4030_VPLL2_DEDICATED);
+		twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0x0,
+			TWL4030_VPLL2_DEV_GRP);
+	}
 	omap_set_gpio_dataout(LCD_PANEL_ENABLE_GPIO, 1);
 }


Regards,
Arun C
