From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/5] mfd: ti_am335x_tscadc: Don't mark TSCADC MFD as
 wakeup capable
Date: Wed, 4 Jul 2018 08:38:10 +0100
Message-ID: <20180704073810.GL20176@dell>
References: <20180630103318.25355-1-vigneshr@ti.com>
 <20180630103318.25355-2-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180630103318.25355-2-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-iio@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sat, 30 Jun 2018, Vignesh R wrote:

> Currently tscadc MFD is marked as wakeup capable which incorrect
> because, its actually touch event by child TSC device that wakes up the
> system. Therefore, remove device_init_wakeup() call that marks TSCADC
> device as wakeup capable in favor of moving to mark TSC input device as
> wakeup capable later.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  drivers/mfd/ti_am335x_tscadc.c | 1 -
>  1 file changed, 1 deletion(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
