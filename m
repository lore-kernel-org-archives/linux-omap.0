From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] non urgent auxdata fix for v4.7 merge window
Date: Wed, 4 May 2016 10:53:07 -0700
Message-ID: <20160504175306.GU5995@atomide.com>
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

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.7/auxdata-signed

for you to fetch changes up to d4f414e559caf36d811213e56b56e9b6957caab1:

  ARM: OMAP2+: Simplify auxdata by using the generic match (2016-04-15 08:47:07 -0700)

----------------------------------------------------------------
Device tree auxdata handling fix that allows a match based on the
compatible string if no exact match based on the IO address is found.

This leaves out the need to patch auxdata for each driver when adding
new SoCs. And it also reprotedly fixes the issue of passing auxdata
to a child if the parent instantiates the child from DT as discussed
in the "[PATCH] of/platform: Allow secondary compatible match in
of_dev_lookup" mailing list thread.

As a minimal use case, let's also convert omap pinctrl auxdatato
use a generic match.

There is no need to get this in to the v4.6-rc cycle and it can wait
for v4.7 merge window. Note that these changes have now been sitting
in Linux next for about two weeks so far as I wanted to make sure no
new issues are popping up.

----------------------------------------------------------------
Tony Lindgren (2):
      of/platform: Allow secondary compatible match in of_dev_lookup
      ARM: OMAP2+: Simplify auxdata by using the generic match

 arch/arm/mach-omap2/pdata-quirks.c | 17 ++---------------
 drivers/of/platform.c              | 28 +++++++++++++++++++++++-----
 2 files changed, 25 insertions(+), 20 deletions(-)
