From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/4] Add DRA7 IOMMU DT nodes
Date: Tue, 21 Jul 2015 19:01:30 -0500
Message-ID: <1437523294-20058-1-git-send-email-s-anna@ti.com>
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
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

The following patches add the basic DT nodes for the DSP
and IPU IOMMU devices for the DRA7xx SoC family. The first
two patches add syscon nodes for DSP_SYSTEM sub-modules, while
the last two add the IOMMU nodes.

The IPU IOMMU nodes mostly are similar to existing ones on OMAP4
and OMAP5. The DSP sub-system though has two MMUs, with a dedicated
MMU for the internal EDMA engine. On previous SoCs, a single MMU
served both the DSP processor and the internal EDMA. The DSP IOMMU
nodes require a new property to reference the syscon nodes, as they
each need a specific bit to be set in a register within the
corresponding DSP_SYSTEM sub-module. So, these are pending based
on the equivalent bindings update series [1]. Please let me know
if the binding looks ok to you, as this seems it can be done in
couple of ways.

Patches are based on 4.2-rc3.

regards
Suman

[1] http://marc.info/?l=linux-omap&m=143752295508435&w=2

Suman Anna (4):
  ARM: dts: DRA7: Add dsp1_system syscon node
  ARM: dts: DRA74x: Add dsp2_system syscon node
  ARM: dts: DRA7: Add common IOMMU nodes
  ARM: dts: DRA74x: Add IOMMU nodes for DSP2

 arch/arm/boot/dts/dra7.dtsi   | 45 +++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/dra74x.dtsi | 25 ++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

-- 
2.4.4
