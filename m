From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH] ARM: OMAP3: Fix imprecise external abort for off mode on
 36xx
Date: Thu, 7 Apr 2016 15:17:38 -0500
Message-ID: <5706C062.4040803@ti.com>
References: <1455140107-3328-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1455140107-3328-1-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Richard Woodruff <r-woodruff2@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,
On 02/10/2016 03:35 PM, Tony Lindgren wrote:
> With CONFIG_DEBUG_RODATA enabled I started noticing imprecise external
> aborts on a dm3730 when hitting off idle. These don't seem to happen
> on 34xx.
>
> Pretty much changing anything in the code made these go away, like
> changing .config options. At first I though it might be an alignment
> issue in the 36xx specific assembly code in sleep34xx.S, or something
> related to the recent rodata fixes. But that does not seem to be
> the case. It seems to be a timing issue instead.
>
> Adding few extra nop instructions after the wfi seems to fix the
> issue. When adding 5 nops, the errors showed up less often. With
> add ed 6 nops, I don't seem to get them at all any longer.
>
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Richard Woodruff <r-woodruff2@ti.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>
> Anybody else seen this issue before?

I have a series to convert omap3 PM code to using generic SRAM driver 
but when testing I see an external abort on BBXM off mode resume very 
similar to this that seems to be timing related caused by using generic 
SRAM driver to re-copy PM code rather than omap3_sram_restore_context.

By tracing the resume path I believe the abort is caused by 
omap3_intc_resume_idle in pm34xx.c, which writes to two registers in the 
INTC. Removing this call makes the abort unreproducible in my 
experiments and changing the writes to reads causes a bus lock, so I'm 
pretty confident it's coming from this call attempting to write to an 
idled INTC.

Advisory 1.106 in DM3730 Silicon Errata Document [1] describes an issue 
with "MPU Leaves MSTANDBY State Before IDLEREQ of Interrupt Controller 
is Released" which sounds like a very similar failure situation to what 
we are seeing even though the timing of INTC access is a bit further 
from WFI exit than it describes. Perhaps there are more conditions where 
it can occur. Pushed my WIP branch for SRAM series that shows the same 
failure here [2].

Regards,
Dave

[1] http://www.ti.com/lit/er/sprz319f/sprz319f.pdf
[2] https://github.com/dgerlach/linux-pm/tree/beagle-sram-wip-v4.5

>
> ---
>   arch/arm/mach-omap2/sleep34xx.S | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
> index 1b9f052..0fbaa08 100644
> --- a/arch/arm/mach-omap2/sleep34xx.S
> +++ b/arch/arm/mach-omap2/sleep34xx.S
> @@ -264,6 +264,12 @@ ENTRY(omap3_do_wfi)
>   	nop
>   	nop
>   	nop
> +	nop
> +	nop
> +	nop
> +	nop
> +	nop
> +	nop
>
>   /*
>    * This function implements the erratum ID i581 WA:
>
