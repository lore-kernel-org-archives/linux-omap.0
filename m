From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] arm: dts: dra7: arch timer sits in always-on power domain
Date: Wed, 15 Jul 2015 10:24:37 +0100
Message-ID: <20150715092437.GC9627@leverpostej>
References: <1436820101-2172-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1436820101-2172-1-git-send-email-balbi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, marc.zyngier@arm.com
List-Id: linux-omap@vger.kernel.org

On Mon, Jul 13, 2015 at 09:41:41PM +0100, Felipe Balbi wrote:
> According to DRA7x TRM section 4.3.5 Realtime Counter (Master Counter),
> the realtime counter sits in the Wakeup Always-On Power domain.
> Furthermore, the counter will automatically switch the 32K clock source
> when MPU goes into standby and automatically switch back to SYS_CLK or
> ABE_LP when MPU goes out of standby.

While the counter is in an always-on domain (the architecture mandates
this) I don't think that applies to the timers (i.e. the comparators
within a CPU), which are almost certainly not in an always-on domain.

I suspect that this is incorrect, and it will be very painful to debug
if it is...

Thanks,
Mark.

> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  arch/arm/boot/dts/dra7.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index 8f1e25bcecbd..c1e6fd82485f 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -50,6 +50,7 @@
>  			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
>  			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
>  		interrupt-parent = <&gic>;
> +		always-on;
>  	};
>  
>  	gic: interrupt-controller@48211000 {
> -- 
> 2.4.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
