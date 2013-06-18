From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 5/7] omap board changes for v3.11 merge window
Date: Tue, 18 Jun 2013 11:07:26 -0700
Message-ID: <E1Up0KN-0007sQ-Ny@merlin.infradead.org>
References: <pull-1371578847-800598>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1371578847-800598>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit 7d132055814ef17a6c7b69f342244c410a5e000f:

  Linux 3.10-rc6 (2013-06-15 11:51:07 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.11/board-signed

for you to fetch changes up to 45853507c9362b0bd606b37e8c7c7e7551caa78b:

  ARM: omap2plus_defconfig: enable USB_PHY and NOP_USB_XCEIV (2013-06-18 03:19:07 -0700)

----------------------------------------------------------------
Minor board changes for v3.11 merge window. These are
tapering down finally as we're getting closer to making
omap2+ DT only.

----------------------------------------------------------------
Aaro Koskinen (1):
      ARM: OMAP1: nokia770: enable Tahvo

Adrien Verg (1):
      ARM: omap2plus_defconfig: enable USB_PHY and NOP_USB_XCEIV

Florian Vaussard (1):
      arm: omap: board-overo: reset GPIO for SMSC911x

Lokesh Vutla (1):
      ARM: OMAP3EVM: Marking omap3_evm_display_init() with CONFIG_BROKEN

 arch/arm/configs/omap2plus_defconfig |  2 ++
 arch/arm/mach-omap1/board-nokia770.c | 10 ++++++++++
 arch/arm/mach-omap2/board-omap3evm.c |  4 ++++
 arch/arm/mach-omap2/board-overo.c    |  3 ++-
 4 files changed, 18 insertions(+), 1 deletion(-)
