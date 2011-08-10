From: "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC/PATCH 10/14] dt: Add pd_size to AUXDATA structure
Date: Wed, 10 Aug 2011 13:57:49 +0200
Message-ID: <4E42723D.1010501@ti.com>
References: <1312897232-4792-1-git-send-email-manjugk@ti.com>
	<1312897232-4792-11-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1312897232-4792-11-git-send-email-manjugk-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: "G, Manjunath Kondaiah" <manjugk-l0cyMroinI0@public.gmane.org>
Cc: "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 8/9/2011 4:10 PM, G, Manjunath Kondaiah wrote:
>
> Add pd_size in the AUXDATA structure so that device drivers which require
> platform_data size can pass along with AUXDATA.

It is really needed by device driver? Or is it because omap_device_build 
is using platform_device_add_data that is doing a copy of the pdata and 
thus require the size?

> Signed-off-by: G, Manjunath Kondaiah<manjugk-l0cyMroinI0@public.gmane.org>
> ---
>   drivers/of/platform.c       |    2 ++
>   include/linux/of_platform.h |    5 +++++
>   2 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index ebbbf42..4b27286 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -565,6 +565,7 @@ static int of_platform_bus_create(struct device_node *bus,
>   	struct platform_device *dev;
>   	const char *bus_id = NULL;
>   	void *platform_data = NULL;
> +	int pd_size;

Maybe platform_data_size will be a little bit more consistent?

Regards,
Benoit

>   	int id = -1;
>   	int rc = 0;
>
> @@ -588,6 +589,7 @@ static int of_platform_bus_create(struct device_node *bus,
>   		bus_id = auxdata->name;
>   		id = auxdata->id;
>   		platform_data = auxdata->platform_data;
> +		pd_size = auxdata->pd_size;
>   	}
>
>   	if (of_device_is_compatible(bus, "arm,primecell")) {
> diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
> index 252246c..a3be980 100644
> --- a/include/linux/of_platform.h
> +++ b/include/linux/of_platform.h
> @@ -47,6 +47,7 @@ struct of_dev_auxdata {
>   	char *name;
>   	int id;
>   	void *platform_data;
> +	int pd_size;
>   };
>
>   /* Macro to simplify populating a lookup table */
> @@ -58,6 +59,10 @@ struct of_dev_auxdata {
>   	{ .compatible = _compat, .phys_addr = _phys, .name = _name, \
>   	  .id = _id, .platform_data = _pdata }
>
> +#define OF_DEV_AUXDATA_ID_PDSIZE(_compat,_phys,_name,_id,_pdata,_pd_size) \
> +	{ .compatible = _compat, .phys_addr = _phys, .name = _name, \
> +	  .id = _id, .platform_data = _pdata, .pd_size = _pd_size }
> +
>   /**
>    * of_platform_driver - Legacy of-aware driver for platform devices.
>    *
