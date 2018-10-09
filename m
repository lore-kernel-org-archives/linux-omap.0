From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/5] Input: ti_am335x_tsc: Mark TSC device as wakeup
 source
Date: Tue, 9 Oct 2018 11:29:58 +0100
Message-ID: <20181009102958.GN4939@dell>
References: <20180630103318.25355-1-vigneshr@ti.com>
 <20180630103318.25355-3-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180630103318.25355-3-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-iio@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sat, 30 Jun 2018, Vignesh R wrote:

> Instead of TSCADC MFD device, mark TSC as wakeup source and change all
> wakeup related PM calls to operate on TSC device.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  drivers/input/touchscreen/ti_am335x_tsc.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
