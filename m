From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [RESEND PATCH V2 1/2] ARM: dts: AM33xx: Add RNG node
Date: Sat, 12 Oct 2013 18:56:08 +0530
Message-ID: <52594DF0.1050002@ti.com>
References: <1377780731-3648-1-git-send-email-lokeshvutla@ti.com>
 <1377780731-3648-2-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1377780731-3648-2-git-send-email-lokeshvutla@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: devicetree@vger.kernel.org, paul@pwsan.com, tony@atomide.com, rnayak@ti.com, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Benoit,
On Thursday 29 August 2013 06:22 PM, Lokesh Vutla wrote:
> Add the AM33xx RNG module's device tree data.
> Also add Documentation file describing the data
> for the RNG module.
Seems you missed this patch. Please consider this for this merge window.
Patch 2/2 is already taken by Paul.
Without this patch AM335x boot will crash as I mentioned in my cover letter.

Thanks and regards,
Lokesh
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
> Changes since V1:
> - Drop "status=disabled" entry in dt node, Since
>   RNG is present on all AM33xx platforms.
> 
>  .../devicetree/bindings/hwrng/omap_rng.txt         |   22 ++++++++++++++++++++
>  arch/arm/boot/dts/am33xx.dtsi                      |    7 +++++++
>  2 files changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwrng/omap_rng.txt
> 
> diff --git a/Documentation/devicetree/bindings/hwrng/omap_rng.txt b/Documentation/devicetree/bindings/hwrng/omap_rng.txt
> new file mode 100644
> index 0000000..6a62acd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwrng/omap_rng.txt
> @@ -0,0 +1,22 @@
> +OMAP SoC HWRNG Module
> +
> +Required properties:
> +
> +- compatible : Should contain entries for this and backward compatible
> +  RNG versions:
> +  - "ti,omap2-rng" for OMAP2.
> +  - "ti,omap4-rng" for OMAP4, OMAP5 and AM33XX.
> +  Note that these two versions are incompatible.
> +- ti,hwmods: Name of the hwmod associated with the RNG module
> +- reg : Offset and length of the register set for the module
> +- interrupts : the interrupt number for the RNG module.
> +		Only used for "ti,omap4-rng".
> +
> +Example:
> +/* AM335x */
> +rng: rng@48310000 {
> +	compatible = "ti,omap4-rng";
> +	ti,hwmods = "rng";
> +	reg = <0x48310000 0x2000>;
> +	interrupts = <111>;
> +};
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 38b446b..26ebe30 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -530,5 +530,12 @@
>  			#size-cells = <1>;
>  			status = "disabled";
>  		};
> +
> +		rng: rng@48310000 {
> +			compatible = "ti,omap4-rng";
> +			ti,hwmods = "rng";
> +			reg = <0x48310000 0x2000>;
> +			interrupts = <111>;
> +		};
>  	};
>  };
> 
