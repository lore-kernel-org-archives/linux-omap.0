From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v5 1/9] mfd: omap-usb-host: Use resource managed clk_get()
Date: Fri, 10 Jan 2014 10:12:56 +0000
Message-ID: <20140110101256.GG28141@lee--X1>
References: <1389269303-30465-1-git-send-email-rogerq@ti.com>
 <1389269303-30465-2-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1389269303-30465-2-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: bcousson@baylibre.com, tony@atomide.com, balbi@ti.com, arnd@arndb.de, sre@debian.org, mark.rutland@arm.com, m.paolino@virtualopensystems.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

> Use devm_clk_get() instead of clk_get().
>=20
> CC: Lee Jones <lee.jones@linaro.org>
> CC: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  drivers/mfd/omap-usb-host.c | 81 +++++++++--------------------------=
----------
>  1 file changed, 16 insertions(+), 65 deletions(-)

Nice clean up.

Acked-by: Lee Jones <lee.jones@linaro.org>

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
