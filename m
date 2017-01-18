From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes for v4.10-rc4
Date: Tue, 17 Jan 2017 16:12:09 -0800
Message-ID: <28045.9444191822$1505296723@news.gmane.org>
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
To: arm@kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit 1a38de880992764d4bd5bccbd306b87d860e377d:

  ARM: dts: am572x-idk: Add gpios property to control PCIE_RESETn (2016-12-30 10:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.10/fixes-rc4

for you to fetch changes up to 1ea6af3216b092ec97129ac81bd95cf254c4b140:

  ARM: dts: omap3: Fix Card Detect and Write Protect on Logic PD SOM-LV (2017-01-17 13:50:55 -0800)

----------------------------------------------------------------
Fixes for omaps for v4.10-rc cycle. Mostly a DMA regression fix for
omap1, and then a handful of trivial fixes for boards and devices to
work:

- Fixes TI wilink bluetooth strange platform data baud rate

- Remove duplicate pinmux line for am335x-icev2

- Fix omap1 dma regression

- Fix uninitialized return value for wkup_m3_ipc_probe()

- Fix Ethernet PHY binding typo for dra72-evm

- Fix init for omap5 and dra7 sata ports

- Fix mmc card detect pin for Logic PD SOM-LV

----------------------------------------------------------------
Adam Ford (2):
      ARM: OMAP2+: Fix WL1283 Bluetooth Baud Rate
      ARM: dts: omap3: Fix Card Detect and Write Protect on Logic PD SOM-LV

Jean-Jacques Hiblot (1):
      ARM: dts: OMAP5 / DRA7: indicate that SATA port 0 is available.

Lokesh Vutla (1):
      ARM: dts: am335x-icev2: Remove the duplicated pinmux setting

Peter Ujfalusi (1):
      ARM: OMAP1: DMA: Correct the number of logical channels

Sekhar Nori (1):
      ARM: dts: dra72-evm-revc: fix typo in ethernet-phy node

Wei Yongjun (1):
      soc: ti: wkup_m3_ipc: Fix error return code in wkup_m3_ipc_probe()

 arch/arm/boot/dts/am335x-icev2.dts               |  1 -
 arch/arm/boot/dts/dra7.dtsi                      |  1 +
 arch/arm/boot/dts/dra72-evm-revc.dts             |  2 +-
 arch/arm/boot/dts/logicpd-som-lv-37xx-devkit.dts | 11 +++--------
 arch/arm/boot/dts/omap5.dtsi                     |  1 +
 arch/arm/mach-omap1/dma.c                        | 16 +++++++---------
 arch/arm/mach-omap2/pdata-quirks.c               |  2 +-
 drivers/soc/ti/wkup_m3_ipc.c                     |  1 +
 8 files changed, 15 insertions(+), 20 deletions(-)
