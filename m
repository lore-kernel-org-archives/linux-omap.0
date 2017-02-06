From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] few omap late dts changes for v4.11 merge window
Date: Mon,  6 Feb 2017 09:02:01 -0800
Message-ID: <4993.31603427908$1505297359@news.gmane.org>
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

The following changes since commit d8e166b4ad0e3626af0378cadb2d7ba41efa005a:

  ARM: dts: dra72/1-evm: add pcf8575 used for lcd (2017-01-23 11:01:13 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.11/dt-late

for you to fetch changes up to 53225f638b100475984b9f227ce27385e6bb473e:

  ARM: dts: am335x-chiliboard: Support charger (2017-02-02 09:46:30 -0800)

----------------------------------------------------------------
Few more late dts changes for omaps for v4.11 merge window:

- Add support for phyCORE-AM335x PCM-953 carrier board

- Add power button and charger support for am335x-chiliboard

----------------------------------------------------------------
Marcin Niestroj (2):
      ARM: dts: am335x-chiliboard: Support power button
      ARM: dts: am335x-chiliboard: Support charger

Teresa Remmet (1):
      ARM: dts: Add support for phyCORE-AM335x PCM-953 carrier board

 .../devicetree/bindings/arm/omap/omap.txt          |   3 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/am335x-chiliboard.dts            |  16 ++
 arch/arm/boot/dts/am335x-pcm-953.dtsi              | 288 +++++++++++++++++++++
 arch/arm/boot/dts/am335x-phycore-rdk.dts           |  27 ++
 5 files changed, 335 insertions(+)
 create mode 100644 arch/arm/boot/dts/am335x-pcm-953.dtsi
 create mode 100644 arch/arm/boot/dts/am335x-phycore-rdk.dts
