From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv2 00/16] OMAP IOMMU DT adaptation and cleanup
Date: Thu, 13 Feb 2014 12:15:31 -0600
Message-ID: <1392315347-32967-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

This is an updated series to the initial OMAP IOMMU DT driver
adaptation series [1], that primarily dealt with just the OMAP3
ISP MMU. This series is based on 3.14-rc2, and the patches were
developed in collaboration with Florian. I am hoping that the
series can make the 3.15 merge window.

This series updates the bindings for IOMMUs for all OMAP2+ SoCs
(OMAP3, OMAP4, OMAP5, DRA7), and includes new patches for adding
the support to iommus on OMAP4 and OMAP5, and IVA IOMMU on OMAP3.
The DT bindings and adaptation is done mainly in patches 3 and 4.
The differences between IOMMUs between different OMAP generations
is explained in the previous posting [1], and the differentiation
is achieved through two optional properties keeping the compatible
strings to a minimum. This could also have been achieved through
driver match data with a compatible string per sub-system, so do
let me know if that should be the preferred approach.

All the MMUs other than the OMAP3 ISP leverage omap_device reset
functions, performed through platform data ops previously. With
the removal of the legacy mode, the same functionality is achieved
for DT nodes through pdata quirks until a TI PRCM reset driver is
available.

The first 7 patches in the series are in drivers/iommu, with all the
remaining patches in the arch/arm/mach-omap2 layer.

Tony,
The last 3 patches are cleanup of the legacy mode, so IOMMU devices
cannot be instantiated after these patches. Please let me know if
legacy mode on OMAP3 needs to be supported for 3.15, in which case,
the last 3 can be dropped for now and I would have to revise the OMAP3
ISP archdata change (Patch 9) to support both legacy and DT boots.
At present, I have made the change to support OMAP3 ISP with DT-boot
only.

Detailed changes in v2:
- Cleanup of driver probe/release to use devm_ interfaces (Patch 1)
- The DT bindings are split into a separate patch, and updated based
  on discussion on v1 [1] (Patch 3)
- Updated DT adaptation patch with improved error checking, and
  support for DRA7 compatible IOMMUs in the driver (Patch 4)
- Added support for throwing a bus error response back to the processor
  cores on MMUs associated with IPUs (Patch 5)
- Added preliminary support to DT-based IOMMU users (Patch 6)
- Added preparatory patches to enable and use the hwmod for IVA MMU
  on OMAP3 (Patches 8 and 11)
- Adapt the OMAP3 ISP archdata to support DT boot (Patch 9). Legacy
  mode will not work after this patch, and this will be cleaned up
  anyway once OMAP3ISP is converted to a DT node.
- Reset functionality enablement with DT-boots using pdata quirks
  for OMAP3 IVA, OMAP4 and OMAP5 DSP & IPU MMUs (Patches 10, 13)
- Added the basic hwmod data for OMAP5 iommus (Patch 12)
- Clean up the iommu hwmod data and remove the legacy file for creating
  IOMMU devices (Patches 14, 15, 16).
- Dropped the "iommu/omap: Do bus_set_iommu() only if probe() succeeds"
  patch from previous series.
- Dropped the OMAP3 ISP MMU DTS patch (posting separately).

I have validated the functionality of all the different IOMMUs on
OMAP3, OMAP4 and OMAP5. Florian has verified the OMAP3 ISP usage as
well. The full branch including the DTS patches is here for reference, 
https://github.com/sumananna/omap-kernel/commits/iommu/3.14-rc2-dt-support-v2

v1:
- Couple of cleanup and initial DT adaptation for OMAP3 ISP.
http://marc.info/?l=linux-omap&m=138728485600624&w=2

[1] http://marc.info/?l=linux-omap&m=138782819732435&w=2


Florian Vaussard (8):
  iommu/omap: omap_iommu_attach() should return ENODEV, not NULL
  Documentation: dt: add OMAP iommu bindings
  iommu/omap: add devicetree support
  iommu/omap: allow enable/disable even without pdata
  ARM: OMAP3: remove deprecated CONFIG_OMAP_IOMMU_IVA2
  ARM: OMAP3: hwmod data: cleanup data for IOMMUs
  ARM: OMAP4: hwmod data: cleanup data for IOMMUs
  ARM: OMAP2+: Remove legacy omap-iommu.c

Laurent Pinchart (1):
  iommu/omap: allocate archdata on the fly for DT-based devices

Suman Anna (7):
  iommu/omap: convert to devm_* interfaces
  iommu/omap: enable bus-error back on supported iommus
  ARM: OMAP2+: change the ISP device archdata MMU name
  ARM: OMAP2+: use pdata quirks for iommu reset lines
  ARM: OMAP3: fix iva mmu programming issues
  ARM: OMAP5: hwmod data: add mmu data for ipu & dsp
  ARM: OMAP2+: extend iommu pdata-quirks to OMAP5

 .../devicetree/bindings/iommu/ti,omap-iommu.txt    |  28 ++++
 arch/arm/mach-omap2/Makefile                       |   3 -
 arch/arm/mach-omap2/clockdomains3xxx_data.c        |   2 +-
 arch/arm/mach-omap2/devices.c                      |   2 +-
 arch/arm/mach-omap2/omap-iommu.c                   |  74 ----------
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |  58 +-------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |  35 -----
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c         |  83 +++++++++++
 arch/arm/mach-omap2/pdata-quirks.c                 |  24 ++++
 arch/arm/plat-omap/Kconfig                         |   3 -
 drivers/iommu/omap-iommu.c                         | 154 +++++++++++++--------
 drivers/iommu/omap-iommu.h                         |   5 +
 drivers/iommu/omap-iommu2.c                        |   3 +
 13 files changed, 247 insertions(+), 227 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/ti,omap-iommu.txt
 delete mode 100644 arch/arm/mach-omap2/omap-iommu.c

-- 
1.8.5.3
