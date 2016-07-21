From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] ARM: DRA7: select PCI_DOMAINS config
Date: Thu, 21 Jul 2016 14:04:33 +0200
Message-ID: <8047226.VhgpLo8JQu@wuerfel>
References: <1469102276-14777-1-git-send-email-kishon@ti.com> <1469102276-14777-3-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1469102276-14777-3-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

On Thursday, July 21, 2016 5:27:56 PM CEST Kishon Vijay Abraham I wrote:
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 1a648e9..8e6e2c0 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -86,6 +86,7 @@ config SOC_DRA7XX
>         select OMAP_INTERCONNECT_BARRIER
>         select PM_OPP if PM
>         select ZONE_DMA if ARM_LPAE
> +       select PCI_DOMAINS if PCI
>  
>  config ARCH_OMAP2PLUS
>         bool
> 

Should we just set this unconditionally for ARCH_MULTIPLATFORM maybe?

	Arnd
