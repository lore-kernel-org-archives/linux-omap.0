From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/2] omap soc fix for v4.3 merge window
Date: Thu, 13 Aug 2015 03:08:45 -0700
Message-ID: <31420.2355723411$1439460611@news.gmane.org>
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

The following changes since commit 24da741c678f865de3182194604dbddcc7fc7f3c:

  Merge branch 'dm814x-soc' into omap-for-v4.3/soc (2015-07-23 21:59:18 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.3/soc-pt2

for you to fetch changes up to ed293d1ad2b0c28b6abc3bd728b07754bc00f1cd:

  memory: kill off set_irq_flags usage (2015-08-13 00:48:52 -0700)

----------------------------------------------------------------
Fix omap PM regression in Linux next and kill set_irq_flags usage
for GPMC.

----------------------------------------------------------------
Rob Herring (1):
      memory: kill off set_irq_flags usage

Tony Lindgren (1):
      ARM: OMAP2+: Fix power domain operations regression caused by 81xx

 arch/arm/mach-omap2/powerdomains3xxx_data.c | 6 +++++-
 drivers/memory/omap-gpmc.c                  | 5 ++---
 2 files changed, 7 insertions(+), 4 deletions(-)
