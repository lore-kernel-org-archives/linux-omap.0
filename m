From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] pinctrl: Introduce TI IOdelay configuration driver
Date: Tue, 10 Mar 2015 12:03:41 +0100
Message-ID: <CACRpkdYyQp+ZE+Li0DaE03RT_5ibqS_Bk=bCN0cKV-hBFKuNkA@mail.gmail.com>
References: <1425427237-11511-1-git-send-email-nm@ti.com>
	<1425427237-11511-3-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1425427237-11511-3-git-send-email-nm@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lokesh Vutla <lokeshvutla@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Mar 4, 2015 at 1:00 AM, Nishanth Menon <nm@ti.com> wrote:

> SoC family such as DRA7 family of processors have, in addition
> to the regular muxing of pins (as done by pinctrl-single), an
> additional hardware module called IODelay which is also expected to be
> configured. This "IODelay" module has it's own register space that is
> independent of the control module.
>
> It is advocated strongly in TI's official documentation considering
> the existing design of the DRA7 family of processors during mux or
> IODelay reconfiguration, there is a potential for a significant glitch
> which may cause functional impairment to certain hardware. It is
> hence recommended to do as little of muxing as absolutely necessary
> without I/O isolation (which can only be done in initial stages of
> bootloader).
>
> NOTE: with the system wide I/O isolation scheme present in DRA7 SoC
> family, it is not reasonable to do stop all I/O operations for every
> such pad configuration scheme. So, we will let it glitch when used in
> this mode.
>
> Even with the above limitation, certain functionality such as MMC has
> mandatory need for IODelay reconfiguration requirements, depending on
> speed of transfer. In these cases, with careful examination of usecase
> involved, the expected glitch can be controlled such that it does not
> impact functionality.
>
> In short, IODelay module support as a padconf driver being introduced
> here is not expected to do SoC wide I/O Isolation and is meant for
> a limited subset of IODelay configuration requirements that need to
> be dynamic and whose glitchy behavior will not cause functionality
> failure for that interface.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>

Pending the conclusion of my remark on the bindings that this
should use the generic pin config bindings... here are some
"normal" review comments.

> +config PINCTRL_TI_IODELAY
> +       bool "TI IODelay Module pinconf driver"
> +       depends on OF
> +       select PINCONF
> +       select GENERIC_PINCONF
> +       select REGMAP_MMIO
> +       help
> +         Say Y here to support Texas Instruments' IODelay pinconf driver.
> +         IODelay module is used for the DRA7 SoC family. This driver is in
> +         addition to PINCTRL_SINGLE which controls the mux.

If the driver is "in addition to PINCTRL_SINGLE", then it
should depend on it.

> +/* Should I change this? Abuse? */
> +#define IODELAY_MUX_PINS_NAME          "pinctrl-single,pins"

Yeah this is abuse and is why you should use the generic
bindings with just "pins" instead, and use the generic pinconf
parameters to set them up.

> + * struct ti_iodelay_conf_vals - Description of each configuration parameters.
> + * @offset:    Configuration register offset
> + * @a_delay:   Agnostic Delay (in ps)
> + * @g_delay:   Gnostic Delay (in ps)
> + */
> +struct ti_iodelay_conf_vals {
> +       u16 offset;
> +       u16 a_delay;
> +       u16 g_delay;
> +};

So I don't think it's a good idea to get the register offset from
the device tree. The driver should know these.

> +/**
> + * struct ti_iodelay_reg_values - Computed io_reg configuration values (see TRM)
> + * @coarse_ref_count:  Coarse reference count
> + * @coarse_delay_count:        Coarse delay count
> + * @fine_ref_count:    Fine reference count
> + * @fine_delay_count:  Fine Delay count
> + * @ref_clk_period:    Reference Clock period
> + * @cdpe:              Coarse delay parameter
> + * @fdpe:              Fine delay parameter
> + */
> +struct ti_iodelay_reg_values {
> +       u16 coarse_ref_count;

If you're doing reference counting, use kref.
<linux/kref.h>

> +       u16 coarse_delay_count;
> +
> +       u16 fine_ref_count;

Dito.

> +       u16 fine_delay_count;
> +
> +       u16 ref_clk_period;
> +
> +       u32 cdpe;
> +       u32 fdpe;
> +};


> +/**
> + * struct ti_iodelay_pin_name - name of the pins
> + * @name: name
> + */
> +struct ti_iodelay_pin_name {
> +       char name[IODELAY_REG_NAME_LEN];
> +};

What is this? The pin control subsystem already has a struct
for naming pins. struct pinctrl_pin_desc.

Are you reimplementing core functionality?

The generic pin config reference pins by name, and since you
obviously like to encode these into you data you can just
as well use that method for this too.

Again I think this is a side effect from using the pinctrl-single
concepts, if you think of this as some other pinctrl driver
I think this will fall out nicely.

> +/**
> + * struct ti_iodelay_device - Represents information for a IOdelay instance
> + * @dev: device pointer
> + * @reg_base: Remapped virtual address
> + * @regmap: Regmap for this IOdelay instance
> + * @pctl: Pinctrl device
> + * @desc: pinctrl descriptor for pctl
> + * @pa: pinctrl pin wise description
> + * @names: names of the pins
> + * @groups: list of pinconf groups for iodelay instance
> + * @ngroups: number of groups in the list
> + * @mutex: mutex to protect group list modification
> + * @reg_data: Register definition data for the IODelay instance
> + * @reg_init_conf_values: Initial configuration values.
> + */
> +struct ti_iodelay_device {
> +       struct device *dev;
> +       void __iomem *reg_base;
> +       struct regmap *regmap;
> +
> +       struct pinctrl_dev *pctl;
> +       struct pinctrl_desc desc;
> +       struct pinctrl_pin_desc *pa;
> +       struct ti_iodelay_pin_name *names;

Unhappy about that. pinctrl_desc contains
struct pinctrl_pin_desc const *pins; !

> +
> +       struct list_head groups;
> +       int ngroups;
> +       struct mutex mutex; /* list protection */

Why is this needed? Usually the pin control core
serialize calls into the drivers. Care to explain? Have
the potential race really triggered?

> +static inline u32 ti_iodelay_compute_dpe(u16 period, u16 ref, u16 delay,
> +                                        u16 delay_m)
> +{
> +       u64 m, d;
> +
> +       /* Handle overflow conditions */
> +       m = 10 * (u64)period * (u64)ref;
> +       d = 2 * (u64)delay * (u64)delay_m;
> +
> +       /* Truncate result back to 32 bits */
> +       return div64_u64(m, d);
> +}

Serious business ...

> +/**
> + * ti_iodelay_pinconf_set() - Configure the pin configuration
> + * @iod:       IODelay device
> + * @val:       Configuration value
> + *
> + * Update the configuration register as per TRM and lockup once done.
> + * *IMPORTANT NOTE* SoC TRM does recommend doing iodelay programmation only
> + * while in Isolation. But, then, isolation also implies that every pin
> + * on the SoC(including DDR) will be isolated out. The only benefit being
> + * a glitchless configuration, However, the intent of this driver is purely
> + * to support a "glitchy" configuration where applicable.
> + *
> + * Return: 0 in case of success, else appropriate error value
> + */
> +static int ti_iodelay_pinconf_set(struct ti_iodelay_device *iod,
> +                                 struct ti_iodelay_conf_vals *val)
> +{
> +       const struct ti_iodelay_reg_data *reg = iod->reg_data;
> +       struct ti_iodelay_reg_values *ival = &iod->reg_init_conf_values;
> +       struct device *dev = iod->dev;
> +       u32 g_delay_coarse, g_delay_fine;
> +       u32 a_delay_coarse, a_delay_fine;
> +       u32 c_elements, f_elements;
> +       u32 total_delay;
> +       u32 reg_mask, reg_val, tmp_val;
> +       int r;
> +
> +       /* NOTE: Truncation is expected in all division below */
> +       g_delay_coarse = val->g_delay / 920;
> +       g_delay_fine = ((val->g_delay % 920) * 10) / 60;
> +
> +       a_delay_coarse = val->a_delay / ival->cdpe;
> +       a_delay_fine = ((val->a_delay % ival->cdpe) * 10) / ival->fdpe;
> +
> +       c_elements = g_delay_coarse + a_delay_coarse;
> +       f_elements = (g_delay_fine + a_delay_fine) / 10;
> +
> +       if (f_elements > 22) {
> +               total_delay = c_elements * ival->cdpe + f_elements * ival->fdpe;
> +               c_elements = total_delay / ival->cdpe;
> +               f_elements = (total_delay % ival->cdpe) / ival->fdpe;
> +       }
> +
> +       reg_mask = reg->signature_mask;
> +       reg_val = reg->signature_value << __ffs(reg->signature_mask);
> +
> +       reg_mask |= reg->binary_data_coarse_mask;
> +       tmp_val = c_elements << __ffs(reg->binary_data_coarse_mask);
> +       if (tmp_val & ~reg->binary_data_coarse_mask) {
> +               dev_err(dev, "Masking overflow of coarse elements %08x\n",
> +                       tmp_val);
> +               tmp_val &= reg->binary_data_coarse_mask;
> +       }
> +       reg_val |= tmp_val;
> +
> +       reg_mask |= reg->binary_data_fine_mask;
> +       tmp_val = f_elements << __ffs(reg->binary_data_fine_mask);
> +       if (tmp_val & ~reg->binary_data_fine_mask) {
> +               dev_err(dev, "Masking overflow of fine elements %08x\n",
> +                       tmp_val);
> +               tmp_val &= reg->binary_data_fine_mask;
> +       }
> +       reg_val |= tmp_val;
> +
> +       /* Write with lock value - we DONOT want h/w updates */
> +       reg_mask |= reg->lock_mask;
> +       reg_val |= reg->lock_val << __ffs(reg->lock_mask);
> +       r = regmap_update_bits(iod->regmap, val->offset, reg_mask, reg_val);
> +
> +       dev_dbg(dev, "Set reg 0x%x Delay(a=%d g=%d), Elements(C=%d F=%d)0x%x\n",
> +               val->offset, val->a_delay, val->g_delay, c_elements,
> +               f_elements, reg_val);
> +
> +       return r;
> +}

Looking at this terse thing I think it's obviously easier to use
a more verbose device tree description with

drive-delay = <some SI unit>;


> +       /* unlock the IOdelay region */
> +       r = regmap_update_bits(iod->regmap, reg->reg_global_lock_offset,
> +                              reg->global_lock_mask, reg->global_unlock_val);
> +       if (r)
> +               return r;
> +
> +       /* Read up Recalibration sequence done by bootloader */
> +       r = regmap_read(iod->regmap, reg->reg_refclk_offset, &val);
> +       if (r)
> +               return r;
> +       ival->ref_clk_period = ti_iodelay_extract(val, reg->refclk_period_mask);
> +       dev_dbg(dev, "refclk_period=0x%04x\n", ival->ref_clk_period);

That sounds hightec. So the bootloader calibrates the delays
and  computes the refclock period? So is that sime PLL or something?

> +       r = regmap_read(iod->regmap, reg->reg_coarse_offset, &val);
> +       if (r)
> +               return r;
> +       ival->coarse_ref_count =
> +           ti_iodelay_extract(val, reg->coarse_ref_count_mask);
> +       ival->coarse_delay_count =
> +           ti_iodelay_extract(val, reg->coarse_delay_count_mask);
> +       if (!ival->coarse_delay_count) {
> +               dev_err(dev, "Invalid Coarse delay count (0) (reg=0x%08x)\n",
> +                       val);
> +               return -EINVAL;
> +       }
> +       ival->cdpe = ti_iodelay_compute_dpe(ival->ref_clk_period,
> +                                           ival->coarse_ref_count,
> +                                           ival->coarse_delay_count, 88);

88? What does that mean... This should be #defined I think.

> +static int ti_iodelay_dt_node_to_map(struct pinctrl_dev *pctldev,
> +                                    struct device_node *np,
> +                                    struct pinctrl_map **map,
> +                                    unsigned *num_maps)

If you use the generic bindings this quite complex parsing and
everything associated with it goes away into the core.

> +static void ti_iodelay_dt_free_map(struct pinctrl_dev *pctldev,
> +                                  struct pinctrl_map *map, unsigned num_maps)

Dito.

BTW even if you proceed this way I suspect these are verbatim
copies from pinctrl-single so they shold obviouslyt be abstracted
out as library functions in that case.

> +/**
> + * ti_iodelay_pinctrl_get_group_pins() - get group pins
> + * @pctldev:   pinctrl device representing IODelay device
> + * @gselector: Group selector
> + * @pins:      pointer to the pins
> + * @npins:     number of pins
> + *
> + * Dummy implementation since we do not track pins, we track configurations
> + * Forced by pinctrl's pinctrl_check_ops()
> + *
> + * Return: -EINVAL
> + */
> +static int ti_iodelay_pinctrl_get_group_pins(struct pinctrl_dev *pctldev,
> +                                            unsigned gselector,
> +                                            const unsigned **pins,
> +                                            unsigned *npins)
> +{
> +       /* Dummy implementation - we dont do pin mux */
> +       return -EINVAL;
> +}

This is not about muxing. It is about enumerating the pins in the
group that will be affected by the setting, which is something you
will want to do when using the generic bindings.

> +       group = ti_iodelay_get_group(iod, gselector);

And this seems to be your re-implementation of exactly that pin control
core functionality. Which again should be shared with pinctrl-single if
you anyway go down this path.

I'll halt review here pending discussion on the bindings & stuff.

Yours,
Linus Walleij
