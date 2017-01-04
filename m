From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] pinctrl: Introduce TI IOdelay configuration driver
Date: Wed, 4 Jan 2017 11:57:46 -0600
Message-ID: <41e171e7-4812-51fa-980c-197f7db7b5ef@ti.com>
References: <20161230183732.5595-1-tony@atomide.com>
 <20161230183732.5595-3-tony@atomide.com> <20170102221228.GH9325@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170102221228.GH9325-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Gary Bisson <gary.bisson-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 01/02/2017 04:12 PM, Tony Lindgren wrote:
[...]

I got the following warnings with kernel-doc:
> $ ./scripts/kernel-doc drivers/pinctrl/ti/pinctrl-ti-iodelay.c>/dev/null
> drivers/pinctrl/ti/pinctrl-ti-iodelay.c:132: warning: Excess struct/union/enum/typedef member 'name' description in 'ti_iodelay_pingroup'
> drivers/pinctrl/ti/pinctrl-ti-iodelay.c:132: warning: Excess struct/union/enum/typedef member 'map' description in 'ti_iodelay_pingroup'
> drivers/pinctrl/ti/pinctrl-ti-iodelay.c:159: warning: Excess struct/union/enum/typedef member 'names' description in 'ti_iodelay_device'
> drivers/pinctrl/ti/pinctrl-ti-iodelay.c:211: warning: No description found for parameter 'cfg'
> drivers/pinctrl/ti/pinctrl-ti-iodelay.c:211: warning: Excess function parameter 'val' description in 'ti_iodelay_pinconf_set'
> drivers/pinctrl/ti/pinctrl-ti-iodelay.c:418: warning: Cannot understand  *
>  on line 418 - I thought it was a doc line

Marking them below

> diff --git a/drivers/pinctrl/ti/pinctrl-ti-iodelay.c b/drivers/pinctrl/ti/pinctrl-ti-iodelay.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/pinctrl/ti/pinctrl-ti-iodelay.c
[...]

> +/**
> + * struct ti_iodelay_pingroup - Structure that describes one group
> + * @name: Name of the group

          ^^--> we should drop this

> + * @map: pinctrl map allocated for the group

          ^^--> we should drop this

> + * @cfg: configuration array for the pin (from dt)
> + * @ncfg: number of configuration values allocated
> + * @config: pinconf "Config" - currently a dummy value
> + */
> +struct ti_iodelay_pingroup {
> +	struct ti_iodelay_cfg *cfg;
> +	int ncfg;
> +	unsigned long config;
> +};
> +
> +/**
> + * struct ti_iodelay_device - Represents information for a iodelay instance
> + * @dev: Device pointer
> + * @phys_base: Physical address base of the iodelay device
> + * @reg_base: Virtual address base of the iodelay device
> + * @regmap: Regmap for this iodelay instance
> + * @pctl: Pinctrl device
> + * @desc: pinctrl descriptor for pctl
> + * @pa: pinctrl pin wise description
> + * @names: names of the pins

          ^^--> we should drop this

> + * @reg_data: Register definition data for the IODelay instance
> + * @reg_init_conf_values: Initial configuration values.
> + */
> +struct ti_iodelay_device {
> +	struct device *dev;
> +	unsigned long phys_base;
> +	void __iomem *reg_base;
> +	struct regmap *regmap;
> +
> +	struct pinctrl_dev *pctl;
> +	struct pinctrl_desc desc;
> +	struct pinctrl_pin_desc *pa;
> +
> +	const struct ti_iodelay_reg_data *reg_data;
> +	struct ti_iodelay_reg_values reg_init_conf_values;
> +};
> +

[...]

> +/**
> + * ti_iodelay_pinconf_set() - Configure the pin configuration
> + * @iod: iodelay device
> + * @val: Configuration value
        ^^ --> should be cfg ?
> + *
> + * Update the configuration register as per TRM and lockup once done.
> + * *IMPORTANT NOTE* SoC TRM does recommend doing iodelay programmation only
> + * while in Isolation. But, then, isolation also implies that every pin
> + * on the SoC (including DDR) will be isolated out. The only benefit being
> + * a glitchless configuration, However, the intent of this driver is purely
> + * to support a "glitchy" configuration where applicable.
> + *
> + * Return: 0 in case of success, else appropriate error value
> + */
> +static int ti_iodelay_pinconf_set(struct ti_iodelay_device *iod,
> +				  struct ti_iodelay_cfg *cfg)
[...]

> +
> +/**
> + *
Could you make this:
  * ti_iodelay_node_iterator() - Iterate iodelay node

> + * @pctldev: Pin controller driver
> + * @np: Device node
> + * @pinctrl_spec: Parsed arguments from device tree
> + * @pins: Array of pins in the pin group
> + * @pin_index: Pin index in the pin array
> + * @data: Pin controller driver specific data
> + *
> + */
> +static int ti_iodelay_node_iterator(struct pinctrl_dev *pctldev,
> +				    struct device_node *np,
> +				    const struct of_phandle_args *pinctrl_spec,
> +				    int *pins, int pin_index, void *data)

[...]

Otherwise, the patch looks fine. Thanks for doing this.

-- 
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
