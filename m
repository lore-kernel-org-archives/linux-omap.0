From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V3 16/17] irqchip/gic: Prepare for adding platform driver
Date: Fri, 6 May 2016 15:09:51 +0100
Message-ID: <572CA5AF.7080504@nvidia.com>
References: <1462379130-11742-1-git-send-email-jonathanh@nvidia.com>
 <1462379130-11742-17-git-send-email-jonathanh@nvidia.com>
 <572B54F4.2080103@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <572B54F4.2080103-5wv7dgnIgG8@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Marc,

On 05/05/16 15:13, Marc Zyngier wrote:

[...]

> Gahhh. No. Please. Last time we did that, it took 6 months to untangle
> the mess people made by adding their own hacks in this structure, 
> so I definitely want to keep it completely private, forever. Same goes
> for the gic_{dist,cpu.pm}_init() functions.

OK.

> I've had a go at this, and came up with the following patch. I've only
> briefly tested it on a host and a VM, so it is likely to break some stuff
> somewhere, but you'll get the idea: The gic_chip_data struct is entirely
> opaque, allocated by the GIC driver itself, with a few new fields in
> it so that it becomes self-contained. This applies on top of your series.
> 
> It should also make it easy to switch to a model where we allocate
> the structure dynamically instead of the old static crap.
> 
> Thoughts?

Yes I have been doing some testing and with a couple tweaks we can make
something like this work. One thing that caught me out was ...

> +int gic_of_setup(struct device_node *node, struct device *dev,
> +		 struct gic_chip_data **gicp)
> +{
> +	struct gic_chip_data *gic;
>  
> -	*cpu_base = of_iomap(node, 1);
> -	if (WARN(!*cpu_base, "unable to map gic cpu registers\n")) {
> -		iounmap(*dist_base);
> -		return -ENOMEM;
> +	if (!node || !gicp)
> +		return -EINVAL;
> +
> +	if (dev) {
> +		*gicp = devm_kzalloc(dev, sizeof(*gic), GFP_KERNEL);
> +		if (!*gicp)
> +			return -ENOMEM;
>  	}
>  
> -	if (of_property_read_u32(node, "cpu-offset", percpu_offset))
> -		*percpu_offset = 0;
> +	gic = *gicp;
> +
> +	gic->raw_dist_base = of_iomap(node, 0);
> +	if (WARN(!gic->raw_dist_base, "unable to map gic dist registers\n"))
> +		goto err;
> +
> +	gic->raw_cpu_base = of_iomap(node, 1);
> +	if (WARN(!gic->raw_cpu_base, "unable to map gic cpu registers\n"))
> +		goto err;
> +
> +	if (of_property_read_u32(node, "cpu-offset", &gic->percpu_offset))
> +		gic->percpu_offset = 0;
>  
> +	gic->chip.parent_device = dev;

We can't initialise the device here as it gets overwritten in the
gic_init_bases. So I have had to re-organise things a bit. Good news is
that I have eliminated the call from the platform driver to
gic_init_bases so we only have a single call to initialise the GIC.

Cheers
Jon
