From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v4 4/7] arm: use the new LED disk activity trigger
Date: Thu, 16 Jun 2016 09:16:04 +0200
Message-ID: <87bn31a9jf.fsf@belgarion.home>
References: <20160610060021.12382-1-linz@li-pro.net>
	<20160610060021.12382-4-linz@li-pro.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160610060021.12382-4-linz@li-pro.net> (Stephan Linz's message
	of "Fri, 10 Jun 2016 07:59:59 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Stephan Linz <linz@li-pro.net>
Cc: linux-leds@vger.kernel.org, linux-ide@vger.kernel.org, =?utf-8?Q?Ben?= =?utf-8?Q?o=C3=AEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@armlinux.org.uk>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Stephan Linz <linz@li-pro.net> writes:

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
>  arch/arm/mach-omap1/board-osk.c          | 2 +-
>  arch/arm/mach-pxa/spitz.c                | 2 +-
>  8 files changed, 8 insertions(+), 8 deletions(-)

For mach-pxa:
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
