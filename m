From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH V2 00/15] cleanup cppcheck signed shifting errors
Date: Mon, 24 Jun 2019 15:02:12 +0100
Message-ID: <20190624140212.p6xvcg5lhtgeeogc@shell.armlinux.org.uk>
References: <20190623151313.970-1-tranmanphong@gmail.com>
 <20190624135105.15579-1-tranmanphong@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190624135105.15579-1-tranmanphong@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Phong Tran <tranmanphong@gmail.com>
Cc: acme@kernel.org, alexander.shishkin@linux.intel.com, alexander.sverdlin@gmail.com, allison@lohutok.net, andrew@lunn.ch, ast@kernel.org, bgolaszewski@baylibre.com, bpf@vger.kernel.org, daniel@iogearbox.net, daniel@zonque.org, dmg@turingmachine.org, festevam@gmail.com, gerg@uclinux.org, gregkh@linuxfoundation.org, gregory.clement@bootlin.com, haojian.zhuang@gmail.com, hsweeten@visionengravers.com, illusionist.neo@gmail.com, info@metux.net, jason@lakedaemon.net, jolsa@redhat.com, kafai@fb.com, kernel@pengutronix.de, kgene@kernel.org, krzk@kernel.org, kstewart@linuxfoundation.org, linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, liviu.dudau@arm.com, lkundrak@v3.sk, lorenzo.pieralisi@arm
List-Id: linux-omap@vger.kernel.org

On Mon, Jun 24, 2019 at 08:50:50PM +0700, Phong Tran wrote:
> There are errors with cppcheck 
> 
> "Shifting signed 32-bit value by 31 bits is undefined behaviour errors"
> 
> This is just a mirror changing. 

"mirror" ?

Apart from that and the extra unnecessary parens (which ought to be
cleaned up) this looks fine to me.

When there's too many parens next to each other, it makes reading
the expression more difficult - and that is definitely bad, so please
avoid unecessary parens where possible.

Thanks.

> 
> V2: Using BIT() macro instead of (1UL << nr) 
> 
> Phong Tran (15):
>   arm: perf: cleanup cppcheck shifting error
>   ARM: davinci: cleanup cppcheck shifting errors
>   ARM: ep93xx: cleanup cppcheck shifting errors
>   ARM: exynos: cleanup cppcheck shifting error
>   ARM: footbridge: cleanup cppcheck shifting error
>   ARM: imx: cleanup cppcheck shifting errors
>   ARM: ks8695: cleanup cppcheck shifting error
>   ARM: mmp: cleanup cppcheck shifting errors
>   ARM: omap2: cleanup cppcheck shifting error
>   ARM: orion5x: cleanup cppcheck shifting errors
>   ARM: pxa: cleanup cppcheck shifting errors
>   ARM: vexpress: cleanup cppcheck shifting error
>   ARM: mm: cleanup cppcheck shifting errors
>   ARM: bpf: cleanup cppcheck shifting error
>   ARM: vfp: cleanup cppcheck shifting errors
> 
>  arch/arm/kernel/perf_event_v7.c    |   6 +-
>  arch/arm/mach-davinci/ddr2.h       |   6 +-
>  arch/arm/mach-ep93xx/soc.h         | 132 ++++++++++++++++++-------------------
>  arch/arm/mach-exynos/suspend.c     |   2 +-
>  arch/arm/mach-footbridge/dc21285.c |   2 +-
>  arch/arm/mach-imx/iomux-mx3.h      |  64 +++++++++---------
>  arch/arm/mach-ks8695/regs-pci.h    |   4 +-
>  arch/arm/mach-mmp/pm-mmp2.h        |  40 +++++------
>  arch/arm/mach-mmp/pm-pxa910.h      |  76 ++++++++++-----------
>  arch/arm/mach-omap2/powerdomain.c  |   2 +-
>  arch/arm/mach-orion5x/pci.c        |   8 +--
>  arch/arm/mach-pxa/irq.c            |   4 +-
>  arch/arm/mach-vexpress/spc.c       |  12 ++--
>  arch/arm/mm/fault.h                |   6 +-
>  arch/arm/net/bpf_jit_32.c          |   2 +-
>  arch/arm/vfp/vfpinstr.h            |   8 +--
>  16 files changed, 187 insertions(+), 187 deletions(-)
> 
> -- 
> 2.11.0
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
