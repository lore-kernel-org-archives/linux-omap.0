From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2] ARM: configs: Remove useless UEVENT_HELPER_PATH
Date: Tue, 4 Jun 2019 09:55:36 +0100
Message-ID: <20190604085536.GA23250@e107533-lin.cambridge.arm.com>
References: <1559636093-26005-1-git-send-email-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1559636093-26005-1-git-send-email-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: arm@kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Russell King <linux@armlinux.org.uk>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Vladimir Zapolskiy <vz@mleia.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, Sebastian Hesselbarth <sebastian.he>
List-Id: linux-omap@vger.kernel.org

On Tue, Jun 04, 2019 at 10:14:53AM +0200, Krzysztof Kozlowski wrote:
> Remove the CONFIG_UEVENT_HELPER_PATH because:
> 1. It is disabled since commit 1be01d4a5714 ("driver: base: Disable
>    CONFIG_UEVENT_HELPER by default") as its dependency (UEVENT_HELPER) was
>    made default to 'n',
> 2. It is not recommended (help message: "This should not be used today
>    [...] creates a high system load") and was kept only for ancient
>    userland,
> 3. Certain userland specifically requests it to be disabled (systemd
>    README: "Legacy hotplug slows down the system and confuses udev").
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> ---
> 
> Changes since v2:
> 1. Remove unrelated files.
> 2. Add Geert's ack.
> ---

[...]

> diff --git a/arch/arm/configs/vexpress_defconfig b/arch/arm/configs/vexpress_defconfig
> index d170da388389..25753552277a 100644
> --- a/arch/arm/configs/vexpress_defconfig
> +++ b/arch/arm/configs/vexpress_defconfig
> @@ -45,7 +45,6 @@ CONFIG_IP_PNP_BOOTP=y
>  # CONFIG_WIRELESS is not set
>  CONFIG_NET_9P=y
>  CONFIG_NET_9P_VIRTIO=y
> -CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
>  CONFIG_DEVTMPFS=y
>  CONFIG_DMA_CMA=y
>  CONFIG_MTD=y

(for vexpress)

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
