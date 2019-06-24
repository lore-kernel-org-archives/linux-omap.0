From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH V2 12/15] ARM: vexpress: cleanup cppcheck shifting error
Date: Mon, 24 Jun 2019 14:57:29 +0100
Message-ID: <20190624135729.q6k5hjq3ajwhi4gb@shell.armlinux.org.uk>
References: <20190623151313.970-1-tranmanphong@gmail.com>
 <20190624135105.15579-1-tranmanphong@gmail.com>
 <20190624135105.15579-13-tranmanphong@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190624135105.15579-13-tranmanphong@gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Phong Tran <tranmanphong@gmail.com>
Cc: acme@kernel.org, alexander.shishkin@linux.intel.com, alexander.sverdlin@gmail.com, allison@lohutok.net, andrew@lunn.ch, ast@kernel.org, bgolaszewski@baylibre.com, bpf@vger.kernel.org, daniel@iogearbox.net, daniel@zonque.org, dmg@turingmachine.org, festevam@gmail.com, gerg@uclinux.org, gregkh@linuxfoundation.org, gregory.clement@bootlin.com, haojian.zhuang@gmail.com, hsweeten@visionengravers.com, illusionist.neo@gmail.com, info@metux.net, jason@lakedaemon.net, jolsa@redhat.com, kafai@fb.com, kernel@pengutronix.de, kgene@kernel.org, krzk@kernel.org, kstewart@linuxfoundation.org, linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, liviu.dudau@arm.com, lkundrak@v3.sk, lorenzo.pieralisi@arm
List-Id: linux-omap@vger.kernel.org

On Mon, Jun 24, 2019 at 08:51:02PM +0700, Phong Tran wrote:
> [arch/arm/mach-vexpress/spc.c:366]: (error) Shifting signed 32-bit value
> by 31 bits is undefined behaviour
> 
> Signed-off-by: Phong Tran <tranmanphong@gmail.com>
> ---
>  arch/arm/mach-vexpress/spc.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-vexpress/spc.c b/arch/arm/mach-vexpress/spc.c
> index 0f5381d13494..425ce633667a 100644
> --- a/arch/arm/mach-vexpress/spc.c
> +++ b/arch/arm/mach-vexpress/spc.c
> @@ -57,8 +57,8 @@
>  
>  /* SPC CPU/cluster reset statue */
>  #define STANDBYWFI_STAT		0x3c
> -#define STANDBYWFI_STAT_A15_CPU_MASK(cpu)	(1 << (cpu))
> -#define STANDBYWFI_STAT_A7_CPU_MASK(cpu)	(1 << (3 + (cpu)))
> +#define STANDBYWFI_STAT_A15_CPU_MASK(cpu)	BIT((cpu))
> +#define STANDBYWFI_STAT_A7_CPU_MASK(cpu)	BIT((3 + (cpu)))

I guess you did this using a script, however, in the above two cases,
you don't need the extra parens - it was necessary in the original
though.

>  
>  /* SPC system config interface registers */
>  #define SYSCFG_WDATA		0x70
> @@ -69,7 +69,7 @@
>  #define A7_PERFVAL_BASE		0xC30
>  
>  /* Config interface control bits */
> -#define SYSCFG_START		(1 << 31)
> +#define SYSCFG_START		BIT(31)
>  #define SYSCFG_SCC		(6 << 20)
>  #define SYSCFG_STAT		(14 << 20)
>  
> @@ -90,8 +90,8 @@
>  #define CA15_DVFS	0
>  #define CA7_DVFS	1
>  #define SPC_SYS_CFG	2
> -#define STAT_COMPLETE(type)	((1 << 0) << (type << 2))
> -#define STAT_ERR(type)		((1 << 1) << (type << 2))
> +#define STAT_COMPLETE(type)	(BIT(0) << (type << 2))
> +#define STAT_ERR(type)		(BIT(1) << (type << 2))
>  #define RESPONSE_MASK(type)	(STAT_COMPLETE(type) | STAT_ERR(type))
>  
>  struct ve_spc_opp {
> @@ -162,7 +162,7 @@ void ve_spc_cpu_wakeup_irq(u32 cluster, u32 cpu, bool set)
>  	if (cluster >= MAX_CLUSTERS)
>  		return;
>  
> -	mask = 1 << cpu;
> +	mask = BIT(cpu);
>  
>  	if (!cluster_is_a15(cluster))
>  		mask <<= 4;
> -- 
> 2.11.0
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
