From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 5/9] regulator: helper routine to extract
	fixed_voltage_config
Date: Thu, 29 Sep 2011 19:26:58 -0600
Message-ID: <20110930012658.GF12606@ponder.secretlab.ca>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com>
	<1317118372-17052-6-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1317118372-17052-6-git-send-email-rnayak-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Cc: patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 27, 2011 at 03:42:48PM +0530, Rajendra Nayak wrote:
> The helper routine of_get_fixed_voltage_config() extracts
> fixed_voltage_config structure contents from device tree.
> 
> Also add documenation for additional bindings for fixed
> regulators that can be passed through dt.
> 
> Signed-off-by: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
> ---
>  .../bindings/regulator/fixed-regulator.txt         |   24 +++++++++++++
>  drivers/regulator/fixed.c                          |   36 ++++++++++++++++++++
>  include/linux/regulator/fixed.h                    |    6 ++--
>  3 files changed, 63 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/regulator/fixed-regulator.txt
> 
> diff --git a/Documentation/devicetree/bindings/regulator/fixed-regulator.txt b/Documentation/devicetree/bindings/regulator/fixed-regulator.txt
> new file mode 100644
> index 0000000..a204cbd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/fixed-regulator.txt
> @@ -0,0 +1,24 @@
> +Fixed Voltage regulators
> +
> +Required properties:
> +- compatible: Must be "regulator-fixed";
> +
> +Optional properties:
> +- regulator-fixed-supply: Name of the regulator supply
> +- regulator-fixed-microvolts: Output voltage of regulator
> +- regulator-fixed-gpio: gpio to use for enable control
> +- regulator-fixed-startup-delay: startup time in microseconds
> +- regulator-fixed-enable-high: Polarity of enable GPIO, 1 = Active High, 0 = Active low
> +- regulator-fixed-enabled-at-boot: 1 = yes, 0 = no
> +
> +Example:
> +
> +	abc: fixedregulator@0 {
> +		compatible = "regulator-fixed";
> +		regulator-fixed-supply = "fixed-supply";
> +		regulator-fixed-microvolts = <1800000>;
> +		regulator-fixed-gpio = <43>;
> +		regulator-fixed-startup-delay = <70000>;
> +		regulator-fixed-enable-high;
> +		regulator-fixed-enabled-at-boot;
> +	};
> diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
> index 2fe9d99..c09f791 100644
> --- a/drivers/regulator/fixed.c
> +++ b/drivers/regulator/fixed.c
> @@ -26,6 +26,8 @@
>  #include <linux/gpio.h>
>  #include <linux/delay.h>
>  #include <linux/slab.h>
> +#include <linux/of.h>
> +#include <linux/regulator/of_regulator.h>
>  
>  struct fixed_voltage_data {
>  	struct regulator_desc desc;
> @@ -37,6 +39,40 @@ struct fixed_voltage_data {
>  	bool is_enabled;
>  };
>  
> +
> +/**
> + * of_get_fixed_voltage_config - extract fixed_voltage_config structure info
> + * @dev: device requesting for fixed_voltage_config
> + *
> + * Populates fixed_voltage_config structure by extracting data from device
> + * tree node, returns a pointer to the populated structure of NULL if memory
> + * alloc fails.
> + */
> +struct fixed_voltage_config *of_get_fixed_voltage_config(struct device *dev)
> +{
> +	struct fixed_voltage_config *config;
> +	struct device_node *np = dev->of_node;
> +
> +	config = devm_kzalloc(dev, sizeof(struct fixed_voltage_config), GFP_KERNEL);

Nit: config = devm_kzalloc(dev, *config, GFP_KERNEL);

g.
