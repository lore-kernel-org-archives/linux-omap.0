From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes against v4.2-rc1
Date: Thu, 9 Jul 2015 02:41:30 -0700
Message-ID: <20150709094130.GK10644@atomide.com>
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
To: arm@kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.2/fixes-rc1

for you to fetch changes up to ae745302c0a3e2b5b768690f631fc14db44467e7:

  Merge branch 'fixes-rc1' into omap-for-v4.2/fixes (2015-07-06 05:33:17 -0700)

----------------------------------------------------------------
Minor fixes for omaps against v4.2-rc1. Mostly just minor dts changes
except for a GPMC fix to not use names for probing devices. Also a
one liner clean-up to remove unecessary return from a void function.

The summary for the changes being:

- Fix probe for GPMC devices by reoving limitations based on device
  name

- Remove unnecessary return from a void function

- Revert beaglebone RTC sleep fix, we now have a better fix merged

- Add am4372 EMIF node to fix a warning

- Add am57xx-beagle-x15 power supply to fix USB2 if USB1 is disabled

- Disable rfbi for am4372 as it does not have a driver

----------------------------------------------------------------
Dave Gerlach (1):
      ARM: dts: am4372: Add emif node

Johan Hovold (1):
      Revert "ARM: dts: am335x-boneblack: disable RTC-only sleep"

Nicholas Krause (1):
      ARM: OMAP2+: Remove unnessary return statement from the void function, omap2_show_dma_caps

Roger Quadros (1):
      ARM: dts: am57xx-beagle-x15: Provide supply for usb2_phy2

Tomi Valkeinen (1):
      ARM: dts: am4372.dtsi: disable rfbi

Tony Lindgren (2):
      memory: omap-gpmc: Fix parsing of devices
      Merge branch 'fixes-rc1' into omap-for-v4.2/fixes

 Documentation/devicetree/bindings/memory-controllers/ti/emif.txt | 1 +
 arch/arm/boot/dts/am335x-boneblack.dts                           | 4 ++++
 arch/arm/boot/dts/am4372.dtsi                                    | 7 +++++++
 arch/arm/boot/dts/am57xx-beagle-x15.dts                          | 4 ++++
 arch/arm/mach-omap2/dma.c                                        | 1 -
 drivers/memory/omap-gpmc.c                                       | 8 +-------
 6 files changed, 17 insertions(+), 8 deletions(-)
