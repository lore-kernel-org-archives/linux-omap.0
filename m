From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH] OMAPDSS: Remove kfree for memory allocated with devm_kzalloc
Date: Thu, 6 Jun 2013 12:40:01 +0530
Message-ID: <51B035C9.1070506@ti.com>
References: <1370453396-18043-1-git-send-email-emilgoode@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1370453396-18043-1-git-send-email-emilgoode@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Emil Goode <emilgoode@gmail.com>
Cc: axel.lin@gmail.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On Wednesday 05 June 2013 10:59 PM, Emil Goode wrote:
> It's not necessary to free memory allocated with devm_kzalloc
> in a remove function and using kfree leads to a double free.

Looks fine to me. Tomi, could you take this for 3.11?

Archit

>
> Signed-off-by: Emil Goode <emilgoode@gmail.com>
> ---
>   drivers/video/omap2/displays/panel-picodlp.c |    2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/video/omap2/displays/panel-picodlp.c b/drivers/video/omap2/displays/panel-picodlp.c
> index 62f2db0..859e111 100644
> --- a/drivers/video/omap2/displays/panel-picodlp.c
> +++ b/drivers/video/omap2/displays/panel-picodlp.c
> @@ -469,8 +469,6 @@ static void picodlp_panel_remove(struct omap_dss_device *dssdev)
>   	i2c_unregister_device(picod->picodlp_i2c_client);
>   	dev_set_drvdata(&dssdev->dev, NULL);
>   	dev_dbg(&dssdev->dev, "removing picodlp panel\n");
> -
> -	kfree(picod);
>   }
>
>   static int picodlp_panel_enable(struct omap_dss_device *dssdev)
>
