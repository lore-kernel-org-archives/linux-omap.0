From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 00/25] OMAP4: PM: suspend, CPU-hotplug and CPUilde support
Date: Thu, 8 Sep 2011 22:15:19 +0200
Message-ID: <CAORVsuX4wZOr71RahnLUHwDMT1B1593bdKFAynNqtVXJOWVazQ@mail.gmail.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
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

Hi Santosh,

On Sun, Sep 4, 2011 at 3:54 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> This series adds OMAP4 MPUSS (MPU SubSystem) power management support for
> suspend (S2R), CPU hotplug and CPUidle.
>
> Most of these patches have been posted and reviewed earlier [1] on the li=
st
> and have missed last couple of merge windows because of dependencies.
> New set of patches have diverged more and hence the series version
> continuity isn't maintained.
>
> Below are the main updates from previous versions.
> - Use of generic ARM suspend hooks instead of OMAP custom code.
> - Making use of common GIC code instead of OMAP custom code.
> - Use of generic CPU PM notifiers for CPUIDLE and suspend.
> - Use of CPU PM notifiers and hotplug notifiers for GIC extension.
> - PM support of OMAP4 HS devices.
> - Introduction of interconnect barriers as per the OMAP4 requirements.
>
> Special thanks to,
> - Kevin Hilman for the detailed reviews.
> - Russell for adding the L2 cache handling support to generic suspend.
> - Colin Cross for the generic CPU PM notifier patches.
> - Rajendra Nayak and Paul Walmsley for clock-domain sequencing series.
>
> Below series has dependency on Russell's L2 generic suspend support [2]
> and earlier posted CPU PM notifiers series [3].
> An integrated branch with these dependencies can be found here [4].
>
> The series is tested on OMAP4430 SDP for suspend, hotplug and CPUidle
> with OMAP4 GP and HS (secure) devices.
>
> The following changes since commit c6a389f123b9f68d605bb7e0f9b32ec1e3e141=
32:
>
> =A0Linux 3.1-rc4 (2011-08-28 21:16:01 -0700)
>
> are available in the git repository at:
> =A0git://gitorious.org/omap-sw-develoment/linux-omap-dev.git v3.1-rc4-oma=
p4-mpuss-pm

Some comments have been sent on this patch set, otherwise OK after review.

FWIW:
Acked-by: Jean Pihet <j-pihet@ti.com>

Regards,
Jean

>
> Santosh Shilimkar (25):
> =A0 =A0 =A0ARM: mm: Add strongly ordered descriptor support.
> =A0 =A0 =A0OMAP4: Redefine mandatory barriers for OMAP to include interco=
nnect barriers.
> =A0 =A0 =A0OMAP4: PM: Use custom omap_do_wfi() for suspend and default id=
le.
> =A0 =A0 =A0OMAP4: Remove un-used do_wfi() macro.
> =A0 =A0 =A0OMAP4: Use WARN_ON() instead of BUG_ON() with graceful exit
> =A0 =A0 =A0OMAP4: Export omap4_get_base*() rather than global address poi=
nters
> =A0 =A0 =A0OMAP4: PM: Add SAR RAM support
> =A0 =A0 =A0OMAP4: PM: Keep static dep between MPUSS-EMIF and MPUSS-L3 and=
 DUCATI-L3
> =A0 =A0 =A0OMAP4: PM: Avoid omap4_pm_init() on OMAP4430 ES1.0
> =A0 =A0 =A0OMAP4: PM: Initialise all the clockdomains to supported states
> =A0 =A0 =A0OMAP: Add Secure HAL and monitor mode API infrastructure.
> =A0 =A0 =A0OMAP: Add support to allocate the memory for secure RAM
> =A0 =A0 =A0OMAP4: PM: Add WakeupGen module as OMAP gic_arch_extn
> =A0 =A0 =A0OMAP4: PM: Add CPUX OFF mode support
> =A0 =A0 =A0OMAP4: Remove __INIT from omap_secondary_startup() to re-use i=
t for hotplug.
> =A0 =A0 =A0OMAP4: PM: Program CPU1 to hit OFF when off-lined
> =A0 =A0 =A0OMAP4: PM: CPU1 wakeup workaround from Low power modes
> =A0 =A0 =A0OMAP4: suspend: Add MPUSS power domain RETENTION support
> =A0 =A0 =A0OMAP4: PM: Add WakeupGen and secure GIC low power support
> =A0 =A0 =A0OMAP4: PM: Add L2X0 cache lowpower support
> =A0 =A0 =A0OMAP4: PM: Add MPUSS power domain OSWR support
> =A0 =A0 =A0OMAP4: PM: Add power domain statistics support
> =A0 =A0 =A0OMAP4: PM: Add CPUidle support
> =A0 =A0 =A0OMAP4: cpuidle: Switch to gptimer from twd in deeper C-states.
> =A0 =A0 =A0OMAP3: CPUidle: Make use of CPU PM notifiers
>
> =A0arch/arm/include/asm/mach/map.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 =A01 +
> =A0arch/arm/include/asm/pgtable.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 =A03 +
> =A0arch/arm/mach-omap2/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 =A01 +
> =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 | =A0 15 +-
> =A0arch/arm/mach-omap2/cpuidle34xx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 =A07 +
> =A0arch/arm/mach-omap2/cpuidle44xx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0206 ++++++++++
> =A0arch/arm/mach-omap2/include/mach/barriers.h =A0 =A0 =A0 =A0| =A0 48 +++
> =A0arch/arm/mach-omap2/include/mach/omap-secure.h =A0 =A0 | =A0 57 +++
> =A0arch/arm/mach-omap2/include/mach/omap-wakeupgen.h =A0| =A0 39 ++
> =A0arch/arm/mach-omap2/include/mach/omap4-common.h =A0 =A0| =A0 70 +++-
> =A0arch/arm/mach-omap2/omap-headsmp.S =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 =A05 -
> =A0arch/arm/mach-omap2/omap-hotplug.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 14 +-
> =A0arch/arm/mach-omap2/omap-mpuss-lowpower.c =A0 =A0 =A0 =A0 =A0| =A0398 =
+++++++++++++++++++
> =A0arch/arm/mach-omap2/omap-secure.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 81 ++++
> =A0arch/arm/mach-omap2/{omap44xx-smc.S =3D> omap-smc.S} | =A0 23 ++
> =A0arch/arm/mach-omap2/omap-smp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 38 ++
> =A0arch/arm/mach-omap2/omap-wakeupgen.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
403 ++++++++++++++++++++
> =A0arch/arm/mach-omap2/omap4-common.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 93 +++++-
> =A0arch/arm/mach-omap2/omap4-sar-layout.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0 5=
0 +++
> =A0arch/arm/mach-omap2/pm.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | =A0 =A01 +
> =A0arch/arm/mach-omap2/pm44xx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 | =A0155 ++++++++-
> =A0arch/arm/mach-omap2/sleep44xx.S =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0385 +++++++++++++++++++
> =A0arch/arm/mm/mmu.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0| =A0 =A08 +
> =A0arch/arm/plat-omap/common.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 =A03 +
> =A0arch/arm/plat-omap/include/plat/omap44xx.h =A0 =A0 =A0 =A0 | =A0 =A01 +
> =A0arch/arm/plat-omap/include/plat/sram.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
=A01 +
> =A0arch/arm/plat-omap/sram.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 47 ++-
> =A027 files changed, 2104 insertions(+), 49 deletions(-)
> =A0create mode 100644 arch/arm/mach-omap2/cpuidle44xx.c
> =A0create mode 100644 arch/arm/mach-omap2/include/mach/barriers.h
> =A0create mode 100644 arch/arm/mach-omap2/include/mach/omap-secure.h
> =A0create mode 100644 arch/arm/mach-omap2/include/mach/omap-wakeupgen.h
> =A0create mode 100644 arch/arm/mach-omap2/omap-mpuss-lowpower.c
> =A0create mode 100644 arch/arm/mach-omap2/omap-secure.c
> =A0rename arch/arm/mach-omap2/{omap44xx-smc.S =3D> omap-smc.S} (70%)
> =A0create mode 100644 arch/arm/mach-omap2/omap-wakeupgen.c
> =A0create mode 100644 arch/arm/mach-omap2/omap4-sar-layout.h
> =A0create mode 100644 arch/arm/mach-omap2/sleep44xx.S
>
> Regards
> Santosh
>
> [1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg47511.html
>
> [2] http://www.spinics.net/lists/arm-kernel/msg138803.html
>
> [3] https://lkml.org/lkml/2011/9/3/49
>
> [4] https://gitorious.org/omap-sw-develoment/linux-omap-dev/commits/v3.1-=
rc4-omap4-pm-integrated
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
