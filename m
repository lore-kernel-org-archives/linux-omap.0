From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: palmas: Fixed spelling mistake in error message.
Date: Tue, 11 Apr 2017 17:22:00 +0100
Message-ID: <20170411162200.nj6v7ipp7khhuz33@dell>
References: <20170411161006.cp4mdyxxjd5f2ixn@willis-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170411161006.cp4mdyxxjd5f2ixn@willis-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Willis Monroe <willismonroe@gmail.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, 11 Apr 2017, Willis Monroe wrote:

> Fixed a small spelling mistake ("updat" -> "update") in an error message.
> 
> Signed-off-by: Willis Monroe <willismonroe@gmail.com>
> ---
>  drivers/mfd/palmas.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Nice!

Applied, thanks.

> diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
> index ee9e9ea..dbb6d42 100644
> --- a/drivers/mfd/palmas.c
> +++ b/drivers/mfd/palmas.c
> @@ -567,7 +567,7 @@ static int palmas_i2c_probe(struct i2c_client *i2c,
>  			PALMAS_POLARITY_CTRL, PALMAS_POLARITY_CTRL_INT_POLARITY,
>  			reg);
>  	if (ret < 0) {
> -		dev_err(palmas->dev, "POLARITY_CTRL updat failed: %d\n", ret);
> +		dev_err(palmas->dev, "POLARITY_CTRL update failed: %d\n", ret);
>  		goto err_i2c;
>  	}
>  

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
