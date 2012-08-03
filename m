From: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] hwmon: tmp102: Add device tree support
Date: Fri, 3 Aug 2012 16:56:49 +0200
Message-ID: <501BE6B1.9000100@ti.com>
References: <1343997350-676-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1343997350-676-1-git-send-email-sourav.poddar-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Sourav,

On 08/03/2012 02:35 PM, Sourav Poddar wrote:
> update tmp102 temperature sensor to also use device tree.
> 
> Cc: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
> Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> Cc: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
> Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/hwmon/tmp102.c |   14 +++++++++++++-
>  1 files changed, 13 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hwmon/tmp102.c b/drivers/hwmon/tmp102.c
> index 0d466b9..a8a9060 100644
> --- a/drivers/hwmon/tmp102.c
> +++ b/drivers/hwmon/tmp102.c
> @@ -26,6 +26,7 @@
>  #include <linux/err.h>
>  #include <linux/mutex.h>
>  #include <linux/device.h>
> +#include <linux/of.h>
>  
>  #define	DRIVER_NAME "tmp102"
>  
> @@ -284,8 +285,19 @@ static const struct i2c_device_id tmp102_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, tmp102_id);
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id temperature_dt_match[] = {
> +	{ .compatible = "ti,tmp102" },

Are you sure this is needed for this device?

There is an automatic binding done for I2C devices in the of_i2c core
code. So in theory, DT will be able to bind to any I2C device using the
already existing table: MODULE_DEVICE_TABLE(i2c, tmp102_id).

So I think this patch should not be needed.

Regards,
Benoit
