From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [RFC 0/6] iommu: generic api migration and grouping
Date: Fri, 3 Jun 2011 08:57:00 +0900
Message-ID: <BANLkTimQA0Nsh+jgS=hD1VxKkD3zg84y+A@mail.gmail.com>
References: <1307053663-24572-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1307053663-24572-1-git-send-email-ohad@wizery.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-media@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, laurent.pinchart@ideasonboard.com, Hiroshi.DOYU@nokia.com, arnd@arndb.de, davidb@codeaurora.org, Joerg.Roedel@amd.com, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-omap@vger.kernel.org

Hi,

Good approach.
CC'ed the Samsung IOMMU developer. Marek.

BTW, Russell wants to use the DMA based IOMMU?

Please see the RFC patch, ARM: DMA-mapping & IOMMU integration
http://www.spinics.net/lists/linux-mm/msg19856.html

Thank you,
Kyungmin Park

On Fri, Jun 3, 2011 at 7:27 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> First stab at iommu consolidation:
>
> - Migrate OMAP's iommu driver to the generic iommu API. With this in =
hand,
> =A0users can now start using the generic iommu layer instead of calli=
ng
> =A0omap-specific iommu API.
>
> =A0New code that requires functionality missing from the generic iomm=
u api,
> =A0will add that functionality in the generic framework (e.g. adding =
framework
> =A0awareness to multi page sizes, supported by the underlying hardwar=
e, will
> =A0avoid the otherwise-inevitable code duplication when mapping a mem=
ory
> =A0region).
>
> =A0OMAP-specific api that is still exposed in the omap iommu driver c=
an
> =A0now be either moved to the generic iommu framework, or just remove=
d (if not
> =A0used).
>
> =A0This api (and other omap-specific primitives like struct iommu) ne=
eds to
> =A0be omapified (i.e. renamed to include an 'omap_' prefix). At this =
early
> =A0point of this patch set this is too much churn though, so I'll do =
that
> =A0in the following iteration, after (and if), the general direction =
is
> =A0accepted.
>
> - Migrate OMAP's iovmm (virtual memory manager) driver to the generic
> =A0iommu API. With this in hand, iovmm no longer uses omap-specific a=
pi
> =A0for mapping/unmapping operations. Nevertheless, iovmm is still cou=
pled
> =A0with omap's iommu even with this change: it assumes omap page size=
s,
> =A0and it uses omap's iommu objects to maintain its internal state.
>
> =A0Further generalizing of iovmm strongly depends on our broader plan=
s for
> =A0providing a generic virtual memory manager and allocation framewor=
k
> =A0(which, as discussed, should be separated from a specific mapper).
>
> =A0iovmm has a mainline user: omap3isp, and therefore must be maintai=
ned,
> =A0but new potential users will either have to generalize it, or come=
 up
> =A0with a different generic framework that will replace it.
>
> - Migrate OMAP's iommu mainline user, omap3isp, to the generic API as=
 well
> =A0(so it doesn't break). As with iovmm, omap3isp still depends on
> =A0omap's iommu, mainly because iovmm depends on it, but also for
> =A0iommu context saving and restoring.
>
> =A0It is definitely desirable to completely remove omap3isp's depende=
ncy
> =A0on the omap-specific iommu layer, and that will be possible as the
> =A0required functionality will be added to generic framework.
>
> - Create a dedicated iommu drivers folder (and put the base iommu cod=
e there)
> - Move OMAP's and MSM's iommu drivers to that drivers iommu folder
>
> =A0Putting all iommu drivers together will ease finding similarities
> =A0between different platforms, with the intention of solving problem=
s once,
> =A0in a generic framework which everyone can use.
>
> =A0I've only moved the omap and msm implementations for now, to demon=
strate
> =A0the idea (and support the ARM diet :), but if this is found desira=
ble,
> =A0we can bring in intel-iommu.c and amd_iommu.c as well.
>
> Meta:
>
> - This patch set is not bisectable; it was splitted (and ordered) thi=
s way
> =A0to ease its review. Later iterations of this patch set will fix th=
at
> =A0(most likely by squashing the first three patches)
> - Based on and tested with 3.0-rc1
> - OMAP's iommu code was tested on both OMAP3 and OMAP4
> - omap3isp code was tested with a sensor-less OMAP3 (memory-to-memory=
 only)
> =A0(thanks Laurent Pinchart for showing me the magic needed to test o=
map3isp :)
> - MSM code was only compile tested
>
> Ohad Ben-Cohen (6):
> =A0omap: iommu: generic iommu api migration
> =A0omap: iovmm: generic iommu api migration
> =A0media: omap3isp: generic iommu api migration
> =A0drivers: iommu: move to a dedicated folder
> =A0omap: iommu/iovmm: move to dedicated iommu folder
> =A0msm: iommu: move to dedicated iommu drivers folder
>
> =A0arch/arm/mach-msm/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0| =A0 15 -
> =A0arch/arm/mach-msm/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 =A02 +-
> =A0arch/arm/plat-omap/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 12 -
> =A0arch/arm/plat-omap/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| =A0 =A02 -
> =A0arch/arm/plat-omap/include/plat/iommu.h =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A03 +-
> =A0arch/arm/plat-omap/{ =3D> include/plat}/iopgtable.h =A0| =A0 18 ++
> =A0arch/arm/plat-omap/include/plat/iovmm.h =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 27 +-
> =A0arch/x86/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 | =A0 =A05 +-
> =A0drivers/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0| =A0 =A02 +
> =A0drivers/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 | =A0 =A01 +
> =A0drivers/base/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0| =A0 =A01 -
> =A0drivers/iommu/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0| =A0 32 +++
> =A0drivers/iommu/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 | =A0 =A05 +
> =A0drivers/{base =3D> iommu}/iommu.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 =A00
> =A0.../mach-msm/iommu.c =3D> drivers/iommu/msm-iommu.c =A0| =A0 =A00
> =A0.../iommu/omap-iommu-debug.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 =A02 +-
> =A0.../iommu.c =3D> drivers/iommu/omap-iommu.c =A0 =A0 =A0 =A0 =A0| =A0=
290 +++++++++++++++++---
> =A0.../iovmm.c =3D> drivers/iommu/omap-iovmm.c =A0 =A0 =A0 =A0 =A0| =A0=
113 +++++---
> =A0drivers/media/video/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| =A0 =A02 +-
> =A0drivers/media/video/omap3isp/isp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 41 +++-
> =A0drivers/media/video/omap3isp/isp.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 =A03 +
> =A0drivers/media/video/omap3isp/ispccdc.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 16 +-
> =A0drivers/media/video/omap3isp/ispstat.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A06 +-
> =A0drivers/media/video/omap3isp/ispvideo.c =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A04 +-
> =A024 files changed, 451 insertions(+), 151 deletions(-)
> =A0rename arch/arm/plat-omap/{ =3D> include/plat}/iopgtable.h (84%)
> =A0create mode 100644 drivers/iommu/Kconfig
> =A0create mode 100644 drivers/iommu/Makefile
> =A0rename drivers/{base =3D> iommu}/iommu.c (100%)
> =A0rename arch/arm/mach-msm/iommu.c =3D> drivers/iommu/msm-iommu.c (1=
00%)
> =A0rename arch/arm/plat-omap/iommu-debug.c =3D> drivers/iommu/omap-io=
mmu-debug.c (99%)
> =A0rename arch/arm/plat-omap/iommu.c =3D> drivers/iommu/omap-iommu.c =
(77%)
> =A0rename arch/arm/plat-omap/iovmm.c =3D> drivers/iommu/omap-iovmm.c =
(85%)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
