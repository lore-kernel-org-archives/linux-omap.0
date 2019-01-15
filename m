From: Tony Lindgren <tony@atomide.com>
Subject: Regression in v5.0-rc with regmap-irq level-irq changes
Date: Tue, 15 Jan 2019 11:28:40 -0800
Message-ID: <20190115192840.GK5544@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Mark Brown <broonie@kernel.org>
Cc: Belisko Marek <marek.belisko@gmail.com>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, Jon Hunter <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, Keerthy <j-keerthy@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tero Kristo <t-kristo@ti.com>, Thierry Reding <treding@nvidia.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

Looks like commit 1c2928e3e321 ("regmap: regmap-irq/gpio-max77620: add
level-irq support") caused a regression at least with palmas PMIC where
child interrupt no longer work and we get something like this on
omap5-uevm for example:

genirq: Setting trigger mode 3 for irq 157 failed
(regmap_irq_set_type+0x0/0x15c)
genirq: Setting trigger mode 12 for irq 154 failed
(regmap_irq_set_type+0x0/0x15c)
genirq: Setting trigger mode 8 for irq 149 failed
(regmap_irq_set_type+0x0/0x15c)

These are for child devices like power button, USB and RTC interrupts.
I'd also assume GPIOs might be broken now.

Any ideas what's needed? Some triggering mapping data to palmas.c
driver?

To me it seems the child device interrupt triggering can be whatever
the hardware supports including IRQ_TYPE_NONE for non-configurable
interrupts. Additionally palmas.c supports inverting the SoC
interrupt also.

Not sure if other things are broken now too, it might be worth
grepping the logs at kernelci.org for similar genirq errors above?

Regards,

Tony
