From: Thomas Weber <weber@corscience.de>
Subject: Re: [PATCH 0/3] omap3: devkit8000: misc fixes
Date: Fri, 14 Jan 2011 09:48:08 +0100
Message-ID: <4D300DC8.7000803@corscience.de>
References: <1294963409-29891-1-git-send-email-daniel.morsing@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:49289 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478Ab1ANIsL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Jan 2011 03:48:11 -0500
In-Reply-To: <1294963409-29891-1-git-send-email-daniel.morsing@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Morsing <daniel.morsing@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Am 14.01.2011 01:03, schrieb Daniel Morsing:
> Here is a set of misc fixes for the devkit8000.
>
> The only really notable one is the lcd enable gpio fix. It gets rid
> of some nasty low level twl4030 calls and replaces them with generic gpio
> calls. It also fixes a bug where the screen would not turn off when
> blanking.
>
> Daniel Morsing (3):
>   omap3: devkit8000: Fix indentation issue
>   omap3: devkit8000: fix tps65930 pullup/pulldown configuration
>   omap3: devkit8000: Use generic gpio for second lcd enable
>
>  arch/arm/mach-omap2/board-devkit8000.c |   26 ++++++++++++++++++++------
>  1 files changed, 20 insertions(+), 6 deletions(-)
>

Hello Daniel,

the LCD_PWREN is connected to TWL4030 LEDA only.
The TWL4030 GPIO.1 has a not connected resistor (R61).

My test case is:

# echo 0 > /sys/devices/omapdss/display0/enabled
# echo 1 > /sys/devices/omapdss/display0/enabled


I changed your patch the following way.
I think I cannot write a sign-off-by for you.

Thomas

-----

commit b93fb7d72993e20de4cedb9393dda793c88c7deb
Author: Daniel Morsing <daniel.morsing@gmail.com>
Date:   Fri Jan 14 00:03:29 2011 +0000

    OMAP3: Devkit8000: Use generic gpio for lcd power pin
   
    The reset_gpio pin for lcd is connected with TWL4030 LedA.
    The TWL4030 GPIO.1 has a not connected resistor in the line.
   
    Reported-by: Daniel Morsing <daniel.morsing@gmail.com>
    Signed-off-by: Thomas Weber <weber@corscience.de>

diff --git a/arch/arm/mach-omap2/board-devkit8000.c
b/arch/arm/mach-omap2/board-devkit8000.c
index 8dc7a24..54f1f7f 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -114,9 +114,6 @@ static struct omap2_hsmmc_info mmc[] = {
 
 static int devkit8000_panel_enable_lcd(struct omap_dss_device *dssdev)
 {
-       twl_i2c_write_u8(TWL4030_MODULE_GPIO, 0x80, REG_GPIODATADIR1);
-       twl_i2c_write_u8(TWL4030_MODULE_LED, 0x0, 0x0);
-
        if (gpio_is_valid(dssdev->reset_gpio))
                gpio_set_value_cansleep(dssdev->reset_gpio, 1);
        return 0;
@@ -245,8 +242,8 @@ static int devkit8000_twl_gpio_setup(struct device *dev,
        /* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
        gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
 
-       /* gpio + 1 is "LCD_PWREN" (out, active high) */
-       devkit8000_lcd_device.reset_gpio = gpio + 1;
+       /* TWL4030_GPIO_MAX + 0 is "LCD_PWREN" (out, active high) */
+       devkit8000_lcd_device.reset_gpio = gpio + TWL4030_GPIO_MAX + 0;
        gpio_request(devkit8000_lcd_device.reset_gpio, "LCD_PWREN");
        /* Disable until needed */
        gpio_direction_output(devkit8000_lcd_device.reset_gpio, 0);

