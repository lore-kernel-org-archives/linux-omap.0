From: Adam Ford <aford173@gmail.com>
Subject: Re: [PATCH] ARM: dts: omap3-beagle-xm: Add fixed 26MHz clock as fck
 for twl
Date: Tue, 1 May 2018 10:30:15 -0500
Message-ID: <CAHCN7x+Ow7B4kTmd+4PkDd=azn-qKMYmEyjqfb8GkXA7Y7pEPA@mail.gmail.com>
References: <20180405115239.17370-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180405115239.17370-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: devicetree <devicetree@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, arm-soc <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Apr 5, 2018 at 6:52 AM, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> The board uses 26MHz oscillator for the twl4030 HFCLK.
> This way we will not depend on the bootloader to configure the
> CFG_BOOT:HFCLK_FREQ
>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> Hi,
>
> there might be other boards (all omap3 boards with twl4030?) which uses the same
> setup, but I only have schematics for beagle-xm.
>

I know I am late coming into this, but we have twl4030_omap3.dtsi for
the items common to omap3. Can we put the clock reference in that
file?

It seems like it would be cleaner than having a dozen boards or so
boards having the exact same copy of the same stuff. SHould something
change in the future, I would think it would make
maintenance easier too.  Just my two cents.

adam

> In order for the driver to actually use the clock the
> [PATCH] mfd: twl-core: Fix clock initialization
> need to be applied. W/o the twl-core patch the clock is just ignored.
>
> Regards,
> Peter
>
>  arch/arm/boot/dts/omap3-beagle-xm.dts | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
> index 0349fcc9dc26..d80587de0bbf 100644
> --- a/arch/arm/boot/dts/omap3-beagle-xm.dts
> +++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
> @@ -30,6 +30,13 @@
>                 ethernet = &ethernet;
>         };
>
> +       /* fixed 26MHz oscillator */
> +       hfclk_26m: oscillator {
> +               #clock-cells = <0>;
> +               compatible = "fixed-clock";
> +               clock-frequency = <26000000>;
> +       };
> +
>         leds {
>                 compatible = "gpio-leds";
>
> @@ -274,6 +281,9 @@
>                 interrupts = <7>; /* SYS_NIRQ cascaded to intc */
>                 interrupt-parent = <&intc>;
>
> +               clocks = <&hfclk_26m>;
> +               clock-names = "fck";
> +
>                 twl_audio: audio {
>                         compatible = "ti,twl4030-audio";
>                         codec {
> --
> Peter
>
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
