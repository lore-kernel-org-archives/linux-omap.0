From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/12] ARM: dts: Add iodelay data for MMC
Date: Thu, 10 Aug 2017 09:33:56 -0700
Message-ID: <20170810163356.GF8569@atomide.com>
References: <20170616115439.8508-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170616115439.8508-1-kishon@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: nsekhar@ti.com, Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Russell King <linux@armlinux.org.uk>
List-Id: linux-omap@vger.kernel.org

* Kishon Vijay Abraham I <kishon@ti.com> [170616 04:54]:
> This is the second part of the series originally sent as
> part of [1] with one important modification.
> 
> Now PINCTRL_TI_IODELAY will be enabled for SOC_DRA7XX
> (in mach-omap2/Kconfig) so that omap2plus_defconfig or
> multi_v7_defconfig don't have to be modified.
> 
> This series only adds data and it won't be used until
> the next series which adds UHS support to omap_hsmmc driver.

Applying these finally into omap-for-v4.14/dt thanks.

Tony
