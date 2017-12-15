From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] arm: dts: Remove leading 0x and 0s from bindings notation
Date: Fri, 15 Dec 2017 09:59:55 +0100
Message-ID: <CAJKOXPeLiPfoUfpPU-sAAOuD057kTzRE-g4bFq4afFOOtRRZOg@mail.gmail.com>
References: <20171214165350.27850-1-malat@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20171214165350.27850-1-malat@debian.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Mathieu Malaterre <malat@debian.org>
Cc: Rob Herring <robh+dt@kernel.org>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Jesper Nilsson <jesper.nilsson@axis.com>, Lars Persson <lars.persson@axis.com>, Niklas Cassel <niklas.cassel@axis.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Florian Fainelli <f.fainelli@gmail.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Kukjin Kim <kgene@kernel.org>, Shawn Guo <shawnguo@kernel.org>Sascha Hauer <ker>
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 14, 2017 at 5:53 PM, Mathieu Malaterre <malat@debian.org> wrote:
> Improve the DTS files by removing all the leading "0x" and zeros to fix the
> following dtc warnings:
>
> Warning (unit_address_format): Node /XXX unit name should not have leading "0x"
>
> and
>
> Warning (unit_address_format): Node /XXX unit name should not have leading 0s
>
> Converted using the following command:
>
> find . -type f \( -iname *.dts -o -iname *.dtsi \) -exec sed -E -i -e "s/@0x([0-9a-fA-F\.]+)\s?\{/@\L\1 \{/g" -e "s/@0+([0-9a-fA-F\.]+)\s?\{/@\L\1 \{/g" {} +
>
> For simplicity, two sed expressions were used to solve each warnings separately.
>
> To make the regex expression more robust a few other issues were resolved,
> namely setting unit-address to lower case, and adding a whitespace before the
> the opening curly brace:
>
> https://elinux.org/Device_Tree_Linux#Linux_conventions
>
> This is a follow up to commit 4c9847b7375a ("dt-bindings: Remove leading 0x from bindings notation")
>
> Reported-by: David Daney <ddaney@caviumnetworks.com>
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  arch/arm/boot/dts/am3517.dtsi                 |  4 +--
>  arch/arm/boot/dts/arm-realview-eb.dtsi        | 18 +++++++-------
>  arch/arm/boot/dts/arm-realview-pb1176.dts     | 18 +++++++-------
>  arch/arm/boot/dts/arm-realview-pb11mp.dts     | 18 +++++++-------
>  arch/arm/boot/dts/arm-realview-pbx.dtsi       | 18 +++++++-------
>  arch/arm/boot/dts/artpec6.dtsi                |  2 +-
>  arch/arm/boot/dts/at91sam9261.dtsi            |  2 +-
>  arch/arm/boot/dts/at91sam9261ek.dts           |  2 +-
>  arch/arm/boot/dts/at91sam9263.dtsi            |  2 +-
>  arch/arm/boot/dts/at91sam9263ek.dts           |  2 +-
>  arch/arm/boot/dts/at91sam9g25ek.dts           |  2 +-
>  arch/arm/boot/dts/at91sam9g45.dtsi            |  2 +-
>  arch/arm/boot/dts/at91sam9m10g45ek.dts        |  2 +-
>  arch/arm/boot/dts/atlas7.dtsi                 | 12 ++++-----
>  arch/arm/boot/dts/bcm11351.dtsi               |  2 +-
>  arch/arm/boot/dts/bcm21664.dtsi               |  2 +-
>  arch/arm/boot/dts/bcm283x.dtsi                |  2 +-
>  arch/arm/boot/dts/da850-lcdk.dts              |  4 +--
>  arch/arm/boot/dts/dm8148-evm.dts              |  8 +++---
>  arch/arm/boot/dts/dm8168-evm.dts              |  8 +++---
>  arch/arm/boot/dts/dra62x-j5eco-evm.dts        |  8 +++---
>  arch/arm/boot/dts/exynos5420.dtsi             | 36 +++++++++++++--------------
>  arch/arm/boot/dts/exynos5422-odroid-core.dtsi |  2 +-
>  arch/arm/boot/dts/imx7d.dtsi                  |  2 +-
>  arch/arm/boot/dts/keystone-k2e-netcp.dtsi     |  2 +-
>  arch/arm/boot/dts/keystone-k2hk-netcp.dtsi    |  2 +-
>  arch/arm/boot/dts/keystone-k2l-netcp.dtsi     |  2 +-
>  arch/arm/boot/dts/omap3-cm-t3x.dtsi           |  8 +++---
>  arch/arm/boot/dts/omap3-evm-37xx.dts          |  8 +++---
>  arch/arm/boot/dts/omap3-lilly-a83x.dtsi       |  8 +++---
>  arch/arm/boot/dts/s3c2416.dtsi                |  2 +-

For Exynos and S3C:
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
