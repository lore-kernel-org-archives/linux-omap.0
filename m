From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v4 4/7] arm: use the new LED disk activity trigger
Date: Mon, 13 Jun 2016 13:42:16 +0530
Message-ID: <575E6AE0.3040907@ti.com>
References: <20160610060021.12382-1-linz@li-pro.net>
 <20160610060021.12382-4-linz@li-pro.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160610060021.12382-4-linz@li-pro.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephan Linz <linz@li-pro.net>, linux-leds@vger.kernel.org, linux-ide@vger.kernel.org
Cc: =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@armlinux.org.uk>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Kevin Hilman <khilman@kernel.org>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Friday 10 June 2016 11:29 AM, Stephan Linz wrote:
> - dts: rename 'ide-disk' to 'disk-activity'
> - platform: rename 'ide-disk' to 'disk-activity'
> - defconfig: rename 'LEDS_TRIGGER_IDE_DISK' to 'LEDS_TRIGGER_DISK'
> 
> Signed-off-by: Stephan Linz <linz@li-pro.net>
> ---
>  arch/arm/boot/dts/am57xx-beagle-x15.dts  | 2 +-
>  arch/arm/boot/dts/kirkwood-ns2lite.dts   | 2 +-
>  arch/arm/boot/dts/kirkwood-topkick.dts   | 2 +-
>  arch/arm/configs/collie_defconfig        | 2 +-
>  arch/arm/configs/ixp4xx_defconfig        | 2 +-
>  arch/arm/mach-davinci/board-dm644x-evm.c | 2 +-

For the mach-davinci change:

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
