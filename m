From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3] mfd: tps65218: Use devm_regmap_add_irq_chip and clean
 up  error path in probe
Date: Fri, 14 Dec 2018 12:41:27 +0000
Message-ID: <20181214124127.GY4497@dell>
References: <1544363971-28061-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1544363971-28061-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, sebastian.reichel@collabora.com, t-kristo@ti.com, ladis@linux-mips.org
List-Id: linux-omap@vger.kernel.org

On Sun, 09 Dec 2018, Keerthy wrote:

> Use devm_regmap_add_irq_chip and clean up error path in probe
> and also the remove function.
> 
> Reported-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
> 
> Changes in v2:
> 
>   * Cleaned up remove function as well.
> 
> Changes in v3:
> 
>   * Deleted the remove function which was just returning 0
> 
>  drivers/mfd/tps65218.c | 24 +++---------------------
>  1 file changed, 3 insertions(+), 21 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
