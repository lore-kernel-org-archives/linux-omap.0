From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 01/15] ARM: kill off set_irq_flags usage
Date: Fri, 12 Jun 2015 18:30:16 +0900
Message-ID: <557AA6A8.2060106@samsung.com>
References: <1433874401-27161-1-git-send-email-robh@kernel.org>
 <1433874401-27161-2-git-send-email-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1433874401-27161-2-git-send-email-robh@kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, arm@kernel.org, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Hans Ulli Kroll <ulli.kroll@googlemail.com>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Imre Kaloz <kaloz@openwrt.org>, Krzysztof Halasa <khalasa@piap.pl>, Greg Ungerer <gerg@uclinux.org>, Roland Stigge <stigge@antcom.de>, Tony Lindgren <tony@atomide.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Simtec Linux Team <linux@simtec.co.uk>, Kukjin Kim <kgene@kernel.org>, Wan ZongShun <mcuos.com@gmail.com>, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 10.06.2015 03:26, Rob Herring wrote:
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
> Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Imre Kaloz <kaloz@openwrt.org>
> Cc: Krzysztof Halasa <khalasa@piap.pl>
> Cc: Greg Ungerer <gerg@uclinux.org>
> Cc: Roland Stigge <stigge@antcom.de>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Daniel Mack <daniel@zonque.org>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> Cc: Simtec Linux Team <linux@simtec.co.uk>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: Wan ZongShun <mcuos.com@gmail.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-omap@vger.kernel.org
> Cc: linux-samsung-soc@vger.kernel.org
> ---
>  arch/arm/common/it8152.c             |  2 +-
>  arch/arm/common/locomo.c             |  2 +-
>  arch/arm/common/sa1111.c             |  4 ++--
>  arch/arm/mach-davinci/cp_intc.c      |  2 +-
>  arch/arm/mach-dove/irq.c             |  2 +-
>  arch/arm/mach-ebsa110/core.c         |  2 +-
>  arch/arm/mach-footbridge/common.c    |  2 +-
>  arch/arm/mach-footbridge/isa-irq.c   |  8 ++++----
>  arch/arm/mach-gemini/gpio.c          |  2 +-
>  arch/arm/mach-gemini/irq.c           |  2 +-
>  arch/arm/mach-imx/3ds_debugboard.c   |  2 +-
>  arch/arm/mach-imx/mach-mx31ads.c     |  2 +-
>  arch/arm/mach-iop13xx/irq.c          |  2 +-
>  arch/arm/mach-iop32x/irq.c           |  2 +-
>  arch/arm/mach-iop33x/irq.c           |  2 +-
>  arch/arm/mach-ixp4xx/common.c        |  2 +-
>  arch/arm/mach-ks8695/irq.c           |  2 +-
>  arch/arm/mach-lpc32xx/irq.c          |  2 +-
>  arch/arm/mach-netx/generic.c         |  2 +-
>  arch/arm/mach-omap1/fpga.c           |  2 +-
>  arch/arm/mach-omap1/irq.c            |  2 +-
>  arch/arm/mach-pxa/balloon3.c         |  2 +-
>  arch/arm/mach-pxa/irq.c              |  1 -
>  arch/arm/mach-pxa/lpd270.c           |  2 +-
>  arch/arm/mach-pxa/pcm990-baseboard.c |  2 +-
>  arch/arm/mach-pxa/pxa3xx.c           |  2 +-
>  arch/arm/mach-pxa/viper.c            |  2 +-
>  arch/arm/mach-pxa/zeus.c             |  2 +-
>  arch/arm/mach-rpc/ecard.c            |  2 +-
>  arch/arm/mach-rpc/irq.c              | 16 ++++++++--------
>  arch/arm/mach-s3c24xx/bast-irq.c     |  2 +-
>  arch/arm/mach-s3c64xx/common.c       |  2 +-
>  arch/arm/mach-sa1100/irq.c           |  1 -
>  arch/arm/mach-sa1100/neponset.c      |  4 ++--
>  arch/arm/mach-w90x900/irq.c          |  2 +-
>  35 files changed, 45 insertions(+), 47 deletions(-)

For the s3c24xx and s3c64xx it looks fine:
Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
