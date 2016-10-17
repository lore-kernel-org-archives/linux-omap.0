From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v4 7/8] drivers:input:ads7846(+tsc2046): fix spi module
 table
Date: Mon, 17 Oct 2016 10:54:03 -0500
Message-ID: <acdf452f-01f2-27df-11c5-bb8db002394a@ti.com>
References: <cover.1476712675.git.hns@goldelico.com>
 <70cc986f3cf98dd89f0460b5042083aad58a7366.1476712675.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <70cc986f3cf98dd89f0460b5042083aad58a7366.1476712675.git.hns@goldelico.com>
Sender: linux-input-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Michael Welling <mwelling@ieee.org>, =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Igor Grinberg <grinberg@compulab.co.il>, Sebastian Reichel <sre@kernel.org>, Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, letux-kernel@openphoenux.org, linux-iio@vger.kernel.org, kernel@pyra-handheld.com
List-Id: linux-omap@vger.kernel.org

On 10/17/2016 08:57 AM, H. Nikolaus Schaller wrote:
> Fix module table so that the driver is loaded if compiled
> as module and requested by DT.
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  drivers/input/touchscreen/ads7846.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
> index 400e421..9a5d84d 100644
> --- a/drivers/input/touchscreen/ads7846.c
> +++ b/drivers/input/touchscreen/ads7846.c
> @@ -1532,6 +1532,17 @@ static int ads7846_remove(struct spi_device *spi)
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
> +

no space needed

> +MODULE_DEVICE_TABLE(spi, ads7846_idtable);
> +
>  static struct spi_driver ads7846_driver = {
>  	.driver = {
>  		.name	= "ads7846",
> 

the MODULE_ALIAS below can now also be removed with this patch.
