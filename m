From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] tps65218.c: fix IRQ resource leak in tps65218_probe()
Date: Fri, 14 Dec 2018 12:25:59 +0000
Message-ID: <20181214122559.GV4497@dell>
References: <1544090279-26762-1-git-send-email-Christian.Hohnstaedt@wago.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1544090279-26762-1-git-send-email-Christian.Hohnstaedt@wago.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
Cc: "J, KEERTHY" <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, 06 Dec 2018, Christian Hohnstaedt wrote:

> Free allocated IRQ if reading the device ID fails.

The patch is fine.  However, in future please submit patches using the
format set (by precedent) by the subsystem.  I will fix the subject
for you this time.

To check the format, you can do:

  `git log --oneline -- <subsystem>`


> Signed-off-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
> ---
>  drivers/mfd/tps65218.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
> index 910f569..19270bc 100644
> --- a/drivers/mfd/tps65218.c
> +++ b/drivers/mfd/tps65218.c
> @@ -244,7 +244,7 @@ static int tps65218_probe(struct i2c_client *client,
>  	ret = regmap_read(tps->regmap, TPS65218_REG_CHIPID, &chipid);
>  	if (ret) {
>  		dev_err(tps->dev, "Failed to read chipid: %d\n", ret);
> -		return ret;
> +		goto err_irq;
>  	}
>  
>  	tps->rev = chipid & TPS65218_CHIPID_REV_MASK;

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
