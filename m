From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/2] DRA7 DSP MMU config support
Date: Tue, 21 Jul 2015 18:55:34 -0500
Message-ID: <1437522936-19758-1-git-send-email-s-anna@ti.com>
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

This series adds the basic support in the OMAP IOMMU driver to
enable/disable DSP IOMMUs for the DRA7xx family of SoCs. The
DRA7 family has two MMUs within the DSP processor subsystems.
This is the first time this was designed so in the silicon
compared to the equivalent ones on OMAP2+ SoCs.

Each MMU requires a specific bit to be turned on within a register
from a separate sub-module DSP_SYSTEM present within the respective
processor subsystem. The DSP_SYSTEM sub-module is represented as a
syscon node, and an additional property "ti,syscon-mmuconfig" is
used alongside a unique compatible property for configuring these
devices. The register and bit offset is coded up in the driver
while the DT property references the syscon phandle the MMU instance
number.

The binding support could have been done in couple of other ways,
like using separate compatible each for the DSP processor MMU &
the DSP EDMA MMU that automatically identifies the instance number;
and/or coding up the register offset & bit position/offset in
the syscon property, so let me know if the current approach is
fine.

The patches are baselined on 4.2-rc3 + the recent OMAP IOMMU
cleanup series [1]. I will post the DTS patches separately to
allow Tony to pick them up independently.

regards
Suman

[1] http://lists.linuxfoundation.org/pipermail/iommu/2015-July/013659.html

Suman Anna (2):
  Documentation: dt: Update OMAP iommu bindings for DRA7 DSPs
  iommu/omap: Add support for configuring dsp iommus on DRA7xx

 .../devicetree/bindings/iommu/ti,omap-iommu.txt    | 27 ++++++++++
 drivers/iommu/omap-iommu.c                         | 58 ++++++++++++++++++++++
 drivers/iommu/omap-iommu.h                         |  9 ++++
 3 files changed, 94 insertions(+)

-- 
2.4.4
