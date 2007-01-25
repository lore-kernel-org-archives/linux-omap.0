From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: FW: [RFC PATCH 5/5] DSB needed after masking an IRQ
Date: Thu, 25 Jan 2007 09:28:33 -0600
Message-ID: <3B6D69C3A9EBCA4BA5DA60D913027429330215@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

As you may recall, I've repentantly submitted patches for doing this for
OMAP2's interrupt controller as it has the same issue as its off of the
peripheral port.

Now that Catalin alo confirming does that help?  I'm still unsure what
that aspect was so bothersome.

Regards,
Richard W.



> -----Original Message-----
> From: linux-arm-kernel-bounces@lists.arm.linux.org.uk=20
> [mailto:linux-arm-kernel-bounces@lists.arm.linux.org.uk] On=20
> Behalf Of Catalin Marinas
> Sent: Thursday, January 25, 2007 7:26 AM
> To: linux-arm-kernel@lists.arm.linux.org.uk
> Subject: [RFC PATCH 5/5] DSB needed after masking an IRQ
>=20
> Starting with ARMv6, accesses to strongly ordered memory are=20
> not guaranteed to complete before a subsequent instruction=20
> modifying the interrupt mask in CPSR. This can cause=20
> potential problems with masking or acknowledging an IRQ at=20
> the device or interrupt controller level followed by a=20
> local_irq_enable or local_irq_restore (see B2.4.3 in ARM ARM=20
> revI). This patch adds a DSB after masking the interrupts at=20
> the interrupt controller level to ensure that the strongly=20
> ordered memory access was completed.
>=20
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>=20
>  arch/arm/common/gic.c                    |    4 ++++
>  arch/arm/common/vic.c                    |    2 ++
>  arch/arm/mach-integrator/integrator_ap.c |    1 +
>  arch/arm/mach-integrator/integrator_cp.c |    1 +
>  4 files changed, 8 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c=20
> index 4deece5..b5bec43 100644
> --- a/arch/arm/common/gic.c
> +++ b/arch/arm/common/gic.c
> @@ -28,6 +28,7 @@
>  #include <linux/smp.h>
>  #include <linux/cpumask.h>
> =20
> +#include <asm/system.h>
>  #include <asm/irq.h>
>  #include <asm/io.h>
>  #include <asm/mach/irq.h>
> @@ -87,6 +88,7 @@ static void gic_ack_irq(unsigned int irq)
>  	spin_lock(&irq_controller_lock);
>  	writel(mask, gic_dist_base(irq) + GIC_DIST_ENABLE_CLEAR=20
> + (gic_irq(irq) / 32) * 4);
>  	writel(gic_irq(irq), gic_cpu_base(irq) + GIC_CPU_EOI);
> +	dsb();
>  	spin_unlock(&irq_controller_lock);
>  }
> =20
> @@ -96,6 +98,7 @@ static void gic_mask_irq(unsigned int irq)
> =20
>  	spin_lock(&irq_controller_lock);
>  	writel(mask, gic_dist_base(irq) + GIC_DIST_ENABLE_CLEAR=20
> + (gic_irq(irq) / 32) * 4);
> +	dsb();
>  	spin_unlock(&irq_controller_lock);
>  }
> =20
> @@ -229,6 +232,7 @@ void __init gic_dist_init(unsigned int=20
> gic_nr, void __iomem *base,
>  	 */
>  	for (i =3D 0; i < max_irq; i +=3D 32)
>  		writel(0xffffffff, base + GIC_DIST_ENABLE_CLEAR=20
> + i * 4 / 32);
> +	dsb();
> =20
>  	/*
>  	 * Setup the Linux IRQ subsystem.
> diff --git a/arch/arm/common/vic.c b/arch/arm/common/vic.c=20
> index c026fa2..8b588b4 100644
> --- a/arch/arm/common/vic.c
> +++ b/arch/arm/common/vic.c
> @@ -21,6 +21,7 @@
>  #include <linux/init.h>
>  #include <linux/list.h>
> =20
> +#include <asm/system.h>
>  #include <asm/io.h>
>  #include <asm/mach/irq.h>
>  #include <asm/hardware/vic.h>
> @@ -30,6 +31,7 @@ static void vic_mask_irq(unsigned int irq)
>  	void __iomem *base =3D get_irq_chip_data(irq);
>  	irq &=3D 31;
>  	writel(1 << irq, base + VIC_INT_ENABLE_CLEAR);
> +	dsb();
>  }
> =20
>  static void vic_unmask_irq(unsigned int irq) diff --git=20
> a/arch/arm/mach-integrator/integrator_ap.c=20
> b/arch/arm/mach-integrator/integrator_ap.c
> index 7228075..015c0d7 100644
> --- a/arch/arm/mach-integrator/integrator_ap.c
> +++ b/arch/arm/mach-integrator/integrator_ap.c
> @@ -154,6 +154,7 @@ static void __init ap_map_io(void) =20
> static void sc_mask_irq(unsigned int irq)  {
>  	writel(1 << irq, VA_IC_BASE + IRQ_ENABLE_CLEAR);
> +	dsb();
>  }
> =20
>  static void sc_unmask_irq(unsigned int irq) diff --git=20
> a/arch/arm/mach-integrator/integrator_cp.c=20
> b/arch/arm/mach-integrator/integrator_cp.c
> index 913f64b..d1c0679 100644
> --- a/arch/arm/mach-integrator/integrator_cp.c
> +++ b/arch/arm/mach-integrator/integrator_cp.c
> @@ -148,6 +148,7 @@ static void cic_mask_irq(unsigned int irq)  {
>  	irq -=3D IRQ_CIC_START;
>  	cic_writel(1 << irq, INTCP_VA_CIC_BASE + IRQ_ENABLE_CLEAR);
> +	dsb();
>  }
> =20
>  static void cic_unmask_irq(unsigned int irq)
>=20
> -------------------------------------------------------------------
> List admin:=20
> http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
> FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
> Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
>=20
