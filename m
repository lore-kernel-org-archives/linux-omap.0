From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/2] omap defconfig changes for v4.15 merge window
Date: Mon, 30 Oct 2017 09:41:13 -0700
Message-ID: <pull-1509381562-551838@atomide.com>
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

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.15/defconfig-signed

for you to fetch changes up to 5b2f8c83250b3f699757249424b2e77ad50750c3:

  ARM: omap2plus: Run make savedefconfig again to save some space (2017-10-25 09:50:51 -0700)

----------------------------------------------------------------
Few omap2plus_defconfig changes for v4.15 merge window to enable NEON
based crypto and droid 4 USB PHY. Also let's run savedefconfig again
to save a bit of space and make it easier for people to send patches
against omap2plus_defconfig.

----------------------------------------------------------------
Ard Biesheuvel (1):
      ARM: omap2plus_defconfig: enable NEON based crypto

Tony Lindgren (2):
      ARM: omap2plus_defconfig: Enable droid 4 USB PHY
      ARM: omap2plus: Run make savedefconfig again to save some space

 arch/arm/configs/omap2plus_defconfig | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)
