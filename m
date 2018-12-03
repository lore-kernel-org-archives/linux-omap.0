From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 1/2] mfd: ti_am335x_tscadc: Use PLATFORM_DEVID_AUTO
 while registering mfd cells
Date: Mon, 3 Dec 2018 11:35:01 +0000
Message-ID: <20181203113501.GN26661@dell>
References: <20181203080118.17504-1-vigneshr@ti.com>
 <20181203080118.17504-2-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181203080118.17504-2-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, 03 Dec 2018, Vignesh R wrote:

> Use PLATFORM_DEVID_AUTO to number mfd cells while registering, so that
> different instances are uniquely identified. This is required in order
> to support registering of multiple instances of same ti_am335x_tscadc IP.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
> v2: use PLATFORM_DEVID_AUTO as suggested by Lee Jones
> 
>  drivers/mfd/ti_am335x_tscadc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
