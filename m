From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v2 01/13] ARM: kill off set_irq_flags usage
Date: Mon, 13 Jul 2015 11:19:01 +0800
Message-ID: <20150713031901.GM23464@tiger>
References: <1436711211-18223-1-git-send-email-robh@kernel.org>
 <1436711211-18223-2-git-send-email-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1436711211-18223-2-git-send-email-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Andrew Lunn <andrew@lunn.ch>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kevin Hilman <khilman@deeprootsystems.com>, Sekhar Nori <nsekhar@ti.com>, Greg Ungerer <gerg@uclinux.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Roland Stigge <stigge@antcom.de>, linux-samsung-soc@vger.kernel.org, Tony Lindgren <tony@atomide.com>, arm@kernel.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jason Cooper <jason@lakedaemon.net>, Haojian Zhuang <haojian.zhuang@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux-omap@vger.kernel.org, Simtec Linux Team <linux@simtec.co.uk>, Shawn Guo <shawn.guo@linaro.org>, linux-kernel@vger.kernel.org, Kukjin Kim <kgene@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Imre Kaloz <kaloz@openwrt.org>, Daniel Mack <daniel@zonque.org>
List-Id: linux-omap@vger.kernel.org

On Sun, Jul 12, 2015 at 09:26:39AM -0500, Rob Herring wrote:
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
> users also set IRQ_NOPROBE and this has been maintained although it is not
> clear that is really needed. There appears to be a great deal of blind
> copy and paste of this code.
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
> Cc: Shawn Guo <shawn.guo@linaro.org>
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
...
>  arch/arm/mach-imx/3ds_debugboard.c   |  2 +-
>  arch/arm/mach-imx/mach-mx31ads.c     |  2 +-

Acked-by: Shawn Guo <shawnguo@kernel.org>
