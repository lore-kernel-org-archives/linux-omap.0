From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 03/11] OMAP: UART: omap_device converions, remove implicit 8520 assumptions
Date: Fri, 17 Sep 2010 16:43:23 -0700
Message-ID: <87ocbwrl5w.fsf@deeprootsystems.com>
References: <14049.10.24.255.18.1284739601.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <14049.10.24.255.18.1284739601.squirrel@dbdmail.itg.ti.com>
	(Govindraj R.'s message of "Fri, 17 Sep 2010 21:36:41 +0530 (IST)")
Sender: linux-serial-owner@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

"Govindraj.R" <govindraj.raja@ti.com> writes:

> From: Kevin Hilman <khilman@ti.com>
>
> Major rework of OMAP UART init for omap_device conversion as well as
> use with either 8250 driver or new omap-serial driver.
>
> In preparation for a new omap-serial driver, remove 8250 assumptions
> and dependencies from the serial core.
>
> Convert UART core and PM support to use omap_device layer. Also add
> support for both console on 8250 or omap-serial driver.
>
> omap_device conversion:
> - Convert clock API calls to omap_device calls
> - Remove all static platform_data setup and configuration.  This is
>   all done by the omap_device build phase.
>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
>  arch/arm/mach-omap2/serial.c |  528 +++++++++++++++++++++---------------------
>  1 files changed, 259 insertions(+), 269 deletions(-)
>

[...]

> +	/*
> +	 * Need to block sleep long enough for interrupt driven
> +	 * driver to start.  Console driver is in polling mode
> +	 * so device needs to be kept enabled while polling driver
> +	 * is in use.
> +	 */
> +	uart->timeout = (30 * HZ);

My fault, but there's a bug here.  This long timeout is only needed
when the init-time timout is non-zero, so should be:

	if (uart->timeout)
		uart->timeout = (30 * HZ);

Without this, even though the default timeout is zero (meaning, UARTs
should not timeout and go idle), a timer will fire 30 seconds after boot
and cause the UARTs to go idle.

I discovered this when seeing the UARTs go idle, even though the
timeouts were all set to zero.

Can you fold this into your the next version?

Thanks,

Kevin
