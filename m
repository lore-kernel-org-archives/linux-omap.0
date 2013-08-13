From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCHv5 16/31] CLK: TI: DRA7: Add APLL support
Date: Tue, 13 Aug 2013 12:14:49 +0100
Message-ID: <20130813111449.GL27165@e106331-lin.cambridge.arm.com>
References: <1375460751-23676-1-git-send-email-t-kristo@ti.com>
 <1375460751-23676-17-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1375460751-23676-17-git-send-email-t-kristo@ti.com>
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
Cc: "nm@ti.com" <nm@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "mturquette@linaro.org" <mturquette@linaro.org>, "tony@atomide.com" <tony@atomide.com>, Keerthy <j-keerthy@ti.com>, "rnayak@ti.com" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 02, 2013 at 05:25:35PM +0100, Tero Kristo wrote:
> From: Keerthy <j-keerthy@ti.com>
> 
> The patch adds support for DRA7 PCIe APLL. The APLL
> sources the optional functional clocks for PCIe module.
> 
> APLL stands for Analog PLL. This is different when comapred
> with DPLL meaning Digital PLL, the phase detection is done
> using an analog circuit.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  .../devicetree/bindings/clock/ti/apll.txt          |   32 +++
>  arch/arm/mach-omap2/clock.h                        |    1 -
>  drivers/clk/ti/Makefile                            |    2 +-
>  drivers/clk/ti/apll.c                              |  209 ++++++++++++++++++++
>  include/linux/clk/ti.h                             |    2 +
>  5 files changed, 244 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/ti/apll.txt
>  create mode 100644 drivers/clk/ti/apll.c
> 
> diff --git a/Documentation/devicetree/bindings/clock/ti/apll.txt b/Documentation/devicetree/bindings/clock/ti/apll.txt
> new file mode 100644
> index 0000000..f7a82e9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/ti/apll.txt
> @@ -0,0 +1,32 @@
> +Binding for Texas Instruments APLL clock.
> +
> +This binding uses the common clock binding[1].  It assumes a
> +register-mapped APLL with usually two selectable input clocks
> +(reference clock and bypass clock), with analog phase locked
> +loop logic for multiplying the input clock to a desired output
> +clock. This clock also typically supports different operation
> +modes (locked, low power stop etc.) APLL mostly behaves like
> +a subtype of a DPLL [2], although a simplified one at that.
> +
> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +[2] Documentation/devicetree/bindings/clock/ti/dpll.txt
> +
> +Required properties:
> +- compatible : shall be "ti,dra7-apll-clock"
> +- #clock-cells : from common clock binding; shall be set to 0.
> +- clocks : link phandles of parent clocks (clk-ref and clk-bypass)
> +- reg : array of register base addresses for controlling the APLL:
> +       reg[0] = control register
> +       reg[1] = idle status register

Using reg-names is likely a good idea here.

> +- ti,clk-ref : link phandle for the reference clock
> +- ti,clk-bypass : link phandle for the bypass clock

You don't need this. Use the clocks and clock-names properties.

[...]

> +static int dra7_apll_enable(struct clk_hw *hw)
> +{
> +       struct clk_hw_omap *clk = to_clk_hw_omap(hw);
> +       int r = 0, i = 0;
> +       struct dpll_data *ad;
> +       const char *clk_name;
> +       u8 state = 1;
> +       u32 v;
> +
> +       ad = clk->dpll_data;
> +       if (!ad)
> +               return -EINVAL;
> +
> +       clk_name = __clk_get_name(clk->hw.clk);
> +
> +       state <<= __ffs(ad->idlest_mask);
> +
> +       /* Check is already locked */
> +       if ((__raw_readl(ad->idlest_reg) & ad->idlest_mask) == state)
> +               return r;

Why __raw_readl rather than raw_readl?

> +
> +       v = __raw_readl(ad->control_reg);
> +       v &= ~ad->enable_mask;
> +       v |= APLL_FORCE_LOCK << __ffs(ad->enable_mask);
> +       __raw_writel(v, ad->control_reg);

Why not raw_writel? Do you not need the rmb() provided by writel, here
or anywhere else?

[...]

> +void __init of_dra7_apll_setup(struct device_node *node)
> +{
> +       const struct clk_ops *ops;
> +       struct clk *clk;
> +       const char *clk_name = node->name;
> +       int num_parents;
> +       const char **parent_names = NULL;
> +       struct of_phandle_args clkspec;
> +       u8 apll_flags = 0;
> +       struct dpll_data *ad;
> +       u32 idlest_mask = 0x1;
> +       u32 autoidle_mask = 0x3;
> +       int i;
> +
> +       ops = &apll_ck_ops;
> +       ad = kzalloc(sizeof(*ad), GFP_KERNEL);
> +       if (!ad) {
> +               pr_err("%s: could not allocate dpll_data\n", __func__);
> +               return;
> +       }
> +
> +       of_property_read_string(node, "clock-output-names", &clk_name);
> +
> +       num_parents = of_clk_get_parent_count(node);
> +       if (num_parents < 1) {
> +               pr_err("%s: omap dpll %s must have parent(s)\n",
> +                      __func__, node->name);
> +               goto cleanup;
> +       }
> +
> +       parent_names = kzalloc(sizeof(char *) * num_parents, GFP_KERNEL);
> +
> +       for (i = 0; i < num_parents; i++)
> +               parent_names[i] = of_clk_get_parent_name(node, i);
> +
> +       clkspec.np = of_parse_phandle(node, "ti,clk-ref", 0);
> +       ad->clk_ref = of_clk_get_from_provider(&clkspec);

Use clocks, clock-names, and of_clk_get_by_name().

Thanks,
Mark.
