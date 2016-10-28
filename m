From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/4] pinctrl: single: Use generic parser and
 #pinctrl-cells for pinctrl-single,pins
Date: Fri, 28 Oct 2016 09:55:47 -0700
Message-ID: <20161028165547.7pigv2bh6eydtg5m@atomide.com>
References: <20161025164538.453-1-tony@atomide.com>
 <20161025164538.453-3-tony@atomide.com>
 <20161026141628.x42rbn5o2ekdoluk@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161026141628.x42rbn5o2ekdoluk@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jon Hunter <jonathanh@nvidia.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Nishanth Menon <nm@ti.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [161026 07:17]:
> * Tony Lindgren <tony@atomide.com> [161025 09:51]:
> > We can now use generic parser. To support the legacy binding without
> > #pinctrl-cells, add pcs_quirk_missing_pinctrl_cells() and warn about
> > missing #pinctrl-cells.
> ...
> 
> > +/**
> > + * pcs_quirk_missing_pinctrl_cells - handle legacy binding
> > + * @pcs: pinctrl driver instance
> > + * @np: device tree node
> > + * @cells: number of cells
> > + *
> > + * Handle legacy binding with no #pinctrl-cells. This should be
> > + * always two pinctrl-single,bit-per-mux and one for others.
> > + * At some point we may want to consider removing this.
> > + */
> > +static int pcs_quirk_missing_pinctrl_cells(struct pcs_device *pcs,
> > +					   struct device_node *np,
> > +					   int cells)
> > +{
> > +	struct property *p;
> > +	const char *name = "#pinctrl-cells";
> > +	int error;
> > +	u32 val;
> > +
> > +	error = of_property_read_u32(np, name, &val);
> > +	if (!error)
> > +		return 0;
> > +
> > +	dev_warn(pcs->dev, "please update dts to use %s = <%i>\n",
> > +		 name, cells);
> > +
> > +	p = devm_kzalloc(pcs->dev, sizeof(*p), GFP_KERNEL);
> > +	if (!p)
> > +		return -ENOMEM;
> > +
> > +	p->length = sizeof(__be32);
> > +	p->value = devm_kzalloc(pcs->dev, sizeof(__be32), GFP_KERNEL);
> > +	if (!p->value)
> > +		return -ENOMEM;
> > +	*(__be32 *)p->value = cpu_to_be32(cells);
> > +
> > +	p->name = devm_kstrdup(pcs->dev, name, GFP_KERNEL);
> > +	if (!p->name)
> > +		return -ENOMEM;
> > +
> > +	pcs->missing_nr_pinctrl_cells = p;
> > +
> > +	return of_add_property(np, pcs->missing_nr_pinctrl_cells);
> > +}
> 
> Looking at some make randconfig results, looks like we don't have
> of_add_property() and of_remove_property() exported. Is there some
> reason not to export them?

I'll only do of_add_property() and of_remove_property() if we have
IS_BUILTIN(CONFIG_PINCTRL_SINGLE). I bet I'm the only one using it
as a loadable module right now :) Then we can remove those if we
decide to export of_add_property() and of_remove_property().

Regards,

Tony
