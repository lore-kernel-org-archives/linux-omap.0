From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv2 0/7] Non-urgent fixes and improvments for omap3-rom-rng
Date: Mon, 16 Sep 2019 09:47:03 +0300
Message-ID: <364b98db-2b0a-6317-178e-910397b32ffb@ti.com>
References: <20190914210300.15836-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190914210300.15836-1-tony@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: linux-crypto@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Adam Ford <aford173@gmail.com>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Rob Herring <robh+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 15/09/2019 00:02, Tony Lindgren wrote:
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

Series looks fine to me also, don't have possibility to test omap3 ROM 
RNG though (don't have HW for this.) For the whole series:

Reviewed-by: Tero Kristo <t-kristo@ti.com>



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
>    ARM: OMAP2+: Check omap3-rom-rng for GP device instead of HS device
>    hwrng: omap3-rom - Fix missing clock by probing with device tree
>    hwrng: omap3-rom - Call clk_disable_unprepare() on exit only if not
>      idled
>    hwrng: omap3-rom - Initialize default quality to get data
>    hwrng: omap3-rom - Update to use standard driver data
>    hwrng: omap3-rom - Use runtime PM instead of custom functions
>    hwrng: omap3-rom - Use devm hwrng and runtime PM
> 
>   .../devicetree/bindings/rng/omap3_rom_rng.txt |  27 +++
>   arch/arm/boot/dts/omap3-n900.dts              |   6 +
>   arch/arm/mach-omap2/pdata-quirks.c            |  14 +-
>   drivers/char/hw_random/omap3-rom-rng.c        | 168 +++++++++++-------
>   4 files changed, 139 insertions(+), 76 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/rng/omap3_rom_rng.txt
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
