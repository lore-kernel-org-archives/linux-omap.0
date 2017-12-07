From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] two dts compiler warning fixes for v4.15-rc cycle
Date: Thu,  7 Dec 2017 13:19:59 -0800
Message-ID: <pull-1512681573-431149@atomide.com>
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
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.15/fixes-dt-warnings

for you to fetch changes up to c22fe696157dc94a25cc5396b43b29b6d6f4a189:

  ARM: dts: Fix dm814x missing phy-cells property (2017-12-05 08:29:04 -0800)

----------------------------------------------------------------
Two fixes for dts compiler warnings

These recently started showing up with better dtc checks being
introduced.

----------------------------------------------------------------
Tony Lindgren (2):
      ARM: dts: Fix elm interrupt compiler warning
      ARM: dts: Fix dm814x missing phy-cells property

 arch/arm/boot/dts/dm814x.dtsi | 1 +
 arch/arm/boot/dts/omap4.dtsi  | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)
