From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH 0/5] GPIO OMAP driver changes for v3.16
Date: Thu, 10 Apr 2014 22:30:48 +0300
Message-ID: <20140410193048.GE15736@drone.musicnaut.iki.fi>
References: <1396796297-13002-1-git-send-email-javier.martinez@collabora.co.uk>
 <CACRpkdarYt4tAD9WMDu6Me+dhipVyDHMpgF-AQ8SDNKMmhSjsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdarYt4tAD9WMDu6Me+dhipVyDHMpgF-AQ8SDNKMmhSjsA@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Nishanth Menon <nm@ti.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Thu, Apr 10, 2014 at 07:29:26PM +0200, Linus Walleij wrote:
> On Sun, Apr 6, 2014 at 4:58 PM, Javier Martinez Canillas
> <javier.martinez@collabora.co.uk> wrote:
> 
> > Now that you have sent your changes for v3.15 to Torvalds, here are some
> > changes for the OMAP GPIO driver targeted to v3.16. Mostly improvements
> > so nothing here is -rc material.
> 
> I like this series so I have applied them for v3.16, pending some ACK
> from Kevin &| Santosh.

I tried these patches on OMAP1 on top of today's Torvalds git
(4ba85265790ba3681deeaf73f018c0eb829a7341).

On Amstrad E3 I'm getting the following logs:

[    0.156491] omap_gpio omap_gpio.0: Runtime PM disabled, clock forced on.
[    0.164604] genirq: Setting trigger mode 0 for irq 64 failed (gpio_irq_type+0x0/0x1f0)
[    0.165418] genirq: Setting trigger mode 0 for irq 65 failed (gpio_irq_type+0x0/0x1f0)
[    0.166133] genirq: Setting trigger mode 0 for irq 66 failed (gpio_irq_type+0x0/0x1f0)
[    0.166838] genirq: Setting trigger mode 0 for irq 67 failed (gpio_irq_type+0x0/0x1f0)
[...]
[    0.182856] genirq: Setting trigger mode 0 for irq 79 failed (gpio_irq_type+0x0/0x1f0)
[    0.186887] omap_gpio omap_gpio.1: Could not get gpio dbck
[    0.189308] genirq: Setting trigger mode 0 for irq 95 failed (gpio_irq_type+0x0/0x1f0)
[...]
[    0.203121] genirq: Setting trigger mode 0 for irq 110 failed (gpio_irq_type+0x0/0x1f0)

However it still seems to work. The serio is only GPIO IRQ and it
triggers when I press the external keyboard.

The same happens also on Nokia 770:

[    0.118896] genirq: Setting trigger mode 0 for irq 128 failed (gpio_irq_type+0x0/0x220)
[    0.119201] genirq: Setting trigger mode 0 for irq 129 failed (gpio_irq_type+0x0/0x220)
[...]
[    0.124999] genirq: Setting trigger mode 0 for irq 143 failed (gpio_irq_type
+0x0/0x220)
[    0.126831] omap_gpio omap_gpio.1: Could not get gpio dbck
[    0.127258] OMAP GPIO hardware version 1.1
[    0.127624] omap_gpio omap_gpio.2: Could not get gpio dbck
[    0.128204] omap_gpio omap_gpio.3: Could not get gpio dbck
[    0.128753] omap_gpio omap_gpio.4: Could not get gpio dbck

Here also GPIO IRQs (touchscreen, Retu) still work.

A.
