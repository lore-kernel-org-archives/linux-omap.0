From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v4 00/25] dmaengine/ARM: Merge the edma drivers into one
Date: Tue, 6 Oct 2015 09:15:09 +0300
Message-ID: <561366ED.8010800@ti.com>
References: <1443088932-21731-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443088932-21731-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, nsekhar@ti.com, linux@arm.linux.org.uk
Cc: olof@lixom.net, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi

On 09/24/2015 01:01 PM, Peter Ujfalusi wrote:
> Hi,
>=20
> Changes since v3:
> - Separated the two (patch 10/11 in v2 patch 10 in v3) patch which go=
t squashed
>   by accident for v3
> - Added Tony's Acked-by to patch 11 (for mach-oamp2 part)

Gentle ping on this series ;)

--=20
P=E9ter

> Changes since v2:
> - devm_kasprintf format string fixed
> - Additional patch to enable dynamic paRAM slot usage when the channe=
l mapping
>   is supported by the eDMA module.
>   On am335x we have 256 paRAM slots and 64 DMA channels, this means t=
hat we had
>   64 slots 'locked away' all the time. The dynamic paRAM slot logic w=
ill allow
>   us to use all 256 slots freely for any purpose.
>=20
> Changes since v1:
> - Convert edma platform device registration to use platform_device_re=
gister_full
> - Moved the PM callback also to the dmaengine driver - missed in v1
> - Commit message added to:
>   ARM/dmaengine: edma: Remove limitation on the number of eDMA contro=
llers
> - New patch which reads the flag for the channel mapping support in o=
ne place
>=20
> Cover letter:
>=20
> with this series the edma two driver setup will be changed to have on=
ly one
> driver to support eDMA3. The legacy edma interface will be removed an=
d eDMA can
> only be used via dmaengine API from this point on.
> In order to do the merge the following improvements has been done:
> - One driver instance per eDMA:
>  - Any number of eDMA instances are supported (both legacy and DT boo=
t)
> - Not relying on global variables, arrays, etc
> - Code simplification and optimizations in several places
>=20
> This change will also help us to do bigger changes in the eDMA driver=
 since,
> since now we have only one driver to work with.
>=20
> The series has been tested on:
> da850-evm (OMAP-L138)
> - with legacy and DT boot (both eDMA0 and eDMA1 is enabled)
> - In code swapping the eDMA instances in legacy mode to make sure the=
 second
>   instance is handled correctly.
>=20
> am335x-evmsk
> - DT boot
>=20
> I think this series could go via the dmaengine tree. Changes are triv=
ial under
> arch/arm/
>=20
> Regards,
> Peter
> ---
> Peter Ujfalusi (25):
>   ARM: common: edma: Fix channel parameter for irq callbacks
>   ARM: common: edma: Remove unused functions
>   dmaengine: edma: Simplify and optimize the edma_execute path
>   ARM: davinci/common: Convert edma driver to handle one eDMA instanc=
e
>     per driver
>   ARM/dmaengine: edma: Move of_dma_controller_register to the dmaengi=
ne
>     driver
>   ARM: common: edma: Internal API to use pointer to 'struct edma'
>   ARM/dmaengine: edma: Public API to use private struct pointer
>   ARM/dmaengine: edma: Remove limitation on the number of eDMA
>     controllers
>   ARM: davinci: Use platform_device_register_full() to create pdev fo=
r
>     eDMA
>   ARM: davinci: Add dma_mask to eDMA devices
>   ARM/dmaengine: edma: Merge the two drivers under drivers/dma/
>   dmaengine: edma: Allocate memory dynamically for bitmaps and
>     structures
>   dmaengine: edma: Parameter alignment and long line fixes
>   dmaengine: edma: Use devm_kcalloc when possible
>   dmaengine: edma: Cleanup regarding the use of dev around the code
>   dmaengine: edma: Use dev_dbg instead pr_debug
>   dmaengine: edma: Use the edma_write_slot instead open coded
>     memcpy_toio
>   dmaengine: edma: Print warning when linking slots from different eD=
MA
>   dmaengine: edma: Consolidate the comments for functions
>   dmaengine: edma: Simplify the interrupt handling
>   dmaengine: edma: Move the pending error check into helper function
>   dmaengine: edma: Simplify and optimize ccerr interrupt handler
>   dmaengine: edma: Read channel mapping support only once from HW
>   dmaengine: edma: Rename bitfields for slot and channel usage tracki=
ng
>   dmaengine: edma: Dynamic paRAM slot handling if HW supports it
>=20
>  arch/arm/Kconfig                      |    1 -
>  arch/arm/common/Kconfig               |    3 -
>  arch/arm/common/Makefile              |    1 -
>  arch/arm/common/edma.c                | 1876 -----------------------=
----------
>  arch/arm/mach-davinci/devices-da8xx.c |  122 +--
>  arch/arm/mach-davinci/dm355.c         |   40 +-
>  arch/arm/mach-davinci/dm365.c         |   25 +-
>  arch/arm/mach-davinci/dm644x.c        |   40 +-
>  arch/arm/mach-davinci/dm646x.c        |   44 +-
>  arch/arm/mach-omap2/Kconfig           |    1 -
>  drivers/dma/Kconfig                   |    1 -
>  drivers/dma/edma.c                    | 1569 +++++++++++++++++++++++=
+---
>  include/linux/platform_data/edma.h    |  101 --
>  13 files changed, 1523 insertions(+), 2301 deletions(-)
>  delete mode 100644 arch/arm/common/edma.c
>=20
