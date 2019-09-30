From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/7] hwrng: omap3-rom - Fix missing clock by probing with
 device tree
Date: Mon, 30 Sep 2019 17:20:20 -0500
Message-ID: <20190930222020.GA13078@bogus>
References: <20190914210300.15836-1-tony@atomide.com>
 <20190914210300.15836-3-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190914210300.15836-3-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-crypto@vger.kernel.org, devicetree@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Adam Ford <aford173@gmail.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

On Sat, 14 Sep 2019 14:02:55 -0700, Tony Lindgren wrote:
> Commit 0ed266d7ae5e ("clk: ti: omap3: cleanup unnecessary clock aliases")
> removed old omap3 clock framework aliases but caused omap3-rom-rng to
> stop working with clock not found error.
> 
> Based on discussions on the mailing list it was requested by Tero Kristo
> that it would be best to fix this issue by probing omap3-rom-rng using
> device tree to provide a proper clk property. The other option would be
> to add back the missing clock alias, but that does not help moving things
> forward with removing old legacy platform_data.
> 
> Let's also add a proper device tree binding and keep it together with
> the fix.
> 
> Cc: devicetree@vger.kernel.org
> Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> Cc: Adam Ford <aford173@gmail.com>
> Cc: Pali Rohár <pali.rohar@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Tero Kristo <t-kristo@ti.com>
> Fixes: 0ed266d7ae5e ("clk: ti: omap3: cleanup unnecessary clock aliases")
> Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  .../devicetree/bindings/rng/omap3_rom_rng.txt | 27 +++++++++++++++++++
>  arch/arm/boot/dts/omap3-n900.dts              |  6 +++++
>  arch/arm/mach-omap2/pdata-quirks.c            | 12 +--------
>  drivers/char/hw_random/omap3-rom-rng.c        | 17 ++++++++++--
>  4 files changed, 49 insertions(+), 13 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/rng/omap3_rom_rng.txt
> 

Acked-by: Rob Herring <robh@kernel.org>
