From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 5/5] Input: ti_am335x_tsc: Mark IRQ as wakeup capable
Date: Tue, 9 Oct 2018 11:30:27 +0100
Message-ID: <20181009103027.GQ4939@dell>
References: <20180630103318.25355-1-vigneshr@ti.com>
 <20180630103318.25355-6-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180630103318.25355-6-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-iio@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sat, 30 Jun 2018, Vignesh R wrote:

> On AM335x, ti_am335x_tsc can wake up the system from suspend, mark the
> IRQ as wakeup capable, so that device irq is not disabled during system
> suspend.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  drivers/input/touchscreen/ti_am335x_tsc.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
