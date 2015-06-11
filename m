From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 09/15] mfd: kill off set_irq_flags usage
Date: Thu, 11 Jun 2015 09:51:10 +0100
Message-ID: <20150611085110.GF2982@x1>
References: <1433874401-27161-1-git-send-email-robh@kernel.org>
 <1433874401-27161-10-git-send-email-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1433874401-27161-10-git-send-email-robh@kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, arm@kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Milo Kim <milo.kim@ti.com>, Kumar Gala <galak@codeaurora.org>, Andy Gross <agross@codeaurora.org>, David Brown <davidb@codeaurora.org>, Tony Lindgren <tony@atomide.com>, patches@opensource.wolfsonmicro.com, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, 09 Jun 2015, Rob Herring wrote:

> set_irq_flags is ARM specific with custom flags which have genirq
> equivalents. Convert drivers to use the genirq interfaces directly, s=
o we
> can kill off set_irq_flags. The translation of flags is as follows:
>=20
> IRQF_VALID -> !IRQ_NOREQUEST
> IRQF_PROBE -> !IRQ_NOPROBE
> IRQF_NOAUTOEN -> IRQ_NOAUTOEN
>=20
> For IRQs managed by an irqdomain, the irqdomain core code handles cle=
aring
> and setting IRQ_NOREQUEST already, so there is no need to do this in
> .map() functions and we can simply remove the set_irq_flags calls. So=
me
> users also set IRQ_NOPROBE and this has been maintained although it i=
s not
> clear that is really needed. There appears to be a great deal of blin=
d
> copy and paste of this code.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Milo Kim <milo.kim@ti.com>
> Cc: Kumar Gala <galak@codeaurora.org>
> Cc: Andy Gross <agross@codeaurora.org>
> Cc: David Brown <davidb@codeaurora.org>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: patches@opensource.wolfsonmicro.com
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-soc@vger.kernel.org
> Cc: linux-omap@vger.kernel.org
> ---
>  drivers/mfd/88pm860x-core.c |  4 ----
>  drivers/mfd/ab8500-core.c   |  4 ----
>  drivers/mfd/arizona-irq.c   |  7 -------
>  drivers/mfd/asic3.c         |  4 ++--
>  drivers/mfd/db8500-prcmu.c  |  1 -
>  drivers/mfd/ezx-pcap.c      |  6 +-----
>  drivers/mfd/htc-egpio.c     |  4 ++--
>  drivers/mfd/htc-i2cpld.c    |  6 +-----
>  drivers/mfd/lp8788-irq.c    |  5 -----
>  drivers/mfd/max8925-core.c  |  5 +----
>  drivers/mfd/max8997-irq.c   |  5 +----
>  drivers/mfd/max8998-irq.c   |  5 +----
>  drivers/mfd/mt6397-core.c   |  4 ----
>  drivers/mfd/pm8921-core.c   |  5 +----
>  drivers/mfd/rc5t583-irq.c   |  4 +---
>  drivers/mfd/stmpe.c         |  7 -------
>  drivers/mfd/t7l66xb.c       |  6 ------
>  drivers/mfd/tc3589x.c       |  7 -------
>  drivers/mfd/tc6393xb.c      |  4 ++--
>  drivers/mfd/tps6586x.c      |  7 -------
>  drivers/mfd/tps65912-irq.c  |  8 +-------
>  drivers/mfd/twl4030-irq.c   | 11 +----------
>  drivers/mfd/twl6030-irq.c   | 13 -------------
>  drivers/mfd/ucb1x00-core.c  |  2 +-
>  drivers/mfd/wm831x-irq.c    |  7 -------
>  drivers/mfd/wm8350-irq.c    |  8 +-------
>  drivers/mfd/wm8994-irq.c    |  7 -------
>  27 files changed, 17 insertions(+), 139 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
