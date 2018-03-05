From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 5/6] omap dts changes for v4.17
Date: Mon,  5 Mar 2018 10:11:05 -0800
Message-ID: <pull-1520273005-304551@atomide.com-5>
References: <pull-1520273005-304551@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1520273005-304551@atomide.com>
In-Reply-To: <pull-1520273005-304551@atomide.com>
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
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.17/dt-signed

for you to fetch changes up to 47eee072bf90374ce98a15668e6b450de313100a:

  ARM: dts: omap4-droid4: add soundcard (2018-03-02 12:55:14 -0800)

----------------------------------------------------------------
Device tree changes for omap variants for v4.17

This series of changes updates the device tree files for omaps:

- Nokia N9 support for magnetometer

- Update at24 to use atmel as manufacturer for am335x-boneblue

- Add support for am33xx based PDU001 board

- Update Droid 4 touchscreen for reset-gpios and add audio
  codec and soundcard

- Remove unused dra7 cooling level nodes

- A series of changes to configure am335x and am437x for PM

- Add pinmuxing for i2c2 and 3 for LogicPD boards

- Add EMIF interrupt infor for am437x and am335x

- Add missing omap3 sound-dai-cells

----------------------------------------------------------------
Adam Ford (2):
      ARM: dts: Add pinmuxing for i2c2 and i2c3 for LogicPD torpedo
      ARM: dts: Add pinmuxing for i2c2 and i2c3 for LogicPD SOM-LV

Bartosz Golaszewski (1):
      ARM: dts: use 'atmel' as at24 manufacturer in am335x-boneblue

Dave Gerlach (9):
      ARM: dts: am33xx: Reserve pm code and data regions in ocmcram sram node
      ARM: dts: am4372: Reserve pm code and data regions in ocmcram sram node
      ARM: dts: am33xx: Update emif node
      ARM: dts: am4372: Update emif node
      ARM: dts: am33xx: Add pm-sram phandle to soc node
      ARM: dts: am4372: Add soc node
      ARM: dts: am33xx: Mark emif with ti,no-idle
      ARM: dts: am4372: Mark emif with ti,no-idle
      ARM: dts: am4372: Mark omap_l3_noc with ti,no-idle

Felix Brack (1):
      ARM: dts: am33xx: add PDU001 board

Pavel Machek (1):
      ARM: dts: nokia N9: Add support for magnetometer

Rob Herring (1):
      ARM: dts: omap3: Add missing #sound-dai-cells

Sebastian Reichel (3):
      ARM: dts: omap4-droid4: update touchscreen
      ARM: dts: motorola-cpcap-mapphone: add audio-codec
      ARM: dts: omap4-droid4: add soundcard

Tero Kristo (2):
      ARM: dts: am33xx: add emif interrupt info
      ARM: dts: am43xx: add emif interrupt info

Viresh Kumar (1):
      ARM: dts: omap: Remove "cooling-{min|max}-level" for CPU nodes

 arch/arm/boot/dts/Makefile                     |   1 +
 arch/arm/boot/dts/am335x-boneblue.dts          |   2 +-
 arch/arm/boot/dts/am335x-pdu001.dts            | 595 +++++++++++++++++++++++++
 arch/arm/boot/dts/am33xx.dtsi                  |  21 +
 arch/arm/boot/dts/am4372.dtsi                  |  30 ++
 arch/arm/boot/dts/dra7.dtsi                    |   2 -
 arch/arm/boot/dts/logicpd-som-lv.dtsi          |  16 +
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi     |  16 +
 arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi |  13 +
 arch/arm/boot/dts/omap3-n9.dts                 |   7 +
 arch/arm/boot/dts/omap3.dtsi                   |   1 +
 arch/arm/boot/dts/omap4-droid4-xt894.dts       | 100 ++++-
 arch/arm/boot/dts/omap443x.dtsi                |   2 -
 arch/arm/boot/dts/omap4460.dtsi                |   2 -
 arch/arm/boot/dts/omap5.dtsi                   |   2 -
 15 files changed, 785 insertions(+), 25 deletions(-)
 create mode 100644 arch/arm/boot/dts/am335x-pdu001.dts
