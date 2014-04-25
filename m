From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH/RFC 3/4] of/clk: Register clocks suitable for Runtime PM with the PM core
Date: Fri, 25 Apr 2014 16:44:58 -0700
Message-ID: <7hoazpdldx.fsf@paris.lan>
References: <1398334403-26181-1-git-send-email-geert+renesas@glider.be>
	<1398334403-26181-4-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1398334403-26181-4-git-send-email-geert+renesas@glider.be>
	(Geert Uytterhoeven's message of "Thu, 24 Apr 2014 12:13:22 +0200")
Sender: linux-pm-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Ben Dooks <ben.dooks@codethink.co.uk>, Felipe Balbi <balbi@ti.com>, Mike Turquette <mturquette@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Geert Uytterhoeven <geert+renesas@glider.be> writes:

> When adding a device from DT, check if its clocks are suitable for Runtime
> PM, and register them with the PM core.
> If Runtime PM is disabled, just enable the clock.
>
> This allows the PM core to automatically manage gate clocks of devices for
> Runtime PM.

...unless the device is already in an existing pm_domain, right?

I like this approach, and it extends nicely what we already do on
platforms using drivers/base/power/clock_ops.c into DT land.

My only concern is how this will interact if it's used along with
devices that have existing pm_domains.  I don't have any specific
concerns (yet, because it's Friday, and my brain is turing off), but it
just made me wonder if this will be potentially confusing.
 
Also...

[...]

> +static int of_clk_register(struct device *dev, struct clk *clk)
> +{
> +	int error;
> +
> +	if (!dev->pm_domain) {
> +		error = pm_clk_create(dev);
> +		if (error)
> +			return error;
> +
> +		dev->pm_domain = &of_clk_pm_domain;
> +	}
> +
> +	dev_dbg(dev, "Setting up clock for runtime PM management\n");
> +	return pm_clk_add_clk(dev, clk);

I would've expected these 2 lines to be inside the pm_domain check.

What's the reason for doing the pm_clk_add() when the pm_domain isn't
going to be used?  I suppose it's harmless, but it's a bit confusing.

Kevin
