From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/2] omap devicetree changes for v4.12, part 2
Date: Mon, 10 Apr 2017 12:46:06 -0700
Message-ID: <14810.7807072394$1505299324@news.gmane.org>
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

The following changes since commit da72e4936445e1081e1223fc58470644da8e8cdb:

  Merge branch 'omap-for-v4.12/dt-droid4-v2' into omap-for-v4.12/dt-v2 (2017-03-28 14:00:55 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.12/dt-pt2-signed

for you to fetch changes up to b4e1566e4c5e9fcaf9e17ad741b6094b4f3ddce5:

  Merge branch 'omap-for-v4.12/dt-droid4-v2' into omap-for-v4.12/dt-v2 (2017-04-09 16:35:51 -0700)

----------------------------------------------------------------
Second set of devicetree changes for omaps for v4.12 merge window
to configure various devices:

- Enable DCAN on am57xx-idk

- Enable CPSW ethernet0 and 1 on am335x-icev2

- Non-critical fix for droid 4 PMIC interrupt triggering

- Stop disabling SRAM and GPMC on droid 4

- Configure CPCAP PMIC related devices on droid 4 for ADC, charger
  and USB PHY. The charger and USB PHY drivers are still being
  discussed, but the binding for them has been acked by Rob and
  Sebastian so they should be safe to merge together with the ADC
  driver in Linux next that they depend on

----------------------------------------------------------------
Roger Quadros (1):
      ARM: dts: am335x-icev2: Add CPSW ethernet0 and ethernet1

Schuyler Patton (1):
      ARM: dts: am57xx-idk: Add DCAN support

Tony Lindgren (6):
      ARM: dts: omap4-droid4: Fix interrupt triggering for cpcap
      ARM: dts: omap4-droid4: Stop disabling SRAM and GPMC
      ARM: dts: omap4-droid4: Add CPCAP PMIC ADC configuration
      ARM: dts: omap4-droid4: Add CPCAP PMIC battery charger configuration
      ARM: dts: omap4-droid4: Add CPCAP PMIC OTG PHY configuration
      Merge branch 'omap-for-v4.12/dt-droid4-v2' into omap-for-v4.12/dt-v2

 arch/arm/boot/dts/am335x-icev2.dts             | 121 +++++++++++++++++++++++++
 arch/arm/boot/dts/am57xx-idk-common.dtsi       |  24 +++++
 arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi |  51 ++++++++++-
 arch/arm/boot/dts/omap4-droid4-xt894.dts       |  13 +--
 4 files changed, 196 insertions(+), 13 deletions(-)
