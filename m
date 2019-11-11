From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: ti_am335x_tscadc: Fix static checker warning
Date: Mon, 11 Nov 2019 11:26:50 +0000
Message-ID: <20191111112650.GJ3218@dell>
References: <20191109050618.20637-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191109050618.20637-1-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Dan Murphy <dmurphy@ti.com>
List-Id: linux-omap@vger.kernel.org

On Sat, 09 Nov 2019, Vignesh Raghavendra wrote:

> It is possible that platform_get_resource() might return NULL and
> therefore code needs to check for this condition before
> de-referencing the pointer.
> Therefore move the de-referencing of 'res' pointer after
> devm_ioremap_resource() which would have checked the validity of the
> pointer
> 
> Reported-by: Dan Murphy <dmurphy@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  drivers/mfd/ti_am335x_tscadc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
