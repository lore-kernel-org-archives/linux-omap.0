From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: [GIT PULL] ARM: OMAP: hwmod fix for 3.2-rc3
Date: Wed, 16 Nov 2011 17:02:05 +0100
Message-ID: <4EC3DE7D.9050609@ti.com>
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
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

That bug is becoming annoying, and a bunch of folks are hitting that issue during DT dev for 3.3, so it will be cool to fix that ASAP.

It might already be in Paul's queue for 3.2-rc3.

Thanks,
Benoit


The following changes since commit 6aaf05f472c97ebceff47d9eef464574f1a55727:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://git390.marist.edu/pub/scm/linux-2.6

are available in the git repository at:

  git://gitorious.org/omap-pm/linux.git for_3.2-rc/hwmod-fixes

sricharan (1):
      ARM: OMAP: hwmod: Fix the addr space, irq, dma count APIs

 arch/arm/mach-omap2/omap_hwmod.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)
