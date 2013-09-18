From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/2] omap dt fixes against v3.12-rc1
Date: Wed, 18 Sep 2013 13:59:02 -0700
Message-ID: <E1VMOqb-0007Bt-My@merlin.infradead.org>
References: <pull-1379537942-109201>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1379537942-109201>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: arm@kernel.org, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@linaro.org>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:

  Linux 3.12-rc1 (2013-09-16 16:17:51 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.12/fixes-dt-signed

for you to fetch changes up to 45bea1d39a956619881315e20bdf52c8a702be03:

  Merge tag 'for_3.12-rc2/dts_signed' of git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt into omap-for-v3.12/fixes-dt (2013-09-18 12:50:45 -0700)

----------------------------------------------------------------

omap device tree changes that are needed to fix
regressions and avoid electrical issues on beaglebone black.

Via Benoit Cousson <bcousson@baylibre.com>:

Fix BBB LDO voltage to avoid HDMI destruction
Fix OMAP5 wrong attribute
Fix typo in beagle xM strings
Fix missing pinmux and regulator for OMAP4 wifi
Fix missing pinmux for igep headset

----------------------------------------------------------------
Enric Balletbo i Serra (1):
      ARM: dts: igep00x0: Add pinmux configuration for MCBSP2

Felipe Balbi (2):
      ARM: dts: OMAP5: fix reg property size
      ARM: dts: OMAP5: fix ocp2scp DTS data

Koen Kooi (1):
      ARM: dts: am335x-bone*: add DT for BeagleBone Black

Robert Nelson (1):
      ARM: dts: omap3-beagle-xm: fix string error in compatible property

Tony Lindgren (3):
      ARM: dts: Fix muxing and regulator for wl12xx on the SDIO bus for pandaboard
      ARM: dts: Fix muxing and regulator for wl12xx on the SDIO bus for blaze
      Merge tag 'for_3.12-rc2/dts_signed' of git://git.kernel.org/.../bcousson/linux-omap-dt into omap-for-v3.12/fixes-dt

 arch/arm/boot/dts/Makefile                |   1 +
 arch/arm/boot/dts/am335x-bone-common.dtsi | 262 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/am335x-bone.dts         | 256 +----------------------------
 arch/arm/boot/dts/am335x-boneblack.dts    |  17 ++
 arch/arm/boot/dts/omap3-beagle-xm.dts     |   2 +-
 arch/arm/boot/dts/omap3-igep.dtsi         |  14 ++
 arch/arm/boot/dts/omap4-panda-common.dtsi |  46 +++++-
 arch/arm/boot/dts/omap4-sdp.dts           |  39 ++++-
 arch/arm/boot/dts/omap5.dtsi              |   7 +-
 9 files changed, 383 insertions(+), 261 deletions(-)
 create mode 100644 arch/arm/boot/dts/am335x-bone-common.dtsi
 create mode 100644 arch/arm/boot/dts/am335x-boneblack.dts
