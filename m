From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 1/5] gpiolib: introduce set_debounce method
Date: Fri, 21 May 2010 09:49:25 +0300
Message-ID: <20100521064925.GF925@nokia.com>
References: <20100520194509.GB10739@sirena.org.uk>
 <598314.1671.qm@web180305.mail.gq1.yahoo.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <598314.1671.qm@web180305.mail.gq1.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ext David Brownell <david-b@pacbell.net>
Cc: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

On Fri, May 21, 2010 at 12:50:41AM +0200, ext David Brownell wrote:
>
>> This would be generally useful for embedded systems,
>> especially where the interrupt concerned is a wake source.
>>=A0 It allows drivers to avoid
>> spurious interrupts from noisy sources so if the hardware
>> supports it
>> the driver can avoid having to explicitly wait for the
>> signal to become
>> stable and software has to cope with fewer events.
>
>True.
>
>Not all GPIOs have hardware debounce though, so offering this
>capability sort of begs the question of where/how to provide a
>software debounce mechanism too...

how about adding a flag for supported features and if that hardware=20
doesn't support we simply return, or fallback to software emulation if=20
chosen by the user. Something like the feature flags for the i2c bus=20
drivers.

I mean something like:

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 95f92b0..ae03f6f 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -1855,6 +1855,7 @@ static int __init _omap_gpio_init(void)
                 bank->chip.get =3D gpio_get;
                 bank->chip.direction_output =3D gpio_output;
                 bank->chip.set_debounce =3D gpio_debounce;
+               bank->chip->flags =3D GPIO_FLAG_DEBOUNCE;
                 bank->chip.set =3D gpio_set;
                 bank->chip.to_irq =3D gpio_2irq;
                 if (bank_is_mpuio(bank)) {
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index cd85fd1..ed1ed74 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1461,9 +1461,14 @@ int gpio_set_debounce(unsigned gpio, unsigned de=
bounce)
 =20
         spin_lock_irqsave(&gpio_lock, flags);
 =20
+       chip =3D desc->chip;
+       if (!(chip->flags & GPIO_FLAG_DEBOUNCE)) {
+               spin_unlock_irqrestore(&gpio_lock, flags);
+               return 0;
+       }
+
         if (!gpio_is_valid(gpio))
                 goto fail;
-       chip =3D desc->chip;
         if (!chip || !chip->set || !chip->set_debounce)
                 goto fail;
         gpio -=3D chip->base;
diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
index ce3eb87..26c0aa2 100644
--- a/include/asm-generic/gpio.h
+++ b/include/asm-generic/gpio.h
@@ -32,6 +32,8 @@ struct device;
  struct seq_file;
  struct module;
 =20
+#define GPIO_FLAG_DEBOUNCE     (1 << 0)
+
  /**
   * struct gpio_chip - abstract a GPIO controller
   * @label: for diagnostics
@@ -61,6 +63,7 @@ struct module;
   *      names for the GPIOs in this chip. Any entry in the array
   *      may be NULL if there is no alias for the GPIO, however the
   *      array must be @ngpio entries long.
+ * @flags: a bitmap for supported features by that particular gpio chi=
p.
   *
   * A gpio_chip can help platforms abstract various sources of GPIOs s=
o
   * they can all be accessed through a common programing interface.
@@ -104,6 +107,7 @@ struct gpio_chip {
         char                    **names;
         unsigned                can_sleep:1;
         unsigned                exported:1;
+       unsigned                flags;
  };
 =20
  extern const char *gpiochip_is_requested(struct gpio_chip *chip,

that could be used later for adding debounce emulation for chips that=20
doesn't support hw debouncing.

--=20
balbi

DefectiveByDesign.org
