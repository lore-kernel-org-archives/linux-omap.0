From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCHv3 01/10] dt-bindings: omap: add new binding for PRM
 instances
Date: Mon, 02 Sep 2019 14:39:16 +0100
Message-ID: <20190902042631.GA22055@bogus>
References: <20190830121816.30034-1-t-kristo@ti.com>
 <20190830121816.30034-2-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190830121816.30034-2-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>
Cc: devicetree@vger.kernel.org, tony@atomide.com, p.zabel@pengutronix.de, ssantosh@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 30, 2019 at 03:18:07PM +0300, Tero Kristo wrote:
> Add new binding for OMAP PRM (Power and Reset Manager) instances. Each
> of these will act as a power domain controller and potentially as a reset
> provider.
> 

Converting this to schema would be nice.

> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  .../devicetree/bindings/arm/omap/prm-inst.txt | 31 +++++++++++++++++++

bindings/reset/

>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/omap/prm-inst.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/omap/prm-inst.txt b/Documentation/devicetree/bindings/arm/omap/prm-inst.txt
> new file mode 100644
> index 000000000000..7c7527c37734
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/omap/prm-inst.txt
> @@ -0,0 +1,31 @@
> +OMAP PRM instance bindings
> +
> +Power and Reset Manager is an IP block on OMAP family of devices which
> +handle the power domains and their current state, and provide reset
> +handling for the domains and/or separate IP blocks under the power domain
> +hierarchy.
> +
> +Required properties:
> +- compatible:	Must be one of:
> +		"ti,am3-prm-inst"
> +		"ti,am4-prm-inst"
> +		"ti,omap4-prm-inst"
> +		"ti,omap5-prm-inst"
> +		"ti,dra7-prm-inst"

'-inst' seems a bit redundant.

> +- reg:		Contains PRM instance register address range
> +		(base address and length)
> +
> +Optional properties:
> +- #reset-cells:	Should be 1 if the PRM instance in question supports resets.
> +- clocks:	Associated clocks for the reset signals if any. Certain reset
> +		signals can't be toggled properly without functional clock
> +		being active for them.
> +
> +Example:
> +
> +prm_dsp2: prm@1b00 {

reset-controller@...

> +	compatible = "ti,dra7-prm-inst";
> +	reg = <0x1b00 0x40>;
> +	#reset-cells = <1>;
> +	clocks = <&dsp2_clkctrl DRA7_DSP2_MMU0_DSP2_CLKCTRL 0>;
> +};
> -- 
> 2.17.1
> 
> --
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
