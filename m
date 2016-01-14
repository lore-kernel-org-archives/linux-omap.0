From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 0/3] dra7xx: get pcie working in mainline
Date: Thu, 14 Jan 2016 19:41:09 +0530
Message-ID: <1452780672-14339-1-git-send-email-kishon@ti.com>
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
To: Tony Lindgren <tony@atomide.com>, Bjorn Helgaas <bhelgaas@google.com>, richardcochran@gmail.com
Cc: Russell King <linux@arm.linux.org.uk>, nsekhar@ti.com, linux-kernel@vger.kernel.org, kishon@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This series adds pdata-quirk mechanism to reset PCIe as a temporary
fix till reset controller driver is added in mainline.

Without this series, a stall is observed if pci dra7xx driver
is enabled.

Changes from v2:
*) Now assert reset line during driver removal (will be useful
   when module insert/removal functionality is added)
*) Added kernel-doc comments for pci_dra7xx_platform_data
*) Better commit logs
*) Misc cleanup

Changes from v1:
*) Removed 'HACK' from $subject
*) removed reviewed-by Suman

Kishon Vijay Abraham I (3):
  ARM: DRA7: hwmod: Add reset data for PCIe
  ARM: DRA7: add pdata-quirks to do reset of PCIe
  pci: dra7xx: use pdata callbacks to perform reset

 arch/arm/mach-omap2/omap_hwmod_7xx_data.c |   15 +++++++
 arch/arm/mach-omap2/pdata-quirks.c        |   11 +++++
 arch/arm/mach-omap2/prm7xx.h              |    1 +
 drivers/pci/host/pci-dra7xx.c             |   66 +++++++++++++++++++++++++++++
 include/linux/platform_data/pci-dra7xx.h  |   29 +++++++++++++
 5 files changed, 122 insertions(+)
 create mode 100644 include/linux/platform_data/pci-dra7xx.h

-- 
1.7.9.5
