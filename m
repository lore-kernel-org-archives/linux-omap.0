From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] mfd: menelaus: rmove incorrect __exit markups
Date: Mon, 9 Mar 2015 10:54:17 -0700
Message-ID: <20150309175417.GH5264@atomide.com>
References: <20150309174936.GA22662@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150309174936.GA22662@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Dmitry Torokhov <dmitry.torokhov@gmail.com> [150309 10:49]:
> Even if bus is not hot-pluggable, the devices can be unbound from the
> driver via sysfs, so we should not be using __exit annotations on
> remove() methods. The only exception is drivers registered with
> platform_driver_probe() which specifically disables sysfs bind/unbind
> attributes.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  drivers/mfd/menelaus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/menelaus.c b/drivers/mfd/menelaus.c
> index 9f01aef..5269ff2 100644
> --- a/drivers/mfd/menelaus.c
> +++ b/drivers/mfd/menelaus.c
> @@ -1259,7 +1259,7 @@ fail:
>  	return err;
>  }
>  
> -static int __exit menelaus_remove(struct i2c_client *client)
> +static int menelaus_remove(struct i2c_client *client)
>  {
>  	struct menelaus_chip	*menelaus = i2c_get_clientdata(client);
>  
> @@ -1280,7 +1280,7 @@ static struct i2c_driver menelaus_i2c_driver = {
>  		.name		= DRIVER_NAME,
>  	},
>  	.probe		= menelaus_probe,
> -	.remove		= __exit_p(menelaus_remove),
> +	.remove		= menelaus_remove,
>  	.id_table	= menelaus_id,
>  };
>  
> -- 
> 2.2.0.rc0.207.ga3a616c
> 
> 
> -- 
> Dmitry
