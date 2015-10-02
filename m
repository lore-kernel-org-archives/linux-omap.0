From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [REPOST PATCH 0/4] Add DRA7 IOMMU DT nodes
Date: Fri, 2 Oct 2015 18:23:21 -0500
Message-ID: <1443828205-18706-1-git-send-email-s-anna@ti.com>
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

The following series is a repost of the previous seried that
added the basic DT nodes for the DSP and IPU IOMMU devices for
the DRA7xx SoC family [1]. There are no code changes, but the
patches have to be rebased to resolve slight merge conflicts
as the dra7_ctrl_core and dra7_ctrl_general nodes have been
removed since the last submission.

This patch series is pending based on the equivalent bindings
update series [2] which has also been reposted without any changes.

Patches are based on 4.3-rc3.

regards
Suman

[1] http://marc.info/?l=linux-omap&m=143752332808524&w=2
[2] http://marc.info/?l=linux-omap&m=144382697928741&w=2

Suman Anna (4):
  ARM: dts: DRA7: Add dsp1_system syscon node
  ARM: dts: DRA74x: Add dsp2_system syscon node
  ARM: dts: DRA7: Add common IOMMU nodes
  ARM: dts: DRA74x: Add IOMMU nodes for DSP2

 arch/arm/boot/dts/dra7.dtsi   | 45 +++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/dra74x.dtsi | 25 ++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

-- 
2.6.0
