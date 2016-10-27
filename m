From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/4] pinctrl: Introduce generic #pinctrl-cells and pinctrl_parse_index_with_args
Date: Thu, 27 Oct 2016 09:56:26 +0200
Message-ID: <CACRpkdYWB4aa2XvW-yT39cKqy3XChSwCiFRy1mVWhbhse63=3A@mail.gmail.com>
References: <20161025164538.453-1-tony@atomide.com> <20161025164538.453-2-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161025164538.453-2-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Jon Hunter <jonathanh@nvidia.com>, Mark Rutland <mark.rutland@arm.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Nishanth Menon <nm@ti.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 25, 2016 at 6:45 PM, Tony Lindgren <tony@atomide.com> wrote:

I need some DT person to take a look at this binding and ACK it.

> +For pin controller hardware with a large number of identical registers naming
> +each bit both can be unmaintainable. Further there can be a large number of similar
> +pinctrl hardware using the same registers for different purposes depending on the
> +packaging. For cases like this, the pinctrl driver may use pinctrl-pin-array helper
> +binding using a hardware based index and a number of configuration values:

Maybe we can reword it a bit so that it is clear that this is an
either-or approach
for the pin controller, either they use the pins/groups/functions scheme
or they use this scheme.

> +pincontroller {
> +       ... /* Standard DT properties for the device itself elided */
> +       #pinctrl-cells = <2>;
> +
> +       state_0_node_a {
> +               pinctrl-pin-array = <
> +                       0 A_DELAY_PS(0) G_DELAY_PS(120)
> +                       4 A_DELAY_PS(0) G_DELAY_PS(360)
> +                       ...
> +               >;
> +       };
> +       ...
> +};

Looks all right to me. Sad to add to the binding mess, but on the other
hand, in the overall picture this nicely consolidates and structure
pinctrl-single.

> +The index for pinctrl-pin-array must relate to the hardware for the pinctrl
> +registers, and must not be a virtual index of pin instances. The reason for
> +this is to avoid mapping of the index in the dts files and the pin controller
> +driver as it can change.

OK

> And we want to avoid another case of interrupt
> +numbering with pinctrl numbering.

Maybe this file is not a good place for making technical arguments,
more describing what we agreed on, so cut that sentence IMO.

> +/*
> + * For pinctrl binding, typically #pinctrl-cells is for the pin controller
> + * device, so either parent or grandparent. See pinctrl-bindings.txt.
> + */
> +static int pinctrl_find_cells_size(const struct device_node *np,
> +                                  const char *cells_name)
> +{
> +       int cells_size, error;
> +
> +       error = of_property_read_u32(np->parent, cells_name, &cells_size);
> +       if (error) {
> +               error = of_property_read_u32(np->parent->parent,
> +                                            cells_name, &cells_size);
> +               if (error)
> +                       return -ENOENT;
> +       }
> +
> +       return cells_size;
> +}

Can't we just hardcode this to "#pinctrl-cells" and skip the cells_name
parameter? We can parametrize it the day we need it instead.

The rest of the helpers look nice and clean.

Yours,
Linus Walleij
