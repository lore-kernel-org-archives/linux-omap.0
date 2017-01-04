From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/2] pinctrl: Introduce TI IOdelay configuration driver
Date: Wed, 4 Jan 2017 07:32:42 -0600
Message-ID: <20170104133242.f4fis3hopegkwiab@rob-hp-laptop>
References: <20161230183732.5595-1-tony@atomide.com>
 <20161230183732.5595-3-tony@atomide.com>
 <20170102221228.GH9325@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170102221228.GH9325@atomide.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Gary Bisson <gary.bisson@boundarydevices.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Mark Rutland <mark.rutland@arm.com>, Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, Lokesh Vutla <lokeshvutla@ti.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Jan 02, 2017 at 02:12:28PM -0800, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [161230 10:38]:
> > +static struct pinctrl_ops ti_iodelay_pinctrl_ops = {
> > +	.get_groups_count = pinctrl_generic_get_group_count,
> > +	.get_group_name = pinctrl_generic_get_group_name,
> > +	.get_group_pins = pinctrl_generic_get_group_pins,
> > +	.pin_dbg_show = ti_iodelay_pin_dbg_show,
> > +	.dt_node_to_map = ti_iodelay_dt_node_to_map,
> > +};
> > +
> > +static struct pinconf_ops ti_iodelay_pinctrl_pinconf_ops = {
> > +	.pin_config_group_get = ti_iodelay_pinconf_group_get,
> > +	.pin_config_group_set = ti_iodelay_pinconf_group_set,
> > +#ifdef CONFIG_DEBUG_FS
> > +	.pin_config_group_dbg_show = ti_iodelay_pinconf_group_dbg_show,
> > +#endif
> 
> I noticed that .pin_dbg_show above needs ifdef CONFIG_DEBUGFS.
> Updated patch below.
> 
> Regards,
> 
> Tony
> 
> 8< --------------------
> From tony Mon Sep 17 00:00:00 2001
> From: Nishanth Menon <nm@ti.com>
> Date: Tue, 27 Dec 2016 08:03:43 -0800
> Subject: [PATCH] pinctrl: Introduce TI IOdelay configuration driver
> 
> SoC family such as DRA7 family of processors have, in addition
> to the regular muxing of pins (as done by pinctrl-single), a separate
> hardware module called IODelay which is also expected to be configured.
> The "IODelay" module has it's own register space that is independent
> of the control module and the padconf register area.
> 
> With recent changes to the pinctrl framework, we can now support
> this hardware with a reasonably minimal driver by using #pinctrl-cells,
> GENERIC_PINCTRL_GROUPS and GENERIC_PINMUX_FUNCTIONS.
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
> IMPORTANT NOTE: we take the approach of keeping LOCK_BITs cleared
> to 0x0 at all times, even when configuring Manual IO Timing Modes.
> This is done by eliminating the LOCK_BIT=1 setting from Step
> of the Manual IO timing Mode configuration procedure. This option
> leaves the CFG_* registers unprotected from unintended writes to the
> CTRL_CORE_PAD_* registers while Manual IO Timing Modes are configured.
> 
> This approach is taken to allow for a generic driver to exist in kernel
> world that has to be used carefully in required usecases.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> [tony@atomide.com: updated to use generic pinctrl functions, added
>  binding documentation, updated comments]
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  .../devicetree/bindings/pinctrl/ti,iodelay.txt     |  47 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/pinctrl/Kconfig                            |   1 +
>  drivers/pinctrl/Makefile                           |   1 +
>  drivers/pinctrl/ti/Kconfig                         |  10 +
>  drivers/pinctrl/ti/Makefile                        |   1 +
>  drivers/pinctrl/ti/pinctrl-ti-iodelay.c            | 947 +++++++++++++++++++++
>  6 files changed, 1007 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/ti,iodelay.txt
>  create mode 100644 drivers/pinctrl/ti/Kconfig
>  create mode 100644 drivers/pinctrl/ti/Makefile
>  create mode 100644 drivers/pinctrl/ti/pinctrl-ti-iodelay.c
