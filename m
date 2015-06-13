From: Wan ZongShun <mcuos.com@gmail.com>
Subject: Re: [PATCH 01/15] ARM: kill off set_irq_flags usage
Date: Sat, 13 Jun 2015 19:32:20 +0800
Message-ID: <CAKT61h_EJgF926gmu0QZB=YHYSC+jWQA86yQ0e2T_4MtOvbXFg@mail.gmail.com>
References: <1433874401-27161-1-git-send-email-robh@kernel.org> <1433874401-27161-2-git-send-email-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1433874401-27161-2-git-send-email-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, arm@kernel.org, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Hans Ulli Kroll <ulli.kroll@googlemail.com>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Imre Kaloz <kaloz@openwrt.org>, Krzysztof Halasa <khalasa@piap.pl>, Greg Ungerer <gerg@uclinux.org>, Roland Stigge <stigge@antcom.de>, Tony Lindgren <tony@atomide.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Simtec Linux Team <linux@simtec.co.uk>, Kukjin Kim <kgene@kerne>
List-Id: linux-omap@vger.kernel.org

2015-06-10 2:26 GMT+08:00 Rob Herring <robh@kernel.org>:
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
> Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> Cc: Simtec Linux Team <linux@simtec.co.uk>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: Wan ZongShun <mcuos.com@gmail.com>

For Nuvoton W90x900
Acked-by: Wan ZongShun <mcuos.com@gmail.com>

> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-omap@vger.kernel.org
> +++ b/arch/arm/mach-w90x900/irq.c
> @@ -211,6 +211,6 @@ void __init nuc900_init_irq(void)
>         for (irqno = IRQ_WDT; irqno <= IRQ_ADC; irqno++) {
>                 irq_set_chip_and_handler(irqno, &nuc900_irq_chip,
>                                          handle_level_irq);
> -               set_irq_flags(irqno, IRQF_VALID);
> +               irq_clear_status_flags(irqno, IRQ_NOREQUEST);
>         }
>  }
> --
> 2.1.0
>



-- 
---
Vincent Wan(Zongshun)
www.mcuos.com
