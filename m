From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCHv2] power: supply: cpcap-battery: Add a battery driver
Date: Wed, 31 May 2017 11:30:02 -0500
Message-ID: <20170531163002.j4xb6fo3ipq6ly2d@rob-hp-laptop>
References: <20170523005637.945-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170523005637.945-1-tony@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>
List-Id: linux-omap@vger.kernel.org

On Mon, May 22, 2017 at 05:56:37PM -0700, Tony Lindgren wrote:
> On the CPCAP PMIC we can use the ADCs for monitoring the battery,
> and there is also a coulomb counter. So let's add basic support for
> the battery driver.
> 
> I did not add any capacity prediction as that should probably be
> done in the user space. Or at least user space should tell the kernel
> some battery statistics and then the kernel driver could display the
> capacity based on that.
> 
> Note that I left out the battery interrupt handling for now as I need
> to spend more time on it for the battery empty interrupts. The driver
> works just fine without the interrupts too.
> 
> Cc: devicetree@vger.kernel.org
> Cc: Marcel Partap <mpartap@gmx.net>
> Cc: Michael Scott <michael.scott@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> 
> Changes since v1:
> 
> - Add support for battery low interrupts
> 
> - Fix POWER_SUPPLY_STATUS during charging to not flip constantly
>   by using average current
> 
> ---
>  .../bindings/power/supply/cpcap-battery.txt        |  27 +
>  drivers/power/supply/Kconfig                       |   8 +
>  drivers/power/supply/Makefile                      |   1 +
>  drivers/power/supply/cpcap-battery.c               | 808 +++++++++++++++++++++
>  4 files changed, 844 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/cpcap-battery.txt
>  create mode 100644 drivers/power/supply/cpcap-battery.c
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/cpcap-battery.txt b/Documentation/devicetree/bindings/power/supply/cpcap-battery.txt
> new file mode 100644
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/cpcap-battery.txt
> @@ -0,0 +1,27 @@
> +Motorola CPCAP PMIC battery driver binding
> +
> +Required properties:
> +- compatible: Shall be "motorola,cpcap-battery"
> +- interrupts: Interrupt specifier for each name in interrupt-names
> +- interrupt-names: Should contain the following entries:
> +		   "lowbph", "lowbpl", "chrgcurr1", "battdetb"
> +- io-channels: IIO ADC channel specifier for each name in io-channel-names
> +- io-channel-names: Should contain the following entries:
> +		    "battdetb", "battp"

Doesn't match the example.

> +
> +Example:
> +
> +cpcap_battery: battery {
> +	compatible = "motorola,cpcap-battery";
> +	interrupts-extended = <
> +		&cpcap 5 0 &cpcap 3 0
> +		&cpcap 20 0 &cpcap 54 0
> +	>;
> +	interrupt-names =
> +		"lowbph", "lowbpl",
> +		"chrgcurr1", "battdetb";
> +	io-channels = <&cpcap_adc 0 &cpcap_adc 1
> +		       &cpcap_adc 5 &cpcap_adc 6>;
> +	io-channel-names = "battdetb", "battp",
> +			   "chg_isense", "batti";
> +};
