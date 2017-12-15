From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 3/4] dt-bindings: opp: Introduce ti-opp-supply bindings
Date: Fri, 15 Dec 2017 15:29:47 +0100
Message-ID: <CAJZ5v0iaYAodhiQm3=7OMhtqP3JXoX_RTrYMRDxVwO=3hTL7Bg@mail.gmail.com>
References: <20171215042528.28715-1-d-gerlach@ti.com> <20171215042528.28715-4-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20171215042528.28715-4-d-gerlach@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh+dt@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 15, 2017 at 5:25 AM, Dave Gerlach <d-gerlach@ti.com> wrote:
> Document the devicetree bindings that describe Texas Instruments
> opp-supply which allow a platform to describe multiple regulators and
> additional information, such as registers containing data needed to
> program aforementioned regulators.
>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>

I need an ACK from Rob on this one.

> ---
>  .../bindings/opp/ti-omap5-opp-supply.txt           | 63 ++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/opp/ti-omap5-opp-supply.txt
>
> diff --git a/Documentation/devicetree/bindings/opp/ti-omap5-opp-supply.txt b/Documentation/devicetree/bindings/opp/ti-omap5-opp-supply.txt
> new file mode 100644
> index 000000000000..832346e489a3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/opp/ti-omap5-opp-supply.txt
> @@ -0,0 +1,63 @@
> +Texas Instruments OMAP compatible OPP supply description
> +
> +OMAP5, DRA7, and AM57 family of SoCs have Class0 AVS eFuse registers which
> +contain data that can be used to adjust voltages programmed for some of their
> +supplies for more efficient operation. This binding provides the information
> +needed to read these values and use them to program the main regulator during
> +an OPP transitions.
> +
> +Also, some supplies may have an associated vbb-supply which is an Adaptive Body
> +Bias regulator which much be transitioned in a specific sequence with regards
> +to the vdd-supply and clk when making an OPP transition. By supplying two
> +regulators to the device that will undergo OPP transitions we can make use
> +of the multi regulator binding that is part of the OPP core described here [1]
> +to describe both regulators needed by the platform.
> +
> +[1] Documentation/devicetree/bindings/opp/opp.txt
> +
> +Required Properties for Device Node:
> +- vdd-supply: phandle to regulator controlling VDD supply
> +- vbb-supply: phandle to regulator controlling Body Bias supply
> +             (Usually Adaptive Body Bias regulator)
> +
> +Required Properties for opp-supply node:
> +- compatible: Should be one of:
> +       "ti,omap-opp-supply" - basic OPP supply controlling VDD and VBB
> +       "ti,omap5-opp-supply" - OMAP5+ optimized voltages in efuse(class0)VDD
> +                           along with VBB
> +       "ti,omap5-core-opp-supply" - OMAP5+ optimized voltages in efuse(class0) VDD
> +                           but no VBB.
> +- reg: Address and length of the efuse register set for the device (mandatory
> +       only for "ti,omap5-opp-supply")
> +- ti,efuse-settings: An array of u32 tuple items providing information about
> +       optimized efuse configuration. Each item consists of the following:
> +       volt: voltage in uV - reference voltage (OPP voltage)
> +       efuse_offseet: efuse offset from reg where the optimized voltage is stored.
> +- ti,absolute-max-voltage-uv: absolute maximum voltage for the OPP supply.
> +
> +Example:
> +
> +/* Device Node (CPU)  */
> +cpus {
> +       cpu0: cpu@0 {
> +               device_type = "cpu";
> +
> +               ...
> +
> +               vdd-supply = <&vcc>;
> +               vbb-supply = <&abb_mpu>;
> +       };
> +};
> +
> +/* OMAP OPP Supply with Class0 registers */
> +opp_supply_mpu: opp_supply@4a003b20 {
> +       compatible = "ti,omap5-opp-supply";
> +       reg = <0x4a003b20 0x8>;
> +       ti,efuse-settings = <
> +       /* uV   offset */
> +       1060000 0x0
> +       1160000 0x4
> +       1210000 0x8
> +       >;
> +       ti,absolute-max-voltage-uv = <1500000>;
> +};
> --
> 2.15.1
>
