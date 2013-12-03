From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 5/8] gpio: twl4030: Fix regression for twl gpio output
Date: Tue, 3 Dec 2013 15:30:11 +0200
Message-ID: <529DDCE3.5020902@ti.com>
References: <1384396537-3486-1-git-send-email-tony@atomide.com> <1384396537-3486-6-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1384396537-3486-6-git-send-email-tony@atomide.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-gpio@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 11/14/2013 04:35 AM, Tony Lindgren wrote:
> Commit c111feabe2e2 (gpio: twl4030: Cache the direction and output
> states in private data) improved things in general, but caused a
> regression for setting the GPIO output direction.
> 
> The change reorganized twl_direction_out() and twl_set() and swapped
> the function names around in the process. While doing that, a bug got
> introduced that's not obvious while reading the patch as it appears
> as no change to the code.
> 
> The bug is we now call function twl4030_set_gpio_dataout() twice in
> both twl_direction_out() and twl_set(). Instead, we should first
> call twl_direction_out() in twl_direction_out() followed by
> twl4030_set_gpio_dataout() in twl_set().
> 
> This regression probably has gone unnoticed for a long time as the
> bootloader may have set the GPIO direction properly in many cases.
> This fixes at least the LCD panel not turning on omap3 LDP for
> example.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: linux-gpio@vger.kernel.org
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> 
> If this looks OK, I'd like to merge this as a fix via arm-soc tree
> along with the other patches in this series as my later patches
> depend on patches in this series.

This patch causes a regression with LED outputs (GPO) on twl4030 on 3.13-rc2.
As one of the LED GPO is used for USB host on beagleboard, it will cause failure
of USB host probe.

I'll explain why below.
> 
> ---
>  drivers/gpio/gpio-twl4030.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-twl4030.c b/drivers/gpio/gpio-twl4030.c
> index 0c7e891..5738d5a 100644
> --- a/drivers/gpio/gpio-twl4030.c
> +++ b/drivers/gpio/gpio-twl4030.c
> @@ -354,17 +354,18 @@ static void twl_set(struct gpio_chip *chip, unsigned offset, int value)
>  static int twl_direction_out(struct gpio_chip *chip, unsigned offset, int value)
>  {
>  	struct gpio_twl4030_priv *priv = to_gpio_twl4030(chip);
> +	int ret = -EINVAL;
>  
>  	mutex_lock(&priv->mutex);
>  	if (offset < TWL4030_GPIO_MAX)
> -		twl4030_set_gpio_dataout(offset, value);
> +		ret = twl4030_set_gpio_direction(offset, 0);

twl_direction_out() is supposed to return 0 on success and non-zero only on failure.

for (offset >= TWL4030_GPIO_MAX) i.e. LED output case we now return -EINVAL, which
causes the LED GPO set_direction_out to fail. LED outputs are always outputs so
this function shouldn't fail.

>  
>  	priv->direction |= BIT(offset);
>  	mutex_unlock(&priv->mutex);
>  
>  	twl_set(chip, offset, value);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static int twl_to_irq(struct gpio_chip *chip, unsigned offset)
> 


Below is a proposed fix for this.

>From 7c36c8952ee3c7220ea21396cd3f84a1f9e9ea73 Mon Sep 17 00:00:00 2001
From: Roger Quadros <rogerq@ti.com>
Date: Tue, 3 Dec 2013 15:24:05 +0200
Subject: [PATCH] gpio: twl4030: Fix regression for twl gpio LED output

Commit 0b2aa8be introduced a regression that causes failure
in setting LED GPO direction to OUT.

This causes USB host probe failures for Beagleboard C4.

[    2.075469] platform usb_phy_gen_xceiv.2: Driver usb_phy_gen_xceiv requests probe deferral
[    2.090454] hsusb2_vcc: Failed to request enable GPIO510: -22
[    2.100982] reg-fixed-voltage reg-fixed-voltage.0.auto: Failed to register regulator: -22
[    2.109954] reg-fixed-voltage: probe of reg-fixed-voltage.0.auto failed with error -22

direction_out/direction_in must return 0 if the operation succeeded.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/gpio/gpio-twl4030.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-twl4030.c b/drivers/gpio/gpio-twl4030.c
index b97d6a6..0999ed1 100644
--- a/drivers/gpio/gpio-twl4030.c
+++ b/drivers/gpio/gpio-twl4030.c
@@ -294,13 +294,13 @@ out:
 static int twl_direction_in(struct gpio_chip *chip, unsigned offset)
 {
 	struct gpio_twl4030_priv *priv = to_gpio_twl4030(chip);
-	int ret;
+	int ret = 0;
 
 	mutex_lock(&priv->mutex);
 	if (offset < TWL4030_GPIO_MAX)
-		ret = twl4030_set_gpio_direction(offset, 1);
+		twl4030_set_gpio_direction(offset, 1);
 	else
-		ret = -EINVAL;
+		ret = -EINVAL;	/* LED outputs can't be set as input */
 
 	if (!ret)
 		priv->direction &= ~BIT(offset);
@@ -354,18 +354,21 @@ static void twl_set(struct gpio_chip *chip, unsigned offset, int value)
 static int twl_direction_out(struct gpio_chip *chip, unsigned offset, int value)
 {
 	struct gpio_twl4030_priv *priv = to_gpio_twl4030(chip);
-	int ret = -EINVAL;
 
 	mutex_lock(&priv->mutex);
 	if (offset < TWL4030_GPIO_MAX)
-		ret = twl4030_set_gpio_direction(offset, 0);
+		twl4030_set_gpio_direction(offset, 0);
+
+	/*
+	 *  LED gpio's i.e. offset >= TWL4030_GPIO_MAX are always output
+	 */
 
 	priv->direction |= BIT(offset);
 	mutex_unlock(&priv->mutex);
 
 	twl_set(chip, offset, value);
 
-	return ret;
+	return 0;
 }
 
 static int twl_to_irq(struct gpio_chip *chip, unsigned offset)
-- 
1.8.3.2


