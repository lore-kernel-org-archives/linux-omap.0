From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [RFC 34/42] drivers/video/omap2/dss: don't check resource with
 devm_ioremap_resource
Date: Sat, 11 May 2013 14:36:01 +0900
Message-ID: <002d01ce4e09$6c296f10$447c4d30$@samsung.com>
References: <1368173847-5661-1-git-send-email-wsa@the-dreams.de>
 <1368173847-5661-35-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1368173847-5661-35-git-send-email-wsa@the-dreams.de>
Content-language: ko
Sender: linux-kernel-owner@vger.kernel.org
To: 'Wolfram Sang' <wsa@the-dreams.de>, linux-kernel@vger.kernel.org
Cc: 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, 'Florian Tobias Schandinat' <FlorianSchandinat@gmx.de>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Friday, May 10, 2013 5:17 PM, Wolfram Sang wrote:
> 
> devm_ioremap_resource does sanity checks on the given resource. No need to
> duplicate this in the driver.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

It looks good.
Reviewed-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> ---
>  drivers/video/omap2/dss/hdmi.c |    7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
> index 17f4d55..7bc6762 100644
> --- a/drivers/video/omap2/dss/hdmi.c
> +++ b/drivers/video/omap2/dss/hdmi.c
> @@ -1064,13 +1064,8 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
>  	mutex_init(&hdmi.lock);
>  	mutex_init(&hdmi.ip_data.lock);
> 
> -	res = platform_get_resource(hdmi.pdev, IORESOURCE_MEM, 0);
> -	if (!res) {
> -		DSSERR("can't get IORESOURCE_MEM HDMI\n");
> -		return -EINVAL;
> -	}
> -
>  	/* Base address taken from platform */
> +	res = platform_get_resource(hdmi.pdev, IORESOURCE_MEM, 0);
>  	hdmi.ip_data.base_wp = devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(hdmi.ip_data.base_wp))
>  		return PTR_ERR(hdmi.ip_data.base_wp);
> --
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
