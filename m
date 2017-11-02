From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] two omap regression fixes
Date: Thu,  2 Nov 2017 12:55:33 -0700
Message-ID: <pull-1509652473-291160@atomide.com>
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

The following changes since commit 4afa616ce937f88d9a69a71b8c561551596a81e3:

  ARM: dts: am43xx-epos-evm: Remove extra CPSW EMAC entry (2017-09-19 10:59:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.14/fixes-rc7-signed

for you to fetch changes up to 6301d58477bc11116c78c9542871f27ae374278d:

  ARM: OMAP2/3: CM: fix cm_split_idlest functionality (2017-10-30 09:14:55 -0700)

----------------------------------------------------------------
Two regression fixes for omap3 to fix mmc3 issues noticed on nokia n9.

These have been broken for a few months and we don't have the LCD yet
functional on n9. So these can wait for the merge window if considered
too late for the -rc cycle at this point.

----------------------------------------------------------------
Tero Kristo (2):
      ARM: OMAP3: hwmod_data: add missing module_offs for MMC3
      ARM: OMAP2/3: CM: fix cm_split_idlest functionality

 arch/arm/mach-omap2/cm_common.c            | 6 +++++-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 1 +
 arch/arm/mach-omap2/prcm-common.h          | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)
