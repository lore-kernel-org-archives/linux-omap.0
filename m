From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2 13/21] DT: omap4/5: add binding for the wake-up
 generator
Date: Thu, 8 Jan 2015 10:52:46 -0600
Message-ID: <20150108165246.GC25986@kahuna>
References: <1420652576-22309-1-git-send-email-marc.zyngier@arm.com>
 <1420652576-22309-14-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1420652576-22309-14-git-send-email-marc.zyngier@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Alexandre Courbot <gnurou@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, Sascha Hauer <kernel@pengutronix.de>, Simon Horman <horms@verge.net.au>, Stephen Warren <swarren@wwwdotorg.org>, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Santosh Shilimkar <ssantosh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org, Jason Cooper <jason@lakedaemon.net>
List-Id: linux-omap@vger.kernel.org

On 17:42-20150107, Marc Zyngier wrote:
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  .../interrupt-controller/ti,omap4-wugen-mpu        | 32 ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,omap4-wugen-mpu
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,omap4-wugen-mpu b/Documentation/devicetree/bindings/interrupt-controller/ti,omap4-wugen-mpu
> new file mode 100644
> index 0000000..16149d9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/ti,omap4-wugen-mpu
> @@ -0,0 +1,32 @@
> +TI OMAP4 Wake-up Generator
> +
> +All TI OMAP4/5 (and their derivatives) an interrupt controllerthat
controller that
> +routes interrupts to the GIC, and also serves as a wakeup source. It
> +is also refered to as "WUGEN-MPU", hence the name of the binding.
> +
> +Reguired properties:
> +
> +- compatible : should contain at least "ti,omap4-wugen-mpu"
Could we also document ti,omap5-wugen-mpu. In addition, if you could
make this patch prior to patch #12, it helps the checkpatch at the very
least ;)

also saw a few checkpatch warnings:
+WARNING: 'refered' may be misspelled - perhaps 'referred'?
+#22: FILE: Documentation/devicetree/bindings/interrupt-controller/ti,omap4-wugen-mpu:5:
++is also refered to as "WUGEN-MPU", hence the name of the binding.
+WARNING: 'explicitely' may be misspelled - perhaps 'explicitly'?
+#39: FILE: Documentation/devicetree/bindings/interrupt-controller/ti,omap4-wugen-mpu:22:
++  are explicitely forbiden.

> +- reg : Specifies base physical address and size of the registers.
> +- interrupt-controller : Identifies the node as an interrupt controller.
> +- #interrupt-cells : Specifies the number of cells needed to encode an
> +  interrupt source. The value must be 3.
> +- interrupt-parent : a phandle to the GIC these interrupts are routed
> +  to.
> +
> +Notes:
> +
> +- Because this HW ultimately routes interrupts to the GIC, the
> +  interrupt specifier must be that of the GIC.
> +- Only SPIs can use the ictlr as an interrupt parent. SGIs and PPIs

I think you mean interrupt controller and not nvidia ictlr here.. :)

> +  are explicitely forbiden.
> +
> +Example:
> +
> +       wakeupgen: interrupt-controller@48281000 {
> +               compatible = "ti,omap5-wugen-mpu", "ti,omap4-wugen-mpu";
> +               interrupt-controller;
> +               #interrupt-cells = <3>;
> +               reg = <0x48281000 0x1000>;
> +               interrupt-parent = <&gic>;
> +       };
> -- 
> 2.1.4
> 

-- 
Regards,
Nishanth Menon
