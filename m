From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v8 0/5] Add MCAN Support for Dra76 platform
Date: Tue, 16 Jan 2018 17:07:09 +0530
Message-ID: <1516102634-6771-1-git-send-email-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, faiz_abbas@ti.com, nsekhar@ti.com, fcooper@ti.com, robh@kernel.org, Wenyou.Yang@microchip.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, b29396@freescale.com
List-Id: linux-omap@vger.kernel.org

This patch series adds support for M_CAN on the TI Dra76
platform. Device tree patches will be sent separately.
A bunch of patches were sent before by
Franklin Cooper <fcooper@ti.com>. I have clubbed the
series together and rebased to the latest kernel.

v8 changes:
Rebased to linux-can-next/testing branch which already
has 3 patches of v7.
Changed order of the patches so that documentation comes
first.
Fixed error handling and added m_can_clk_start/stop() in
m_can_plat_probe().

patch 4 depends on patch 3.

v7 changes:
Added support for bitrate_max to be read from the netlink
interface.
Moved allocation of netdevice to probe. Cleaned up the
allocator function.
Moved enabling/disabling of clocks to pm_runtime callbacks.
Minor format changes.

patch 5 depends on patch 4 which in turn depends on patch 3.

v6 changes:
Dropped the patches to make hclk optional. Drivers
which enable hclk as the interface clock using
pm_runtime calls must still provide a hclk in the
clocks property.

Support higher speed CAN-FD bitrate:
The community decided that data sampling point be used
for the secondary sampling point here
https://patchwork.kernel.org/patch/9909845/

Faiz Abbas (2):
  can: m_can: Move allocation of net device to probe
  can: m_can: Add PM Support

Franklin S Cooper Jr (3):
  dt-bindings: can: m_can: Document new can transceiver binding
  dt-bindings: can: can-transceiver: Document new binding
  can: m_can: Support higher speed CAN-FD bitrates

 .../bindings/net/can/can-transceiver.txt           |  24 +++
 .../devicetree/bindings/net/can/m_can.txt          |   9 ++
 drivers/net/can/m_can/m_can.c                      | 168 ++++++++++++++-------
 3 files changed, 147 insertions(+), 54 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/can-transceiver.txt

-- 
2.7.4
