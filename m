From: Pascal Huerst <pascal.huerst@gmail.com>
Subject: gpio-omap: wakeup mask
Date: Wed, 02 Jul 2014 14:09:43 +0200
Message-ID: <53B3F687.5050502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: santosh.shilimkar@ti.com
Cc: khilman@deeprootsystems.com, linus.walleij@linaro.org, gnurou@gmail.com, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>
List-Id: linux-omap@vger.kernel.org

Hi everyone,

we have a device with an am335x and are using some gpios on bank0 to
wake up the device from suspend to ram.

We have some user buttons which are configured in the devicetree as
gpio-keys and one power-key which should wake up the device:

&buttons {
        power {
                label = "Power";
                gpios = <&gpio0 6 1>;
                linux,code = <116>;
                gpio-key,wakeup;
        };

        one {
                label = "One";
                gpios = <&gpio0 11 1>;
                linux,code = <2>;
        };

        : : :
}

The problem is, that the device wakes up on any trigger on bank 0. No
matter which button was pressed. "gpio-key,wakeup" seems not to have any
influence.

Now, if I comment the following lines out in drivers/gpio/gpio-omap.c :
set_gpio_trigger(...).

321
322 if (likely(!(bank->non_wakeup_gpios & gpio_bit))) {
323    _gpio_rmw(base, bank->regs->wkup_en, gpio_bit, trigger != 0);
324      bank->context.wake_en =
325        readl_relaxed(bank->base + bank->regs->wkup_en);
326 }
327

Everything works as expected. But I don't really understand why? Is this
a bug, or does this break something else I have not discovered yet?

Thanks,
Pascal
