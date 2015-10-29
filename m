From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] two omap regression fixes for v4.3-rc cycle
Date: Thu, 29 Oct 2015 13:18:30 -0700
Message-ID: <20151029201829.GF3078@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
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

The following changes since commit 57df5380853460bc66b59a46273ce113c923d39c:

  ARM: OMAP2+: Fix imprecise external abort caused by bogus SRAM init (2015-10-19 08:55:46 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.3/fixes-rc7

for you to fetch changes up to 8f2279d5d908119a08e906be1c6b69c744d0c379:

  usb: musb: omap2430: Fix regression caused by driver core change (2015-10-28 10:16:04 -0700)

----------------------------------------------------------------
Two omap regression fixes:

- Fix omap3 MUSB with DMA caused by driver core changes

- Fix LCD DMA interrupt number for omap1 that did not
  get changed for sparse IRQ changes

----------------------------------------------------------------
Aaro Koskinen (1):
      ARM: OMAP1: fix incorrect INT_DMA_LCD

Tony Lindgren (1):
      usb: musb: omap2430: Fix regression caused by driver core change

 drivers/usb/musb/omap2430.c | 29 +++++++++++++++++++++++------
 include/linux/omap-dma.h    |  2 +-
 2 files changed, 24 insertions(+), 7 deletions(-)
