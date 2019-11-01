From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] prm reset control dts changes for omaps for v5.5
Date: Fri,  1 Nov 2019 08:46:45 -0700
Message-ID: <pull-1572623173-281197@atomide.com>
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
To: soc@kernel.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit 5478f912d225a1745a4b3d5f564daa0004d35a42:

  soc: ti: omap-prm: add omap5 PRM data (2019-10-09 08:55:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.5/prm-signed

for you to fetch changes up to a868da75fd8f925caaf7f5381b2dccff2a244986:

  ARM: dts: omap5: Add PRM data (2019-10-10 07:22:36 -0700)

----------------------------------------------------------------
PRM reset control dts changes for v5.5 merge window

This series of changes adds the PRM reset driver nodes for am3/4, omap4/5
and dra7 SoCs. The reset driver changes make it easier to add support for
various accelerators for TI SoCs in a more generic way.

Note that this branch is based on the PRM reset driver changes branch.

----------------------------------------------------------------
Tero Kristo (5):
      ARM: dts: dra7: add PRM nodes
      ARM: dts: omap4: add PRM nodes
      ARM: dts: am33xx: Add PRM data
      ARM: dts: am43xx: Add PRM data
      ARM: dts: omap5: Add PRM data

 arch/arm/boot/dts/am33xx.dtsi   | 26 +++++++++++++++++++++
 arch/arm/boot/dts/am4372.dtsi   | 26 +++++++++++++++++++++
 arch/arm/boot/dts/dra7.dtsi     | 51 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap4-l4.dtsi |  2 +-
 arch/arm/boot/dts/omap4.dtsi    | 26 +++++++++++++++++++++
 arch/arm/boot/dts/omap5.dtsi    | 26 +++++++++++++++++++++
 6 files changed, 156 insertions(+), 1 deletion(-)
