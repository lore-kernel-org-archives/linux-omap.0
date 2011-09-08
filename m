From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 13/25] OMAP4: PM: Add WakeupGen module as OMAP
	gic_arch_extn
Date: Thu, 8 Sep 2011 21:16:54 +0200
Message-ID: <CAORVsuX0NnDBtLOJwQF-qgo4hq9wp2+d=HcLLtJzYGsuzc_z1A@mail.gmail.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
	<1315144466-9395-14-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1315144466-9395-14-git-send-email-santosh.shilimkar@ti.com>
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
Cc: khilman@ti.com, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, rnayak@ti.com
List-Id: linux-omap@vger.kernel.org

On Sun, Sep 4, 2011 at 3:54 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> OMAP WakeupGen is the interrupt controller extension used along
> with ARM GIC to wake the CPU out from low power states on
> external interrupts.
>
> The WakeupGen unit is responsible for generating wakeup event
... for generating the wakeup events
> from the incoming interrupts and enable bits. It is implemented
> in MPU always ON power domain. During normal operation,
in the MPU...
> WakeupGen delivers external interrupts directly to the GIC.
... delivers the external interrupts

>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> ---
> =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 =A02 +-
> =A0arch/arm/mach-omap2/include/mach/omap-wakeupgen.h | =A0 39 ++++
> =A0arch/arm/mach-omap2/omap-wakeupgen.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A02=
41 +++++++++++++++++++++
> =A0arch/arm/mach-omap2/omap4-common.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 =A03 +
> =A04 files changed, 284 insertions(+), 1 deletions(-)
> =A0create mode 100644 arch/arm/mach-omap2/include/mach/omap-wakeupgen.h
> =A0create mode 100644 arch/arm/mach-omap2/omap-wakeupgen.c
>
...

> + */
> +int __init omap_wakeupgen_init(void)
> +{
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 unsigned int boot_cpu =3D smp_processor_id();
> +
> + =A0 =A0 =A0 /* Not supported on OMAP4 ES1.0 silicon */
> + =A0 =A0 =A0 if (omap_rev() =3D=3D OMAP4430_REV_ES1_0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, "WakeupGen: Not supported on OMAP44=
30 ES1.0\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EPERM;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Static mapping, never released */
> + =A0 =A0 =A0 wakeupgen_base =3D ioremap(OMAP44XX_WKUPGEN_BASE, SZ_4K);
> + =A0 =A0 =A0 if (WARN_ON(!wakeupgen_base))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
-ENOMEM os required as discussed in the other patches of the series.

Regards,
Jean
