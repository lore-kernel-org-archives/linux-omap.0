From: "Kim, Milo" <milo.kim@ti.com>
Subject: Re: [PATCH 08/20] mfd: lp3943: Use devm_mfd_add_devices() for
 mfd_device registration
Date: Wed, 6 Apr 2016 08:59:10 +0900
Message-ID: <5704514E.3020603@ti.com>
References: <1459856912-17859-1-git-send-email-ldewangan@nvidia.com>
 <1459856912-17859-9-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1459856912-17859-9-git-send-email-ldewangan@nvidia.com>
Sender: linux-doc-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: lee.jones@linaro.org, corbet@lwn.net, andreas.werner@men.de, tony@atomide.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com
List-Id: linux-omap@vger.kernel.org

On 4/5/2016 8:48 PM, Laxman Dewangan wrote:
> Use devm_mfd_add_devices() for mfd devices registration and get
> rid of .remove callback to remove mfd devices. This is done
> by managed device framework.
>
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> CC: Milo Kim <milo.kim@ti.com>

Acked-by: Milo Kim <milo.kim@ti.com>

> ---
>   drivers/mfd/lp3943.c | 14 +++-----------
>   1 file changed, 3 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/mfd/lp3943.c b/drivers/mfd/lp3943.c
> index eecbb13..65a2a8f1 100644
> --- a/drivers/mfd/lp3943.c
> +++ b/drivers/mfd/lp3943.c
> @@ -123,16 +123,9 @@ static int lp3943_probe(struct i2c_client *cl, const struct i2c_device_id *id)
>   	lp3943->mux_cfg = lp3943_mux_cfg;
>   	i2c_set_clientdata(cl, lp3943);
>
> -	return mfd_add_devices(dev, -1, lp3943_devs, ARRAY_SIZE(lp3943_devs),
> -			       NULL, 0, NULL);
> -}
> -
> -static int lp3943_remove(struct i2c_client *cl)
> -{
> -	struct lp3943 *lp3943 = i2c_get_clientdata(cl);
> -
> -	mfd_remove_devices(lp3943->dev);
> -	return 0;
> +	return devm_mfd_add_devices(dev, -1, lp3943_devs,
> +				    ARRAY_SIZE(lp3943_devs),
> +				    NULL, 0, NULL);
>   }
>
>   static const struct i2c_device_id lp3943_ids[] = {
> @@ -151,7 +144,6 @@ MODULE_DEVICE_TABLE(of, lp3943_of_match);
>
>   static struct i2c_driver lp3943_driver = {
>   	.probe = lp3943_probe,
> -	.remove = lp3943_remove,
>   	.driver = {
>   		.name = "lp3943",
>   		.of_match_table = of_match_ptr(lp3943_of_match),
>
