From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] defconfig refresh for multi_v7_defconfig for v5.1
Date: Tue, 16 Apr 2019 09:13:37 -0700
Message-ID: <pull-1555425463-418342@atomide.com>
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
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Thierry Reding <thierry.reding@gmail.com>, Olof Johansson <olof@lixom.net>, Simon Horman <horms+renesas@verge.net.au>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/multi-v7-defconfig-for-v5.2-signed

for you to fetch changes up to 35f8e2e29e74bb7197419d7cd80df5584e2a6311:

  ARM: multi_v7_defconfig: Update for moved options (2019-04-16 07:05:07 -0700)

----------------------------------------------------------------
Update multi_v7_defconfig for dropped and moved options

This series of two patches first updates multi_v7_defconfig for
dropped options, and then updates it for moved options. We want to
do this on regular basis to make it easier to patch multi_v7_defconfig
without introducing errors and merge conflicts. We update the defconfig
in two patches to make sure we're not accidentally losing any needed
options.

After this, updating multi_v7_defconfig will become trivial, and most
likely only a small follow-up patches are needed after the merge window
to update it again for moved options.

----------------------------------------------------------------
Tony Lindgren (2):
      ARM: multi_v7_defconfig: Update for dropped options
      ARM: multi_v7_defconfig: Update for moved options

 arch/arm/configs/multi_v7_defconfig | 132 +++++++++++++++++-------------------
 1 file changed, 63 insertions(+), 69 deletions(-)
