From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/2] dts changes for ti-sysc driver for v5.2
Date: Mon, 15 Apr 2019 10:00:54 -0700
Message-ID: <pull-1555343712-332506@atomide.com-2>
References: <pull-1555343712-332506@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1555343712-332506@atomide.com>
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

The following changes since commit d59b60564cbfe77d85c2f51b29941d8ed14984d1:

  bus: ti-sysc: Add generic enable/disable functions (2019-04-09 08:58:48 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.2/dt-ti-sysc-signed

for you to fetch changes up to b2770b2d6f1b4d33e919fc2a9ccf536efedc1e40:

  ARM: dts: Add l4 abe interconnect hierarchy and ti-sysc data for omap5 (2019-04-09 09:00:54 -0700)

----------------------------------------------------------------
Devicetree changes for omap4 and 5 l4 abe interconnect

This series of devicetree changes adds the l4 abe interconnect devices
and moves the devices to their right places in the hierarchy similar
to what we've already done for most l4 devices earlier. We first add
a shared omap4-mcpdm.dtsi to make adding omap4-l4-abe.dtsi easier for
the mcpdm changes. And as earlier, in case of unexpected trouble,
devices can be probed the old way by moving one device at a time to the
old place.

This series of changes depends on the ti-sysc driver changes for handling
the external optional clocks that the mcpdm relies on, and is based on
the related ti-sysc driver changes. Note that this series does not depend
on dropping of the leagcy platform data, but I already had those committed
along with the ti-sysc driver changes and noticed too late.

----------------------------------------------------------------
Tony Lindgren (3):
      ARM: dts: Add common mcpdm dts file for omap4
      ARM: dts: Add l4 abe interconnect hierarchy and ti-sysc data for omap4
      ARM: dts: Add l4 abe interconnect hierarchy and ti-sysc data for omap5

 arch/arm/boot/dts/omap4-duovero.dtsi      |  21 +-
 arch/arm/boot/dts/omap4-l4-abe.dtsi       | 501 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap4-mcpdm.dtsi        |  44 +++
 arch/arm/boot/dts/omap4-panda-common.dtsi |  21 +-
 arch/arm/boot/dts/omap4-sdp.dts           |  21 +-
 arch/arm/boot/dts/omap4-var-som-om44.dtsi |  21 +-
 arch/arm/boot/dts/omap4.dtsi              | 192 +-----------
 arch/arm/boot/dts/omap5-board-common.dtsi |   8 +-
 arch/arm/boot/dts/omap5-l4-abe.dtsi       | 447 ++++++++++++++++++++++++++
 arch/arm/boot/dts/omap5.dtsi              | 115 +------
 10 files changed, 1011 insertions(+), 380 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap4-l4-abe.dtsi
 create mode 100644 arch/arm/boot/dts/omap4-mcpdm.dtsi
 create mode 100644 arch/arm/boot/dts/omap5-l4-abe.dtsi
