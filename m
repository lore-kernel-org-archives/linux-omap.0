From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/17] Massive OMAP730/OMAP850 cleanup
Date: Wed, 14 Oct 2009 14:12:07 -0700
Message-ID: <20091014211206.GL12700@atomide.com>
References: <3d374d00910141250h22e18bccpa6792d2a323b61f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <3d374d00910141250h22e18bccpa6792d2a323b61f8@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alistair Buxton <a.j.buxton@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Alistair Buxton <a.j.buxton@gmail.com> [091014 13:03]:
> Reposting the full series for review. Assuming this is all OK would it
> be a good idea to merge the config variables into a single
> CONFIG_ARCH_OMAP7XX? There doesn't seem to be any reason to have both.
> Original description follows.

Yeah, those should be merged too. Let's do that as a separate patch.

Regards,

Tony

> 
> 
> Hello from the Linwizard project,
> 
> We have been working on supporting omap850 smartphones from HTC such
> as Wizard, Herald etc. We have found that omap730 and omap850 are
> almost exactly the same. As far as what is supported in linux-omap so
> far, they are identical. Currently there are seperate code paths for
> 730 and 850, and this is causing us a lot of problems when one is
> changed and the other isn't. I also noticed that OMAP F-Sample board
> uses ARCH_OMAP730 even though it has a OMAP850 SoC.
> 
> In order to try to clean this up I have produced a patch series which
> removes all cpu_is_omap730/850 and replaces them with unified
> cpu_is_omap7xx() blocks, and similarly merges CONFIG checks. Here is a
> random example:
> 
> -#ifdef CONFIG_ARCH_OMAP730
> - if (cpu_is_omap730()) {
> +#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
> + if (cpu_is_omap7xx()) {
> irq_banks = omap730_irq_banks;
> irq_bank_count = ARRAY_SIZE(omap730_irq_banks);
> }
> #endif
> -#ifdef CONFIG_ARCH_OMAP850
> - if (cpu_is_omap850()) {
> - irq_banks = omap850_irq_banks;
> - irq_bank_count = ARRAY_SIZE(omap850_irq_banks);
> - }
> -#endif
> 
> Drilling down through the variables shows they are always equivalent
> for 730 and 850, except where there is a bug.
> 
> This makes several bugs go away for us on omap850, including the
> MPUIO_VBASE bug, and the lack of working IRQs - since these bugs arn't
> in the 730 paths. It would hopefully prevent similar bugs from showing
> up in the future too.
> 
> Alistair Buxton (16):
>   OMAP7XX: Serial: Remove duplicate omap850 code
>   OMAP7XX: GPIO: Remove duplicate omap850 code
>   OMAP7XX: IO: Remove duplicate omap850 code
>   OMAP7XX: Mux: Remove duplicate omap850 code
>   OMAP7XX: USB: Remove duplicate omap850 code
>   OMAP7XX: IRQ: Remove duplicate omap850 code
>   OMAP7XX: PM: Add omap850 support
>   OMAP7XX: Clocks: Add omap850 support
>   OMAP7XX: McBSP: Add omap850 support
>   OMAP7XX: Create omap7xx.h
>   OMAP7XX: Update core omap1 files to use omap7xx.h
>   OMAP7XX: Replace omap730 references in irqs.h and all users
>   OMAP7XX: Rename all the rest of the omap730 references in omap1 core
>   OMAP7XX: omap_uwire.c: Convert to omap7xx.h
>   OMAP850: PM: Add an ARCH_OMAP850 check
>   OMAP850: Fix zImage booting
> 
> Angelo Arrifano (1):
>   OMAP7XX: Clocks: Add ck_ref and armxor
> 
>  arch/arm/mach-omap1/board-fsample.c           |   18 +-
>  arch/arm/mach-omap1/board-perseus2.c          |   18 +-
>  arch/arm/mach-omap1/clock.c                   |   24 ++--
>  arch/arm/mach-omap1/io.c                      |   45 ++----
>  arch/arm/mach-omap1/irq.c                     |   32 +---
>  arch/arm/mach-omap1/mcbsp.c                   |   32 ++--
>  arch/arm/mach-omap1/mux.c                     |   70 +++-----
>  arch/arm/mach-omap1/pm.c                      |  100 ++++++------
>  arch/arm/mach-omap1/pm.h                      |   53 +++---
>  arch/arm/mach-omap1/serial.c                  |   13 +-
>  arch/arm/mach-omap1/sleep.S                   |   22 ++--
>  arch/arm/plat-omap/devices.c                  |   22 ++--
>  arch/arm/plat-omap/gpio.c                     |  227 +++++++------------------
>  arch/arm/plat-omap/include/mach/entry-macro.S |    8 +-
>  arch/arm/plat-omap/include/mach/hardware.h    |    2 +-
>  arch/arm/plat-omap/include/mach/irqs.h        |  229 ++++++++-----------------
>  arch/arm/plat-omap/include/mach/mcbsp.h       |    6 +-
>  arch/arm/plat-omap/include/mach/mux.h         |  100 +++--------
>  arch/arm/plat-omap/include/mach/omap7xx.h     |  104 +++++++++++
>  arch/arm/plat-omap/include/mach/uncompress.h  |    3 +-
>  arch/arm/plat-omap/io.c                       |   14 +-
>  arch/arm/plat-omap/usb.c                      |   10 +-
>  drivers/spi/omap_uwire.c                      |    8 +-
>  23 files changed, 480 insertions(+), 680 deletions(-)
>  create mode 100644 arch/arm/plat-omap/include/mach/omap7xx.h
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
