From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [REPOST PATCH 0/2] DRA7 DSP MMU config support
Date: Fri, 2 Oct 2015 18:02:42 -0500
Message-ID: <1443826964-10691-1-git-send-email-s-anna@ti.com>
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

Hi Joerg,

This is a repost of the DRA7 DSP MMU config support patch series,
baselined on the latest rc (4.3-rc3). Details of the MMUs are summarized
in the previous series [1], and the discussion with Tony did not require
any changes to the code from that series. As per your request, I have
also summarized the testing details below.

I have tested the patches on OMAP3 Beagle-XM, OMAP4 Panda Board,
OMAP5 uEVM and DRA7 Beagle-X15 boards using a OMAP IOMMU unit test
module [2]. The unit test basically requires a test node to be added
to the respective nodes with it using the IOMMU under test. The test
is done during the probe of the test platform driver, with it mainly
attaching to the IOMMU and programming the MMU pagetable. The entire
test branch is hosted [3] for your reference and the corresponding
logs are at [4].

A few additional notes regarding testing:
- OMAP3 IVA MMU node was disabled at the moment in kernel, so it
  had to be enabled in the test branch along with the test node. A
  fix [5] was required in the TI CLK driver for it to pass the
  test, and this fix will be incorporated into the current -rc cycle.
- One MMU device is tested per boot, depending on the IOMMU used by
  the test node.
- This is only a preparatory series in adding the IOMMU support
  for the DRA7 SoCs. Full enablement of DRA7 IOMMUs requires
  DTS nodes, hwmod data and pdata quirks needed for reset management.
  The DRA7 logs therefore do not list any MMUs and the OMAP IOMMU driver
  is not registered even due to the absence of any compatible DT nodes.

This series also had a supplementary DTS patch series previously [6], and
I will be reposting those as well after rebasing for Tony to pick them up
through the linux-omap tree.

regards
Suman

[1] http://lists.linuxfoundation.org/pipermail/iommu/2015-July/013704.html
[2] https://github.com/sumananna/omap-test-iommu/blob/master/main_dt.c
[3] https://github.com/sumananna/omap-kernel/commits/iommu/test/4.3-rc3-dra7-dsp-support
[4] https://github.com/sumananna/kernel-test-logs/tree/master/4.3-rc3-dra7-dsp-support
[5] http://marc.info/?l=linux-omap&m=144356627831318&w=2
[6] http://marc.info/?l=linux-omap&m=143752332808524&w=2

Suman Anna (2):
  Documentation: dt: Update OMAP iommu bindings for DRA7 DSPs
  iommu/omap: Add support for configuring dsp iommus on DRA7xx

 .../devicetree/bindings/iommu/ti,omap-iommu.txt    | 27 ++++++++++
 drivers/iommu/omap-iommu.c                         | 58 ++++++++++++++++++++++
 drivers/iommu/omap-iommu.h                         |  9 ++++
 3 files changed, 94 insertions(+)

-- 
2.6.0
