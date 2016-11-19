From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 7/8] drivers:input:ads7846(+tsc2046): fix spi module
 table
Date: Sat, 19 Nov 2016 10:18:24 -0800
Message-ID: <20161119181824.GB20446@dtor-ws>
References: <cover.1477557860.git.hns@goldelico.com>
 <54f282e1adebeeb133687b6c430ecbb6f2fe6d5b.1477557860.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54f282e1adebeeb133687b6c430ecbb6f2fe6d5b.1477557860.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila-MRsr7dthA9VWk0Htik3J/w@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Sangwon Jee <jeesw-iQTvn4YitUrQT0dZR+AlfA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, letux-kernel@openphoe
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 27, 2016 at 10:44:20AM +0200, H. Nikolaus Schaller wrote:
> Fix module table so that the driver is loaded if compiled
> as module and requested by DT.

We really need to fix it between spi/i23c core and module utils instead
of keeping adding duplicate IDs all over drivers. We already have OF
module device table containing the same data, we should be able to use
it.

Thanks.

> 
> Signed-off-by: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
> ---
>  drivers/input/touchscreen/ads7846.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
> index 400e421..50c85d2 100644
> --- a/drivers/input/touchscreen/ads7846.c
> +++ b/drivers/input/touchscreen/ads7846.c
> @@ -1532,6 +1532,16 @@ static int ads7846_remove(struct spi_device *spi)
>  	return 0;
>  }
>  
> +static const struct spi_device_id ads7846_idtable[] = {
> +	{ "tsc2046", 0 },
> +	{ "ads7843", 0 },
> +	{ "ads7845", 0 },
> +	{ "ads7846", 0 },
> +	{ "ads7873", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, ads7846_idtable);
> +
>  static struct spi_driver ads7846_driver = {
>  	.driver = {
>  		.name	= "ads7846",
> @@ -1546,4 +1556,3 @@ module_spi_driver(ads7846_driver);
>  
>  MODULE_DESCRIPTION("ADS7846 TouchScreen Driver");
>  MODULE_LICENSE("GPL");
> -MODULE_ALIAS("spi:ads7846");
> -- 
> 2.7.3
> 

-- 
Dmitry
