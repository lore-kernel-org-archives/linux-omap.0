From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCH 3/5] ARM: l2x0: Errata fix for flush by Way operation can
	cause data corruption
Date: Sat, 12 Feb 2011 11:50:25 -0600
Message-ID: <AANLkTimkqZ5datA+7shggbWz3+j=TDg5beUkQK=b1AmK@mail.gmail.com>
References: <1297510187-31547-1-git-send-email-santosh.shilimkar@ti.com>
	<1297510187-31547-4-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1297510187-31547-4-git-send-email-santosh.shilimkar@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: khilman@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>
List-Id: linux-omap@vger.kernel.org

On Sat, Feb 12, 2011 at 5:29 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> PL310 implements the Clean & Invalidate by Way L2 cache maintenance
> operation (offset 0x7FC). This operation runs in background so that
> PL310 can handle normal accesses while it is in progress. Under very
> rare circumstances, due to this erratum, write data can be lost when
> PL310 treats a cacheable write transaction during a Clean & Invalidate
> by Way operation.
>
> Workaround:
> Disable Write-Back and Cache Linefill (Debug Control Register)
> Clean & Invalidate by Way (0x7FC)
> Re-enable Write-Back and Cache Linefill (Debug Control Register)
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> ---
> =A0arch/arm/Kconfig =A0 =A0 =A0 =A0 =A0 =A0| =A0 11 +++++++++++
> =A0arch/arm/mach-omap2/Kconfig | =A0 =A01 +
> =A0arch/arm/mm/cache-l2x0.c =A0 =A0| =A0 16 ++++++++++------
> =A03 files changed, 22 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 5cff165..2e6b879 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1177,6 +1177,17 @@ config ARM_ERRATA_743622
> =A0 =A0 =A0 =A0 =A0visible impact on the overall performance or power con=
sumption of the
> =A0 =A0 =A0 =A0 =A0processor.
>
> +config PL310_ERRATA_727915
> + =A0 =A0 =A0 bool "Background Clean & Invalidate by Way operation can ca=
use data corruption"
> + =A0 =A0 =A0 depends on CACHE_L2X0 && ARCH_OMAP4
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 PL310 implements the Clean & Invalidate by Way L2 cache=
 maintenance
> + =A0 =A0 =A0 =A0 operation (offset 0x7FC). This operation runs in backgr=
ound so that
> + =A0 =A0 =A0 =A0 PL310 can handle normal accesses while it is in progres=
s. Under very
> + =A0 =A0 =A0 =A0 rare circumstances, due to this erratum, write data can=
 be lost when
> + =A0 =A0 =A0 =A0 PL310 treats a cacheable write transaction during a Cle=
an &
> + =A0 =A0 =A0 =A0 Invalidate by Way operation Note that this errata uses =
Texas
> + =A0 =A0 =A0 =A0 Instrument's secure monitor api to implement the work a=
round.
> =A0endmenu
>
> =A0source "arch/arm/common/Kconfig"
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index f285dd7..1f0ff75 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -46,6 +46,7 @@ config ARCH_OMAP4
> =A0 =A0 =A0 =A0select ARM_GIC
> =A0 =A0 =A0 =A0select LOCAL_TIMERS
> =A0 =A0 =A0 =A0select PL310_ERRATA_588369
> + =A0 =A0 =A0 select PL310_ERRATA_727915
> =A0 =A0 =A0 =A0select ARM_ERRATA_720789
> =A0 =A0 =A0 =A0select ARCH_HAS_OPP
> =A0 =A0 =A0 =A0select PM_OPP if PM
> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> index 170c9bb..c7c8fbe 100644
> --- a/arch/arm/mm/cache-l2x0.c
> +++ b/arch/arm/mm/cache-l2x0.c
> @@ -67,7 +67,7 @@ static inline void l2x0_inv_line(unsigned long addr)
> =A0 =A0 =A0 =A0writel_relaxed(addr, base + L2X0_INV_LINE_PA);
> =A0}
>
> -#ifdef CONFIG_PL310_ERRATA_588369
> +#if defined(CONFIG_PL310_ERRATA_588369) || defined(CONFIG_PL310_ERRATA_7=
27915)
> =A0static void debug_writel(unsigned long val)
> =A0{
> =A0 =A0 =A0 =A0extern void omap_smc1(u32 fn, u32 arg);
> @@ -78,7 +78,14 @@ static void debug_writel(unsigned long val)
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0omap_smc1(0x100, val);
> =A0}
> +#else
> +/* Optimised out for non-errata case */
> +static inline void debug_writel(unsigned long val)
> +{
> +}
> +#endif
>
> +#ifdef CONFIG_PL310_ERRATA_588369
> =A0static inline void l2x0_flush_line(unsigned long addr)
> =A0{
> =A0 =A0 =A0 =A0void __iomem *base =3D l2x0_base;
> @@ -91,11 +98,6 @@ static inline void l2x0_flush_line(unsigned long addr)
> =A0}
> =A0#else
>
> -/* Optimised out for non-errata case */
> -static inline void debug_writel(unsigned long val)
> -{
> -}
> -
> =A0static inline void l2x0_flush_line(unsigned long addr)
> =A0{
> =A0 =A0 =A0 =A0void __iomem *base =3D l2x0_base;
> @@ -119,9 +121,11 @@ static void l2x0_flush_all(void)
>
> =A0 =A0 =A0 =A0/* clean all ways */
> =A0 =A0 =A0 =A0spin_lock_irqsave(&l2x0_lock, flags);
> + =A0 =A0 =A0 debug_writel(0x03);
> =A0 =A0 =A0 =A0writel_relaxed(l2x0_way_mask, l2x0_base + L2X0_CLEAN_INV_W=
AY);
> =A0 =A0 =A0 =A0cache_wait_way(l2x0_base + L2X0_CLEAN_INV_WAY, l2x0_way_ma=
sk);
> =A0 =A0 =A0 =A0cache_sync();
> + =A0 =A0 =A0 debug_writel(0x00);
> =A0 =A0 =A0 =A0spin_unlock_irqrestore(&l2x0_lock, flags);
> =A0}
>
> --
> 1.6.0.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

Can these PL310 errata fixes be made more generic? PL310 is present in
non-OMAP platforms too, which lack the TI hypervisor. And these
platforms might have the same PL310 rev, and suffer the same glitches.
While ideally there is some kind of hypervisor_ops to modify the
protected register, at the very least there should be the generic
debug_write handling the  "I  can write all PL310 regs" case. If
you're interested I have a patch someplace that tried to do this,
hopefully I can still find it.
