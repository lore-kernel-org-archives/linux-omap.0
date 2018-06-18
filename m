From: Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH] ARM: dts: am33xx: Add pinmux data for mmc1 in am335x-evm,
 evmsk and beaglebone
Date: Mon, 18 Jun 2018 15:57:07 -0500
Message-ID: <CAOCHtYjrgRTAz4ZfkQVWL0YzC8SGbC9p1b8VYJ1TWLy5JXs3mQ@mail.gmail.com>
References: <1523447304-21037-1-git-send-email-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1523447304-21037-1-git-send-email-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Apr 11, 2018 at 6:48 AM, Faiz Abbas <faiz_abbas@ti.com> wrote:
> am335x-evm, am335x-evmsk and am335x-beaglebone are currently relying on
> pinmux set by the bootloader to set the correct value for mmc1. Fix
> this by adding pinmux data for the same in kernel.
>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  arch/arm/boot/dts/am335x-bone-common.dtsi | 9 ++++++++-
>  arch/arm/boot/dts/am335x-evm.dts          | 9 ++++++++-
>  arch/arm/boot/dts/am335x-evmsk.dts        | 9 ++++++++-
>  3 files changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
> index e67b4d6..f9e8667 100644
> --- a/arch/arm/boot/dts/am335x-bone-common.dtsi
> +++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
> @@ -161,7 +161,14 @@
>
>         mmc1_pins: pinmux_mmc1_pins {
>                 pinctrl-single,pins = <
> -                       AM33XX_IOPAD(0x960, PIN_INPUT | MUX_MODE7) /* GPIO0_6 */
> +                       AM33XX_IOPAD(0x960, PIN_INPUT | MUX_MODE7)              /* spio0_cs1.gpio0_6 */
> +                       AM33XX_IOPAD(0x8fc, PIN_INPUT_PULLUP | MUX_MODE0)       /* mmc0_dat0.mmc0_dat0 */
> +                       AM33XX_IOPAD(0x8f8, PIN_INPUT_PULLUP | MUX_MODE0)       /* mmc0_dat1.mmc0_dat1 */
> +                       AM33XX_IOPAD(0x8f4, PIN_INPUT_PULLUP | MUX_MODE0)       /* mmc0_dat2.mmc0_dat2 */
> +                       AM33XX_IOPAD(0x8f0, PIN_INPUT_PULLUP | MUX_MODE0)       /* mmc0_dat3.mmc0_dat3 */
> +                       AM33XX_IOPAD(0x904, PIN_INPUT_PULLUP | MUX_MODE0)       /* mmc0_cmd.mmc0_cmd */
> +                       AM33XX_IOPAD(0x900, PIN_INPUT_PULLUP | MUX_MODE0)       /* mmc0_clk.mmc0_clk */
> +                       AM33XX_IOPAD(0x9a0, PIN_INPUT | MUX_MODE4)              /* mcasp0_aclkr.mmc0_sdwp */

We went one pin too far on the Beagle's here:

0x9a0 ( mcasp0_aclkr.mmc0_sdwp ) = Routed to P9_42, (muxed with C18,
to a shared pin on the header), so not connected to the microSD
socket...

https://github.com/beagleboard/beaglebone-black/blob/master/BBB_SCH.pdf

Looking at this evm schematic, it looks like 0x9a0 should be removed
too, but I'm not sure on all revisions:

http://processors.wiki.ti.com/images/a/a2/TMDSSK3358_3H0009_REV1_2B_SCH.pdf

Regards,

-- 
Robert Nelson
https://rcn-ee.com/
