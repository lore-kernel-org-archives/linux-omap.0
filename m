From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 00/35] arm: omap: move intc to drivers/irqchip/
Date: Mon, 8 Sep 2014 17:59:03 -0700
Message-ID: <20140909005903.GH10785@atomide.com>
References: <1406582183-696-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1406582183-696-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> [140728 14:19]:
> Hi folks,
> 
> here's another rebase of the original series moving INTC
> to drivers.
> 
> There aren't many changes, only some fixes here and there
> because of recent changes to irq_domain and irqchip.
> 
> I have also added a patch to enable INTC address space
> protection so that only privileged modes can access
> INTC's address space.
> 
> Patches tested on top of v3.17-rc7 with a beagle bone black,
> the only plataform I have which still uses INTC.
> 
> Tony, if you can run your PM test cases on your side, I'd
> be really glad.

With Nishants changes for the omap3 PRCM interrupt and the
related .dts changes the PM works for me now with this series.

So I'm applying these into omap-for-v3.18/intc on top of
Nishant's changes in omap-for-v3.18/soc thanks.

Regards,

Tony
 
> cheers
> 
> Felipe Balbi (35):
>   arm: omap: irq: make omap_irq_base global
>   arm: omap: irq: define INTC_ILR0 register
>   arm: omap: irq: start to remove irq_banks array
>   arm: omap: irq: add a global omap_nr_irqs variable
>   arm: omap: irq: remove rest of irq_banks usage
>   arm: omap: irq: remove unused macro
>   arm: omap: irq: switch over to intc_readl on omap_intc_handle_irq
>   arm: omap: irq: remove unnecessary base_addr argument
>   arm: omap: irq: rename omap3_intc_regs
>   arm: omap: irq: always define omap3 support
>   arm: omap: irq: reorganize code a little bit
>   arm: omap: irq: make intc_of_init static
>   arm: omap: irq: call set_handle_irq() from intc_of_init
>   arm: omap: irq: use IRQCHIP_DECLARE macro
>   arm: omap: irq: drop .handle_irq and .init_irq fields
>   arm: omap: irq: add specific compatibles for omap3 and am33xx devices
>   arm: omap: irq: use compatible flag to figure out number of IRQ lines
>   arm: boot: dts: am33xx/omap3: fix intc compatible flag
>   arm: omap: irq: drop ti,intc-size support
>   arm: boot: dts: omap2/3/am33xx: drop ti,intc-size
>   arm: omap: irq: move some more code around
>   arm: omap: irq: call set_handle_irq() from .init_irq
>   arm: omap: irq: drop omap3_intc_handle_irq()
>   arm: omap: irq: drop omap2_intc_handle_irq()
>   arm: omap: irq: remove unnecessary header
>   arm: omap: irq: remove nr_irqs argument
>   arm: omap: irq: introduce omap_nr_pending
>   arm: omap: irq: get rid of ifdef hack
>   arm: omap: intc: switch over to linear irq domain
>   irqchip: add irq-omap-intc.h header
>   arm: omap: irq: move irq.c to drivers/irqchip/
>   irq: intc: minor improvement to omap_irq_pending()
>   irq: intc: comment style cleanup
>   irq: intc: remove unnecesary of_address_to_resource() call
>   irq: intc: enable IP protection
> 
>  arch/arm/boot/dts/am33xx.dtsi              |   3 +-
>  arch/arm/boot/dts/omap2.dtsi               |   1 -
>  arch/arm/boot/dts/omap3.dtsi               |   3 +-
>  arch/arm/mach-omap2/Kconfig                |   1 +
>  arch/arm/mach-omap2/Makefile               |   3 +-
>  arch/arm/mach-omap2/board-3430sdp.c        |   2 +-
>  arch/arm/mach-omap2/board-am3517crane.c    |   2 +-
>  arch/arm/mach-omap2/board-am3517evm.c      |   2 +-
>  arch/arm/mach-omap2/board-cm-t35.c         |   3 +-
>  arch/arm/mach-omap2/board-cm-t3517.c       |   2 +-
>  arch/arm/mach-omap2/board-devkit8000.c     |   2 +-
>  arch/arm/mach-omap2/board-generic.c        |  14 -
>  arch/arm/mach-omap2/board-ldp.c            |   2 +-
>  arch/arm/mach-omap2/board-omap3beagle.c    |   2 +-
>  arch/arm/mach-omap2/board-omap3logic.c     |   3 +-
>  arch/arm/mach-omap2/board-omap3pandora.c   |   2 +-
>  arch/arm/mach-omap2/board-omap3stalker.c   |   2 +-
>  arch/arm/mach-omap2/board-omap3touchbook.c |   2 +-
>  arch/arm/mach-omap2/board-overo.c          |   2 +-
>  arch/arm/mach-omap2/board-rx51.c           |   2 +-
>  arch/arm/mach-omap2/board-ti8168evm.c      |   1 +
>  arch/arm/mach-omap2/common.h               |  22 --
>  arch/arm/mach-omap2/cpuidle34xx.c          |   1 +
>  arch/arm/mach-omap2/irq.c                  | 380 ---------------------------
>  arch/arm/mach-omap2/pm24xx.c               |   1 +
>  arch/arm/mach-omap2/pm34xx.c               |   1 +
>  drivers/irqchip/Kconfig                    |   5 +
>  drivers/irqchip/Makefile                   |   1 +
>  drivers/irqchip/irq-omap-intc.c            | 408 +++++++++++++++++++++++++++++
>  include/linux/irqchip/irq-omap-intc.h      |  32 +++
>  30 files changed, 468 insertions(+), 439 deletions(-)
>  delete mode 100644 arch/arm/mach-omap2/irq.c
>  create mode 100644 drivers/irqchip/irq-omap-intc.c
>  create mode 100644 include/linux/irqchip/irq-omap-intc.h
> 
> -- 
> 2.0.1.563.g66f467c
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
