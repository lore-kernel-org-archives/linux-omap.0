From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 0/2] PCIe related fixes for DRA7xx
Date: Tue, 16 Dec 2014 14:52:49 +0530
Message-ID: <1418721771-31184-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Kishon Vijay Abraham I <kishon@ti.com>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org

This patch fix inconsistent enumeration of PCIe gen2 cards on DRA7xx
boards. Tested this patch series, after applying some out of the
tree patches for resetting PCIe.

Vignesh R (2):
  phy: phy-ti-pipe3: fix inconsistent enumeration of PCIe gen2 cards
  ARM: dts: DRA7X: drop id property in pcie_phy

 arch/arm/boot/dts/dra7.dtsi          |  2 --
 drivers/phy/phy-omap-control.c       |  7 +++----
 drivers/phy/phy-ti-pipe3.c           | 10 ++++++----
 include/linux/phy/omap_control_phy.h |  6 +++---
 4 files changed, 12 insertions(+), 13 deletions(-)

-- 
1.9.1
