From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2] mfd: omap-usb-tll: Don't hold lock during
 pm_runtime_get/put_sync()
Date: Wed, 8 Jan 2014 09:12:37 +0000
Message-ID: <20140108091237.GE19974@lee--X1>
References: <1389165333-7573-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1389165333-7573-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: sameo@linux.intel.com, balbi@ti.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

> pm_runtime_get/put_sync() can sleep so don't hold spinlock while
> calling them.
>=20
> This patch prevents a BUG() during system suspend when
> CONFIG_DEBUG_ATOMIC_SLEEP is enabled.
>=20
> Bug is present in Kernel versions v3.9 onwards.
>=20
> Reported-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Tested-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: <stable@vger.kernel.org> # 3.9+
> ---
>  drivers/mfd/omap-usb-tll.c | 36 ++++++++++++------------------------
>  1 file changed, 12 insertions(+), 24 deletions(-)

Patch looks good to me now.

Applied, thanks.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
