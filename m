From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/4] dts changes for omaps for v5.6
Date: Tue,  7 Jan 2020 10:14:17 -0800
Message-ID: <pull-1578420398-290837@atomide.com-2>
References: <pull-1578420398-290837@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1578420398-290837@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: soc@kernel.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.6/dt-signed

for you to fetch changes up to bfe0237dd6c441f0ba531755ab24579eaee99be7:

  ARM: dts: am335x-icev2: Add support for OSD9616P0899-10 at i2c0 (2019-12-12 09:35:02 -0800)

----------------------------------------------------------------
Devicetree changes for omaps for v5.6 merge window

Devicetree changes for omaps for v5.6 to configure more
devices and update boards to use generic lcd panels:

- Configure HDMI for dra76-evm and am57xx-idk

- Correct node name for am3517 mdio

- Convert am335x-evm, am335x-evmsk, and am335x-icev2 to use generic
  panels

----------------------------------------------------------------
Grygorii Strashko (1):
      ARM: dts: omap3: name mdio node properly

Jyri Sarha (3):
      ARM: dts: am335x-evm: Use drm simple-panel instead of tilcdc-panel
      ARM: dts: am335x-evmsk: Use drm simple-panel instead of tilcdc-panel
      ARM: dts: am335x-icev2: Add support for OSD9616P0899-10 at i2c0

Tomi Valkeinen (2):
      ARM: dts: dra76-evm: add HDMI output
      ARM: dts: am57xx-idk-common: add HDMI to the common dtsi

 arch/arm/boot/dts/am335x-evm.dts         | 40 +++++++------------
 arch/arm/boot/dts/am335x-evmsk.dts       | 38 ++++++------------
 arch/arm/boot/dts/am335x-icev2.dts       | 13 +++++++
 arch/arm/boot/dts/am3517.dtsi            |  2 +-
 arch/arm/boot/dts/am57xx-idk-common.dtsi | 59 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/dra76-evm.dts          | 66 ++++++++++++++++++++++++++++++++
 6 files changed, 164 insertions(+), 54 deletions(-)
