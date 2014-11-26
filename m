From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 2/3] soc: ti: Add wkup_m3_ipc driver
Date: Wed, 26 Nov 2014 22:51:50 +0100
Message-ID: <2763467.KfXHXHxPJd@wuerfel>
References: <cover.1417029919.git.d-gerlach@ti.com> <3334d8483dca2d061cf43da9c047ec27f31e8719.1417029919.git.d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3334d8483dca2d061cf43da9c047ec27f31e8719.1417029919.git.d-gerlach@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Dave Gerlach <d-gerlach@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>
List-Id: linux-omap@vger.kernel.org

On Wednesday 26 November 2014 15:38:09 Dave Gerlach wrote:
> +
> +static const struct wkup_m3_wakeup_src wakeups[] = {
> +       {.irq_nr = 35,  .src = "USB0_PHY"},
> +       {.irq_nr = 36,  .src = "USB1_PHY"},
> +       {.irq_nr = 40,  .src = "I2C0"},
> +       {.irq_nr = 41,  .src = "RTC Timer"},
> +       {.irq_nr = 42,  .src = "RTC Alarm"},
> +       {.irq_nr = 43,  .src = "Timer0"},
> +       {.irq_nr = 44,  .src = "Timer1"},
> +       {.irq_nr = 45,  .src = "UART"},
> +       {.irq_nr = 46,  .src = "GPIO0"},
> +       {.irq_nr = 48,  .src = "MPU_WAKE"},
> +       {.irq_nr = 49,  .src = "WDT0"},
> +       {.irq_nr = 50,  .src = "WDT1"},
> +       {.irq_nr = 51,  .src = "ADC_TSC"},
> +       {.irq_nr = 0,   .src = "Unknown"},
> +};
> 

This seems awfully specific to some SoC version, and not aware of
IRQ domains. It also seems to be only used in a dev_dbg statement,
so I guess you could just kill this off entirely.

> +static struct rproc *wkup_m3_get_rproc(struct device *dev)
> +{
> +       struct device_node *node;
> +       struct rproc *rp;
> +
> +       node = of_parse_phandle(dev->of_node, "ti,rproc", 0);
> +       if (!node)
> +               return NULL;
> +
> +       dev = bus_find_device(&platform_bus_type, NULL, node, match);
> +       if (!dev)
> +               return NULL;
> +
> +       rp = dev_get_drvdata(dev);
> +       return rp;

This is wrong on a number of levels. I suspect what you really want
is an interface exported from drivers/remoteproc that looks up
a 'struct rproc' and performs the necessary reference counting.

That one can just use of_find_node_by_phandle() to get to
a device_node and use that to look up the rproc device in
a linked list it maintains.

	Arnd
