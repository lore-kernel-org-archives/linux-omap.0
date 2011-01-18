From: "Will Deacon" <will.deacon@arm.com>
Subject: RE: [PATCH 04/14] ARM: v6k: introduce CPU_V6K option
Date: Tue, 18 Jan 2011 10:36:08 -0000
Message-ID: <39147.6343539127$1295347145@news.gmane.org>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
	<E1Peuej-0003SV-Dn@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <E1Peuej-0003SV-Dn@rmk-PC.arm.linux.org.uk>
Content-Language: en-gb
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Russell,

> Introduce a CPU_V6K configuration option for platforms to select if they
> have a V6K CPU core.  This allows us to identify whether we need to
> support ARMv6 CPUs without the V6K SMP extensions at build time.
> 
> Currently CPU_V6K is just an alias for CPU_V6, and all places which
> reference CPU_V6 are replaced by (CPU_V6 || CPU_V6K).
> 
> Select CPU_V6K from platforms which are known to be V6K-only.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

[...]

> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index c22c1ad..9c43052 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -89,6 +89,7 @@ tune-$(CONFIG_CPU_XSCALE)	:=$(call cc-option,-mtune=xscale,-mtune=strongarm110)
>  tune-$(CONFIG_CPU_XSC3)		:=$(call cc-option,-mtune=xscale,-mtune=strongarm110) -Wa,-
> mcpu=xscale
>  tune-$(CONFIG_CPU_FEROCEON)	:=$(call cc-option,-mtune=marvell-f,-mtune=xscale)
>  tune-$(CONFIG_CPU_V6)		:=$(call cc-option,-mtune=arm1136j-s,-mtune=strongarm)
> +tune-$(CONFIG_CPU_V6K)		:=$(call cc-option,-mtune=arm1136j-s,-mtune=strongarm)

Can we change the tune target to 1176 for v6k?
 
>  config DMA_CACHE_RWFO
>  	bool "Enable read/write for ownership DMA cache maintenance"
> -	depends on CPU_V6 && SMP
> +	depends on (CPU_V6 || CPU_V6K) && SMP
>  	default y
>  	help
>  	  The Snoop Control Unit on ARM11MPCore does not detect the

Can we lose the CPU_V6 check here? RWFO is only required for 11MPCore
so I think we just need to check CPU_V6K && SMP.

Will
