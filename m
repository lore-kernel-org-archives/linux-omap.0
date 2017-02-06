From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] omapfb: dss: Handle return error in dss_init_ports.
Date: Mon, 06 Feb 2017 16:28:08 +0100
Message-ID: <15170308.DWakhCLKvX@amdc3058>
References: <CGME20170203122444epcas2p3e0d5ed32cac85fd86d900a62dbeb03a4@epcas2p3.samsung.com>
 <1486124625-23454-1-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1486124625-23454-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


Hi,

On Friday, February 03, 2017 05:53:45 PM Arvind Yadav wrote:
> Here, dss_init_ports is not handling return error form
> dpi_init_port and sdi_init_port. Now dss_init_ports is returning
> always 0. And it's making below code as a dead code.
> 
> static int dss_bind(struct device *dev)
> {
>   .
>   .
>   r = dss_init_ports(pdev); //dss_init_ports will return always 0
>   if (r)// This condition will always false
>       goto err_init_ports; //Dead Code
>   .
>   .
> }
> 
> This change is to handle return error from dpi_init_port and
> sdi_init_port. Also, It will remove dead code from function 'dss_bind'.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/video/fbdev/omap2/omapfb/dss/dss.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dss.c b/drivers/video/fbdev/omap2/omapfb/dss/dss.c
> index 47d7f69..15a0dab 100644
> --- a/drivers/video/fbdev/omap2/omapfb/dss/dss.c
> +++ b/drivers/video/fbdev/omap2/omapfb/dss/dss.c
> @@ -946,6 +946,7 @@ static int dss_init_ports(struct platform_device *pdev)
>  	struct device_node *parent = pdev->dev.of_node;
>  	struct device_node *port;
>  	int r;
> +	int ret = 0;
>  
>  	if (parent == NULL)
>  		return 0;
> @@ -972,17 +973,17 @@ static int dss_init_ports(struct platform_device *pdev)
>  
>  		switch (port_type) {
>  		case OMAP_DISPLAY_TYPE_DPI:
> -			dpi_init_port(pdev, port);
> +			ret = dpi_init_port(pdev, port);
>  			break;
>  		case OMAP_DISPLAY_TYPE_SDI:
> -			sdi_init_port(pdev, port);
> +			ret = sdi_init_port(pdev, port);
>  			break;
>  		default:
>  			break;
>  		}
>  	} while ((port = omapdss_of_get_next_port(parent, port)) != NULL);

Shouldn't initialization be stopped after the first failure?

i.e.:

	} while (!ret && (port = omapdss_of_get_next_port(parent, port)) != NULL);

Also the cleanup of the partial initialization is missing.
>From looking at the code we should do something like this
before returning:

	if (ret)
		dss_uninit_ports(pdev);

(dpi_uninit_port() & sdi_uninit_port() skip not fully
initialized ports)

> -	return 0;
> +	return ret;
>  }
>  
>  static void dss_uninit_ports(struct platform_device *pdev)

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
