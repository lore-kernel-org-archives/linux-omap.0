From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH] ARM: Replace strncmp with str_has_prefix
Date: Mon, 05 Aug 2019 11:31:57 -0700
Message-ID: <7hzhknh3aa.fsf@baylibre.com>
References: <20190730024426.17262-1-hslester96@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190730024426.17262-1-hslester96@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Alexander Clouter <alex@digriz.org.uk>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@bootlin.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
List-Id: linux-omap@vger.kernel.org

Chuhong Yuan <hslester96@gmail.com> writes:

> In commit b6b2735514bc
> ("tracing: Use str_has_prefix() instead of using fixed sizes")
> the newly introduced str_has_prefix() was used
> to replace error-prone strncmp(str, const, len).
> Here fix codes with the same pattern.
>
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>  arch/arm/kernel/module-plts.c        | 2 +-
>  arch/arm/mach-omap2/omap_device.c    | 4 ++--
>  arch/arm/mach-omap2/pm-debug.c       | 8 ++++----
>  arch/arm/mach-omap2/pm.c             | 2 +-
>  arch/arm/mach-omap2/pm44xx.c         | 2 +-
>  arch/arm/mach-omap2/sr_device.c      | 8 ++++----
>  arch/arm/mach-orion5x/ts78xx-setup.c | 4 ++--

For the OMAP stuff:

Reviewed-by: Kevin Hilman <khilman@baylibre.com>  # arch/arm/mach-omap2/*

Kevin
