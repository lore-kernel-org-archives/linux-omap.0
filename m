From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RESEND 1/3] mfd: twl6040: Select i2c fast mode as default with
 regmap patch
Date: Mon, 28 Apr 2014 11:42:26 +0100
Message-ID: <20140428104226.GJ21279@lee--X1>
References: <1396359901-32656-1-git-send-email-peter.ujfalusi@ti.com>
 <1396359901-32656-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1396359901-32656-2-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, sameo@linux.intel.com, nm@ti.com
List-Id: linux-omap@vger.kernel.org

> All boards using twl6040 configures the i2c bus to 400KHz. While twl6=
040's
> defaults to normal mode (100KHz). So far twl6040 has no problem with =
i2c
> communication in this configuration it is safer to select fast i2c mo=
de.
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/mfd/twl6040.c       | 9 +++++++--
>  include/linux/mfd/twl6040.h | 1 +
>  2 files changed, 8 insertions(+), 2 deletions(-)

Applied, thanks.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
