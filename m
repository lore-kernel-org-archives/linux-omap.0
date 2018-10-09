From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 4/5] iio: adc: ti_am335x_adc: Disable ADC during suspend
 unconditionally
Date: Tue, 9 Oct 2018 11:30:17 +0100
Message-ID: <20181009103017.GP4939@dell>
References: <20180630103318.25355-1-vigneshr@ti.com>
 <20180630103318.25355-5-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180630103318.25355-5-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-iio@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sat, 30 Jun 2018, Vignesh R wrote:

> Parent MFD device takes care of enabling ADC interface whenever
> touchscreen is marked wakeup capable. Therefore, unconditionally disable
> ADC interface during system suspend to save power in case of system with
> just ADC and no TSC.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  drivers/iio/adc/ti_am335x_adc.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
