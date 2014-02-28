From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv3 00/13] OMAP IOMMU DT adaptation for 3.15
Date: Fri, 28 Feb 2014 14:42:31 -0600
Message-ID: <1393620164-14633-1-git-send-email-s-anna@ti.com>
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

Hi Joerg, Tony,

This is an updated series of the OMAP IOMMU DT adaptation intended
for 3.15 merge window, addressing the comments from the v2 series.
This series is rebased onto 3.14-rc4, and the only change to bindings
is to drop the dma-window property.

The first 7 patches in the series are in drivers/iommu, with the first
3 patches performing some cleanup. The DT bindings and adaptation are
done in patches 4 and 5.

Tony,
Patches 8 through 13 are in arch/arm/mach-omap2 layer, so I am guessing
these would have to go through your tree. Of these, patches 8 and 9 are
cleanup fixes to get OMAP3 IVA MMU working, patches 10 & 11 are fixes
required with DT-boot for OMAP3/4, patches 12 & 13 add the OMAP5 support.

I have validated the functionality of all the different IOMMUs on
OMAP3 (legacy and DT-boots), OMAP4 and OMAP5 (DT boot only). The full branch
including the DTS patches used to test is here for reference,
https://github.com/sumananna/omap-kernel/commits/iommu/3.14-rc4-dt-support-v3

Detailed changes in v3:
- Updated patch for fixing return errors in omap_iommu_attach (Patch 2)
- Updated bindings document and driver DT support patch to remove the
  dma-window property (Patches 4 and 5)
- Updated the OMAP3 ISP archdata to support both legacy and DT boots
  (Patch 10). This patch is reworked completely w.r.t v2.
- All the remaining patches are unchanged (Patches 1, 3, 6 through 9,
  11 through 13), other than the addition of the Acked-by received on
  the respective patches. Patches 3 and 9 are reordered compared to
  previous version.
- Dropped Patches 14 through 16 from previous series until OMAP3 is
  also converted to DT-only. These dealt with the cleanup of code
  used in legacy boot.

v2:
http://marc.info/?l=linux-omap&m=139231544416973&w=2
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

v1:
- Couple of cleanup and initial DT adaptation for OMAP3 ISP.
http://marc.info/?l=linux-omap&m=138728485600624&w=2


Florian Vaussard (4):
  iommu/omap: allow enable/disable even without pdata
  Documentation: dt: add OMAP iommu bindings
  iommu/omap: add devicetree support
  ARM: OMAP3: remove deprecated CONFIG_OMAP_IOMMU_IVA2

Laurent Pinchart (1):
  iommu/omap: allocate archdata on the fly for DT-based devices

Suman Anna (8):
  iommu/omap: convert to devm_* interfaces
  iommu/omap: fix error return paths in omap_iommu_attach()
  iommu/omap: enable bus-error back on supported iommus
  ARM: OMAP3: fix iva mmu programming issues
  ARM: OMAP2+: change the ISP device archdata MMU name for DT
  ARM: OMAP2+: use pdata quirks for iommu reset lines
  ARM: OMAP5: hwmod data: add mmu data for ipu & dsp
  ARM: OMAP2+: extend iommu pdata-quirks to OMAP5

 .../devicetree/bindings/iommu/ti,omap-iommu.txt    |  26 ++++
 arch/arm/mach-omap2/clockdomains3xxx_data.c        |   2 +-
 arch/arm/mach-omap2/devices.c                      |   3 +
 arch/arm/mach-omap2/omap-iommu.c                   |   5 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |  12 +-
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c         |  83 +++++++++++
 arch/arm/mach-omap2/pdata-quirks.c                 |  24 ++++
 arch/arm/plat-omap/Kconfig                         |   3 -
 drivers/iommu/omap-iommu.c                         | 159 +++++++++++++--------
 drivers/iommu/omap-iommu.h                         |   5 +
 drivers/iommu/omap-iommu2.c                        |   3 +
 11 files changed, 256 insertions(+), 69 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/ti,omap-iommu.txt

-- 
1.9.0
