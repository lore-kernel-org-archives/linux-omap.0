From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/2] omap fixes for v3.10 merge window part2
Date: Thu, 9 May 2013 11:46:51 -0700
Message-ID: <27947.7908778519$1368125252@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit 956e46efb2478ebff7a871138458fa8124fd18dd:

  mm/slab: Fix crash during slab init (2013-05-08 15:02:33 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.10/fixes-for-merge-window-part2

for you to fetch changes up to b1dd11d60e5357c13d3f3decfb69bd07dde159bd:

  ARM: OMAP2+: Remove bogus IS_ERR_OR_NULL checking from id.c (2013-05-09 09:06:27 -0700)

----------------------------------------------------------------
Omap fixes for things that were discovered during the merge window:

- Few GPMC fixes and binding doc updates noted after sending
  pull requests for the GPMC branch.

- Board fixes for beagle usb host and rx51 spi probe order

- SoC fixes dt earlyprintk, omap1 dma and omap2+ id.c error
  handling fixes

Then few minor things that are not strictly fixes but are good
to get out of the way:

- Add missing legacy mux registers for am/dm73x gpio

- Add detection for am33xx pg2.1 silicon

- Enable twl4030 audio modules in defconfig

----------------------------------------------------------------
Aaro Koskinen (1):
      ARM: OMAP: RX-51: change probe order of touchscreen and panel SPI devices

Christoph Fritz (1):
      omap: mux: add AM/DM37x gpios

Javier Martinez Canillas (3):
      Documentation: dt: update TI GPMC ethernet binding properties
      ARM: OMAP2+: only search for GPMC DT child nodes on probe
      ARM: OMAP2+: only WARN if a GPMC child probe function fail

Jon Hunter (1):
      Documentation: dt: update properties in TI GPMC NAND example

Kevin Hilman (1):
      ARM: OMAP2+: omap_device: use late_initcall_sync

Peter Ujfalusi (1):
      ARM: OMAP4+: omap2plus_defconfig: Enable audio via TWL6040 as module

Roger Quadros (1):
      ARM: OMAP3: Beagle: Fix USB Host on beagle xM Ax/Bx

Tony Lindgren (2):
      Merge branch 'omap-gpmc-fixes-for-v3.10' of git://github.com/jonhunter/linux into fixes
      ARM: OMAP2+: Remove bogus IS_ERR_OR_NULL checking from id.c

Vaibhav Hiremath (1):
      ARM: OMAP2: AM33XX: id: Add support for new AM335x PG2.1 Si

Wei Yongjun (1):
      ARM: OMAP1: DMA: fix error handling in omap1_system_dma_init()

 .../devicetree/bindings/mtd/gpmc-nand.txt          | 28 +++++------
 Documentation/devicetree/bindings/net/gpmc-eth.txt | 56 +++++++++++-----------
 arch/arm/configs/omap2plus_defconfig               |  2 +
 arch/arm/mach-omap1/dma.c                          |  8 ++--
 arch/arm/mach-omap2/board-omap3beagle.c            |  6 +--
 arch/arm/mach-omap2/board-rx51-peripherals.c       |  4 +-
 arch/arm/mach-omap2/gpmc.c                         | 38 +++++----------
 arch/arm/mach-omap2/id.c                           | 13 +++--
 arch/arm/mach-omap2/mux34xx.h                      |  6 ++-
 arch/arm/mach-omap2/omap_device.c                  |  2 +-
 arch/arm/mach-omap2/soc.h                          |  2 +
 11 files changed, 81 insertions(+), 84 deletions(-)
