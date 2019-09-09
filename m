From: Adam Ford <aford173@gmail.com>
Subject: Re: [RFC] ARM: omap3: Enable HWMODS for HW Random Number Generator
Date: Mon, 9 Sep 2019 07:13:29 -0500
Message-ID: <CAHCN7xL0fbr=Sv+b=0AuGB1PPhAAFdAFLEd_iBM+ZMTkUw5sHQ@mail.gmail.com>
References: <20190828150037.2640-1-aford173@gmail.com> <20190905230443.GA52127@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190905230443.GA52127@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, Tero Kristo <t-kristo@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Adam Ford <adam.ford@logicpd.com>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Paul Walmsley <paul@pwsan.com>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, arm-soc <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 5, 2019 at 6:04 PM Tony Lindgren <tony@atomide.com> wrote:
>
> Hi,
>
> * Adam Ford <aford173@gmail.com> [190828 15:01]:
> > The datasheet for the AM3517 shows the RNG is connected to L4.
> > It shows the module address for the RNG is 0x480A0000, and it
> > matches the omap2.dtsi description.  Since the driver can support
> > omap2 and omap4, it seems reasonable to assume the omap3 would
> > use the same core for the RNG.
> >
> > This RFC, mimics much of the omap2 hwmods on the OMAP3. It
> > also adds the necessary clock for driving the RNG.  Unfortunately,
> > it appears non-functional.  If anyone has any suggestions on how
> > to finish the hwmod (or port it to the newer l4 device tree
> > format), feedback is requested.
>
> Yup I'll take the bait :) The patch below seems to do the trick
> for me on dm3730 based on translating your patch to probe with
> ti-sysc.
>
> Not sure about 34xx, it seems we're missing rng_clk? Care
> to give it a try and attempt simlar patches for 34xx and
> 3517?
>
> At least I'm not needing the "ti,no-reset-on-init" property
> that your patch has a comment for. Maybe that's needed on
> some other omap3.
>
> Oh and this needs to default to status = "disabled" for
> HS devices like n900 as it needs to use the omap3-rom-rng.
>
> Regards,
>
> Tony
>
> 8< -----------------------
> diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36xx.dtsi
> --- a/arch/arm/boot/dts/omap36xx.dtsi
> +++ b/arch/arm/boot/dts/omap36xx.dtsi
> @@ -140,6 +140,29 @@
>                         };
>                 };
>
> +               rng_target: target-module@480a0000 {
> +                       compatible = "ti,sysc-omap2", "ti,sysc";
> +                       reg = <0x480a003c 0x4>,
> +                             <0x480a0040 0x4>,
> +                             <0x480a0044 0x4>;
> +                       reg-names = "rev", "sysc", "syss";
> +                       ti,sysc-mask = <(SYSC_OMAP2_AUTOIDLE)>;
> +                       ti,sysc-sidle = <SYSC_IDLE_FORCE>,
> +                                       <SYSC_IDLE_NO>;
> +                       ti,syss-mask = <1>;
> +                       clocks = <&rng_ick>;
> +                       clock-names = "ick";
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       ranges = <0 0x480a0000 0x2000>;
> +
> +                       rng: rng@0 {
> +                               compatible = "ti,omap2-rng";
> +                               reg = <0x0 0x2000>;
> +                               interrupts = <52>;
> +                       };
> +               };
> +

Tony,

Can you tell me what branch you're using?  I am not seeing the note
below, so I am not exactly sure what version to base my testing.

ada,
>                 /*
>                  * Note that the sysconfig register layout is a subset of the
>                  * "ti,sysc-omap4" type register with just sidle and midle bits
