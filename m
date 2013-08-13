From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCHv5 22/31] CLK: TI: add interface clock support for OMAP3
Date: Tue, 13 Aug 2013 12:30:11 +0100
Message-ID: <20130813113010.GN27165@e106331-lin.cambridge.arm.com>
References: <1375460751-23676-1-git-send-email-t-kristo@ti.com>
 <1375460751-23676-23-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1375460751-23676-23-git-send-email-t-kristo@ti.com>
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
Cc: "nm@ti.com" <nm@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "mturquette@linaro.org" <mturquette@linaro.org>, "tony@atomide.com" <tony@atomide.com>, "rnayak@ti.com" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 02, 2013 at 05:25:41PM +0100, Tero Kristo wrote:
> OMAP3 has interface clocks in addition to functional clocks, which
> require special handling for the autoidle and idle status register
> offsets mainly.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  .../devicetree/bindings/clock/ti/interface.txt     |   45 +++++++++
>  arch/arm/mach-omap2/clock.h                        |    6 --
>  drivers/clk/ti/Makefile                            |    2 +-
>  drivers/clk/ti/interface.c                         |  105 ++++++++++++++++++++
>  include/linux/clk/ti.h                             |    7 ++
>  5 files changed, 158 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/ti/interface.txt
>  create mode 100644 drivers/clk/ti/interface.c
> 
> diff --git a/Documentation/devicetree/bindings/clock/ti/interface.txt b/Documentation/devicetree/bindings/clock/ti/interface.txt
> new file mode 100644
> index 0000000..8b09ae7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/ti/interface.txt
> @@ -0,0 +1,45 @@
> +Binding for Texas Instruments interface clock.
> +
> +This binding uses the common clock binding[1]. This clock is
> +quite much similar to the basic gate-clock [2], however,
> +it supports a number of additional features, including
> +companion clock finding (match corresponding functional gate
> +clock) and hardware autoidle enable / disable.
> +
> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +[2] Documentation/devicetree/bindings/clock/gate-clock.txt
> +
> +Required properties:
> +- compatible : shall be "ti,interface-clock"

It might make sense to be more specific: "ti,omap3-interface-clock".

> +- #clock-cells : from common clock binding; shall be set to 0
> +- clocks : link to phandle of parent clock
> +- reg : base address for the control register
> +
> +Optional properties:
> +- ti,enable-bit : bit shift for the bit enabling/disabling the clock
> +		  (default 0)
> +- ti,iclk-no-wait : flag for selecting non-waiting hw-ops
> +- ti,iclk-hsotgusb : flag for selecting hsotgusb hw-ops
> +- ti,iclk-dss : flag for selecting DSS interface clock hw-ops
> +- ti,iclk-ssi : flag for selecting SSI interface clock hw-ops
> +- ti,am35xx-clk : flag for selecting AM35xx interface clock hw-ops

I think these should be selected based on the compatible string. They're
mutually exclusive, and incompatible.

Thanks,
Mark.
