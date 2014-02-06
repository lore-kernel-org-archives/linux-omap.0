From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 2/4] MFD: TPS65218: Add driver for the TPS65218 PMIC
Date: Thu, 6 Feb 2014 14:37:00 +0000
Message-ID: <20140206143700.GA14727@lee--X1>
References: <1391665814-18814-1-git-send-email-j-keerthy@ti.com>
 <1391665814-18814-3-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1391665814-18814-3-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, rob@landley.net, sameo@linux.intel.com, grant.likely@linaro.org, lgirdwood@gmail.com, broonie@kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

> The TPS65218 chip is a power management IC for Portable Navigation Sy=
stems
> and Tablet Computing devices. It contains the following components:
>=20
>  - Regulators.
>  - Over Temperature warning and Shut down.
>=20
> This patch adds support for tps65218 mfd device. At this time only
> the regulator functionality is made available.
>=20
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  drivers/mfd/Kconfig          |   15 +++
>  drivers/mfd/Makefile         |    1 +
>  drivers/mfd/tps65218.c       |  281 ++++++++++++++++++++++++++++++++=
+++++++++

How much different is the TPS65218 to all the other TPS drivers?

drivers/mfd/tps6105x.c
drivers/mfd/tps65010.c
drivers/mfd/tps6507x.c
drivers/mfd/tps65090.c
drivers/mfd/tps65217.c
drivers/mfd/tps6586x.c
drivers/mfd/tps65910.c
drivers/mfd/tps65911-comparator.c
drivers/mfd/tps65912-core.c
drivers/mfd/tps65912-i2c.c
drivers/mfd/tps65912-irq.c
drivers/mfd/tps65912-spi.c
drivers/mfd/tps80031.c

Perhaps some consolidating might be in order?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
