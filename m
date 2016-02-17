From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH 1/2] dt-bindings: clock: adpll: Add binding documentation for TI
 adpll
Date: Tue, 16 Feb 2016 17:04:40 -0800
Message-ID: <20160217010440.2278.62327@quark.deferred.io>
References: <1455312009-808-1-git-send-email-tony@atomide.com>
 <1455312009-808-2-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1455312009-808-2-git-send-email-tony@atomide.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Stephen Boyd <sboyd@codeaurora.org>, Tero Kristo <t-kristo@ti.com>
Cc: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>, Delio Brignoli <dbrignoli@audioscience.com>, Neil Armstrong <narmstrong@baylibre.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Philipp Rosenberger <ilu@linutronix.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

Quoting Tony Lindgren (2016-02-12 13:20:08)
> Let's add binding documentation for the ADPLL found on dm814x
> and dra62x. The binding uses the standard clock binding.
> 
> Cc: devicetree@vger.kernel.org
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Tero Kristo <t-kristo@ti.com>
> Acked-by: Michael Turquette <mturquette@baylibre.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  .../devicetree/bindings/clock/ti/adpll.txt         | 43 ++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/ti/adpll.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/ti/adpll.txt b/Documentation/devicetree/bindings/clock/ti/adpll.txt
> new file mode 100644
> index 0000000..8516bf0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/ti/adpll.txt
> @@ -0,0 +1,43 @@
> +Binding for Texas Instruments ADPLL clock.
> +
> +Binding status: Unstable - ABI compatibility may be broken in the future
> +
> +This binding uses the common clock binding[1]. It assumes a
> +register-mapped ADPLL with two to three selectable input clocks
> +and three to four children.
> +
> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +Required properties:
> +- compatible : shall be one of "ti,dm814-adpll-s-clock" or
> +  "ti,dm814-adpll-lj-clock" depending on the type of the ADPLL
> +- #clock-cells : from common clock binding; shall be set to 0.

Thanks for the patch.

clock-cells = 1 in both of the examples below (which looks right).

> +- clocks : link phandles of parent clocks clkinp and clkinpulow, note
> +  that the adpll-s-clock also has an optional clkinphif
> +- reg : address and length of the register set for controlling the ADPLL.
> +
> +Examples:
> +       adpll_mpu_ck: adpll@40 {
> +               #clock-cells = <1>;
> +               compatible = "ti,dm814-adpll-s-clock";
> +               reg = <0x40 0x40>;
> +               clocks = <&devosc_ck &devosc_ck &devosc_ck>;
> +               clock-names = "clkinp", "clkinpulow", "clkinphif";
> +               clock-indices = <0>, <1>, <2>, <3>;

Why is clock-indices necessary?

Best regards,
Mike

> +               clock-output-names = "481c5040.adpll.dcoclkldo",
> +                                    "481c5040.adpll.clkout",
> +                                    "481c5040.adpll.clkoutx2",
> +                                    "481c5040.adpll.clkouthif";
> +       };
> +
> +       adpll_dsp_ck: adpll@80 {
> +               #clock-cells = <1>;
> +               compatible = "ti,dm814-adpll-lj-clock";
> +               reg = <0x80 0x30>;
> +               clocks = <&devosc_ck &devosc_ck>;
> +               clock-names = "clkinp", "clkinpulow";
> +               clock-indices = <0>, <1>, <2>;
> +               clock-output-names = "481c5080.adpll.dcoclkldo",
> +                                    "481c5080.adpll.clkout",
> +                                    "481c5080.adpll.clkoutldo";
> +       };
> -- 
> 2.7.0
> 
