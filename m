From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v3] ARM: kill off set_irq_flags usage
Date: Tue, 28 Jul 2015 14:00:53 +0200
Message-ID: <20150728120053.GB21866@localhost>
References: <1438030523-15853-1-git-send-email-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1438030523-15853-1-git-send-email-robh@kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: arm@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Russell King <linux@arm.linux.org.uk>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Sascha Hauer <kernel@pengutronix.de>, Imre Kaloz <kaloz@openwrt.org>, Greg Ungerer <gerg@uclinux.org>, Roland Stigge <stigge@antcom.de>, Tony Lindgren <tony@atomide.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Simtec Linux Team <linux@simtec.co.uk>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jul 27, 2015 at 03:55:13PM -0500, Rob Herring wrote:
> set_irq_flags is ARM specific with custom flags which have genirq
> equivalents. Convert drivers to use the genirq interfaces directly, so we
> can kill off set_irq_flags. The translation of flags is as follows:
> 
> IRQF_VALID -> !IRQ_NOREQUEST
> IRQF_PROBE -> !IRQ_NOPROBE
> IRQF_NOAUTOEN -> IRQ_NOAUTOEN
> 
> For IRQs managed by an irqdomain, the irqdomain core code handles clearing
> and setting IRQ_NOREQUEST already, so there is no need to do this in
> .map() functions and we can simply remove the set_irq_flags calls. Some
> users also modify IRQ_NOPROBE and this has been maintained although it
> is not clear that is really needed. There appears to be a great deal of
> blind copy and paste of this code.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Acked-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
> Acked-by: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Imre Kaloz <kaloz@openwrt.org>
> Acked-by: Krzysztof Halasa <khalasa@piap.pl>
> Cc: Greg Ungerer <gerg@uclinux.org>
> Cc: Roland Stigge <stigge@antcom.de>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Daniel Mack <daniel@zonque.org>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> Cc: Simtec Linux Team <linux@simtec.co.uk>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Acked-by: Wan ZongShun <mcuos.com@gmail.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-omap@vger.kernel.org
> Cc: linux-samsung-soc@vger.kernel.org
> Tested-by: Kevin Hilman <khilman@linaro.org>
> ---
> Thomas asked that this be merged thru subsystem trees instead of arm-soc,
> so please apply just this patch to your tree.

"this be merged through subsystem trees" + "please apply just this
patch". I'm going to assume that the first "this" means a patch series. So
I've applied this to next/cleanup, let me know if this was in error and
should be removed, it's easy to drop at this time.


-Olof
