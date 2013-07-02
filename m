From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 3/4] rtc: omap: add rtc wakeup support to alarm events
Date: Tue, 2 Jul 2013 11:32:34 +0530
Message-ID: <51D26CFA.5090500@ti.com>
References: <1372412109-986-1-git-send-email-gururaja.hebbar@ti.com>
	<1372412109-986-4-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1372412109-986-4-git-send-email-gururaja.hebbar-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Hebbar Gururaja <gururaja.hebbar-l0cyMroinI0@public.gmane.org>
Cc: Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 6/28/2013 3:05 PM, Hebbar Gururaja wrote:
> On some platforms (like AM33xx), a special register (RTC_IRQWAKEEN)
> is available to enable Alarm Wakeup feature. This register needs to be
> properly handled for the rtcwake to work properly.
> 
> Platforms using such IP should set "ti,am3352-rtc" in rtc device dt
> compatibility node.
> 
> Signed-off-by: Hebbar Gururaja <gururaja.hebbar-l0cyMroinI0@public.gmane.org>
> Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
> Cc: Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>
> Cc: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
> Cc: Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>
> Cc: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
> Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
> Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> ---

[...]

> -#define	OMAP_RTC_DATA_DA830_IDX	1
> +#define	OMAP_RTC_DATA_DA830_IDX		1
> +#define	OMAP_RTC_DATA_AM335X_IDX	2
>  
>  static struct platform_device_id omap_rtc_devtype[] = {
>  	{
> @@ -309,6 +321,9 @@ static struct platform_device_id omap_rtc_devtype[] = {
>  	}, {
>  		.name	= "da830-rtc",
>  		.driver_data = OMAP_RTC_HAS_KICKER,
> +	}, {
> +		.name	= "am335x-rtc",

may be use am3352-rtc here just to keep the platform device name and of
compatible in sync.

> +		.driver_data = OMAP_RTC_HAS_KICKER | OMAP_RTC_HAS_IRQWAKEEN,
>  	},
>  	{},

It is better to use the index defined above in the static initialization
so they remain in sync.

	...
	[OMAP_RTC_DATA_DA830_IDX] = {
		.name	= "da830-rtc",
		.driver_data = OMAP_RTC_HAS_KICKER,
	},
	...

>  };
> @@ -318,6 +333,9 @@ static const struct of_device_id omap_rtc_of_match[] = {
>  	{	.compatible	= "ti,da830-rtc",
>  		.data		= &omap_rtc_devtype[OMAP_RTC_DATA_DA830_IDX],
>  	},
> +	{	.compatible	= "ti,am3352-rtc",
> +		.data		= &omap_rtc_devtype[OMAP_RTC_DATA_AM335X_IDX],
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, omap_rtc_of_match);

Apart from these minor issues, the patch looks good to me.

Acked-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>

Thanks,
Sekhar
