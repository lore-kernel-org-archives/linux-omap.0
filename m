From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCHv2 0/7] Non-urgent fixes and improvments for omap3-rom-rng
Date: Sat, 5 Oct 2019 01:40:41 +1000
Message-ID: <20191004154041.GL5148@gondor.apana.org.au>
References: <20190914210300.15836-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190914210300.15836-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Matt Mackall <mpm@selenic.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-crypto@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Adam Ford <aford173@gmail.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Rob Herring <robh+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, Tero Kristo <t-kristo@ti.com>, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sat, Sep 14, 2019 at 02:02:53PM -0700, Tony Lindgren wrote:
> Hi all,
> 
> Here are fixes and improvments for omap3-rom-rng that's been broken for
> a while.
> 
> The first four patches get it working, and then the last two patches add
> support for runtime PM.
> 
> I did not add Sebastian's acks from v1 set as many of the patches
> changed. Please review again :)
> 
> Regards,
> 
> Tony
> 
> Changes since v1:
> - Use clk_prepare_enable() as pointed out by Sebastian
> - Simplify runtime PM changes patch
> - Add a new patch for devm changes as suggested by Sebastian
> 
> 
> Tony Lindgren (7):
>   ARM: OMAP2+: Check omap3-rom-rng for GP device instead of HS device
>   hwrng: omap3-rom - Fix missing clock by probing with device tree
>   hwrng: omap3-rom - Call clk_disable_unprepare() on exit only if not
>     idled
>   hwrng: omap3-rom - Initialize default quality to get data
>   hwrng: omap3-rom - Update to use standard driver data
>   hwrng: omap3-rom - Use runtime PM instead of custom functions
>   hwrng: omap3-rom - Use devm hwrng and runtime PM
> 
>  .../devicetree/bindings/rng/omap3_rom_rng.txt |  27 +++
>  arch/arm/boot/dts/omap3-n900.dts              |   6 +
>  arch/arm/mach-omap2/pdata-quirks.c            |  14 +-
>  drivers/char/hw_random/omap3-rom-rng.c        | 168 +++++++++++-------
>  4 files changed, 139 insertions(+), 76 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/rng/omap3_rom_rng.txt

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
