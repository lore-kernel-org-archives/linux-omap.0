From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] ARM: dts: am335x: Replaced register offsets with
 defines
Date: Thu, 14 Mar 2019 08:05:24 -0700
Message-ID: <20190314150524.GB19425@atomide.com>
References: <20190313142724.27446-1-cquast@hanoverdisplays.com>
 <20190313142724.27446-3-cquast@hanoverdisplays.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190313142724.27446-3-cquast@hanoverdisplays.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christina Quast <cquast@hanoverdisplays.com>
Cc: bcousson@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com, mpfj@newflow.co.uk, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Christina Quast <cquast@hanoverdisplays.com> [190313 14:28]:
> The defines are taken from dt-bindings/pinctrl/am335x.h
> 
> Updated AM33XX_IOPAD to take three instead of two parameters:
> AM33XX_IOPAD(register_offset, pin_direction_pullups, mux_mode)

Thanks that works great for making things work eventually
with #pinctrl-cells = <2> :)

> +			AM33XX_IOPAD(AM335X_PIN_UART1_RXD, PIN_INPUT, MUX_MODE0)      /* uart1_rxd */
> +			AM33XX_IOPAD(AM335X_PIN_UART1_TXD, PIN_INPUT, MUX_MODE0)      /* uart1_txd *

Since it sounds like you're modifying these with a script,
just leave out any nop comments while at it where the comment
is just the pad name already there in the new register
define. Some comments might need to be preserved, but my
guess is that they're mostly just the pad name.

And I suggest you split this change to a seprate patch
for each board so in case of trouble we can revert the
changes for a single board if needed.

Regards,

Tony
