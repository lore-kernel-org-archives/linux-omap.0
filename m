From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] regulator: tps65218: add support for LS3 current
 regulator
Date: Thu, 26 Nov 2015 10:10:43 +0000
Message-ID: <20151126101043.GT12874@x1>
References: <1448452744-17126-1-git-send-email-nikita@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1448452744-17126-1-git-send-email-nikita@compulab.co.il>
Sender: linux-kernel-owner@vger.kernel.org
To: Nikita Kiryanov <nikita@compulab.co.il>
Cc: broonie@kernel.org, lgirdwood@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On Wed, 25 Nov 2015, Nikita Kiryanov wrote:

> Add support for TPS65218 LS3 current regulator, which is capable of 4
> current input limit modes: 100, 200, 500, and 1000 uA.
>=20
> Signed-off-by: Nikita Kiryanov <nikita@compulab.co.il>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/regulator/tps65218-regulator.c | 137 +++++++++++++++++++++++=
++--------
>  include/linux/mfd/tps65218.h           |   7 +-

Acked-by: Lee Jones <lee.jones@linaro.org>

>  include/linux/regulator/driver.h       |   2 +
>  3 files changed, 115 insertions(+), 31 deletions(-)

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
